//
//  NJMarketDetailsViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/13.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMarketDetailsViewController.h"
#import "UIColor+GSColor.h"
#import "Marco.h"
#import "NJMarketManager.h"
#import "NJMarketModel.h"
#import "MBProgressHUD+LYHud.h"

@interface NJMarketDetailsViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (assign, nonatomic) BOOL isFinishLoad;
@property (strong, nonatomic) NJMarketModel *model;
@end

@implementation NJMarketDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.scalesPageToFit = YES;
    
    self.webView.delegate = self;
    
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJMarketManager getMarketDetailsId:self.type_id successHandler:^(id object) {
        self.model = object;
        NSString *urlString = self.model.content;
        self.title = self.model.title;
        [self.webView loadHTMLString:urlString baseURL:nil];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        [hud showIndeterminaToText:errorString];
    }];
}
- (void)loadProgress:(NSTimer *)timer {
    if (self.isFinishLoad) {
        if (self.progressView.progress >= 1.0) {
            self.progressView.hidden = YES;
            [timer invalidate];
            timer = nil;
        } else {
            self.progressView.progress += 0.1;
        }
    } else {
        self.progressView.progress += 0.0005;
        if (self.progressView.progress >= 0.95) self.progressView.progress = 0.95;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    MLog(@"加载的url:%@", request.URL);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    MLog(@"开始加载。。。");
    self.progressView.hidden = NO;
    self.progressView.progress = 0;
    self.isFinishLoad = NO;
    [NSTimer scheduledTimerWithTimeInterval:1/60 target:self selector:@selector(loadProgress:) userInfo:nil repeats:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    MLog(@"加载完成");
    self.isFinishLoad = YES;
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    MLog(@"加载失败，失败原因：%@", [error localizedDescription]);
    self.progressView.hidden = YES;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
@end
