//
//  NJLoginViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/10/18.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJLoginViewController.h"
#import "NJRegisterViewController.h"
#import "NJRetrievePasswordViewController.h"
#import "UIColor+GSColor.h"
#import "NJHomeViewController.h"
#import "TSConst.h"
#import "NJLoginManager.h"
#import "MBProgressHUD+LYHud.h"
#import <CommonCrypto/CommonDigest.h>
#import "NJLoginModel.h"
#import "NJBannerDetailsViewController.h"
#import "NJMineViewController.h"
#import "MainNavigationViewController.h"
#import "NJTabBarViewController.h"
#import "NJHomeViewController.h"
#import "NJShopCarViewController.h"
#import "NJClassifyViewController.h"
#import "NJMarketViewController.h"

#define APP_WINDOW [[[UIApplication sharedApplication]delegate]window]
@interface NJLoginViewController ()<UIGestureRecognizerDelegate,UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *passWordView;
@property (weak, nonatomic) IBOutlet UITextField *passWord;

//@property (nonatomic, assign) BOOL isAutoLogin;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (nonatomic, strong) NJLoginModel *model;
@property (weak, nonatomic) id<UIGestureRecognizerDelegate> restoreInteractivePopGestureDelegate;
@end

@implementation NJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _restoreInteractivePopGestureDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
    self.userNameView.backgroundColor = [UIColor colorWithRed:155.0f/255.0f green:87.0f/255.0f blue:1.0f/255.0f alpha:1];
    self.passWordView.backgroundColor = [UIColor colorWithRed:155.0f/255.0f green:87.0f/255.0f blue:1.0f/255.0f alpha:1];
    [self.sureButton setBackgroundColor:[UIColor colorWithRed:155.0f/255.0f green:87.0f/255.0f blue:1.0f/255.0f alpha:1]];
    
    
    [self.userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.passWord setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    
}

- (IBAction)registerTo:(id)sender {
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    NSString *urlStr = @"/member/register";
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = _restoreInteractivePopGestureDelegate;
    };
    
}
#pragma mark -UIGestureRecognizerDelegate
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)forgetPassword:(id)sender {
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    NSString *urlStr = @"/password/forgot?type=MEMBER";
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (IBAction)loginTo:(id)sender {
    NSString *name = [self.userName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *psd = [self.passWord.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *passWord = [self md5:psd];
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
        self.model = object;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

        [userDefaults setBool:YES forKey:kLoginSuccess];
        [userDefaults setObject:name forKey:kUserName];
        [userDefaults setObject:passWord forKey:kPassword];
        [userDefaults synchronize];

        [hud hideAnimated:YES];
        
//        NJMineViewController *mineVC = [[NJMineViewController alloc]init];
//        mineVC.title = @"会员中心";
//        mineVC.hidesBottomBarWhenPushed = NO;
//        [self.navigationController pushViewController:mineVC animated:YES];
        
        NJHomeViewController *homeVC = [[NJHomeViewController alloc] init];
        MainNavigationViewController *homeNav = [[MainNavigationViewController alloc] initWithRootViewController:homeVC];
        homeNav.tabBarItem.image = [UIImage imageNamed:@"home"];
        homeVC.title = @"首页";
        
        NJMarketViewController *marketVC = [[NJMarketViewController alloc] init];
        MainNavigationViewController *marketNav = [[MainNavigationViewController alloc] initWithRootViewController:marketVC];
        marketNav.tabBarItem.image = [UIImage imageNamed:@"market"];
        marketVC.title = @"行情";
        
        NJClassifyViewController *classifyVC = [[NJClassifyViewController alloc] init];
        MainNavigationViewController *classifyNav = [[MainNavigationViewController alloc] initWithRootViewController:classifyVC];
        classifyNav.tabBarItem.image = [UIImage imageNamed:@"classify"];
        classifyVC.title = @"选油";
        
        NJShopCarViewController *shopCarVC = [[NJShopCarViewController alloc] init];
        MainNavigationViewController *shopCarNav = [[MainNavigationViewController alloc] initWithRootViewController:shopCarVC];
        shopCarNav.tabBarItem.image = [UIImage imageNamed:@"shopCar"];
        shopCarVC.title = @"购物车";
        
        NJMineViewController *mineVC = [[NJMineViewController alloc] init];
        MainNavigationViewController *mineNav = [[MainNavigationViewController alloc] initWithRootViewController:mineVC];
        mineNav.tabBarItem.image = [UIImage imageNamed:@"mine"];
        mineVC.title = @"会员中心";
        
        NJTabBarViewController *tabVC = [[NJTabBarViewController alloc] init];
        tabVC.delegate = self;
        [tabVC setViewControllers:@[homeNav,marketNav,classifyNav,shopCarNav,mineNav]];
        tabVC.tabBar.tintColor = [UIColor orangeColor];
        tabVC.tabBar.backgroundImage = [self createImageWithColor:[UIColor colorWithRed:45.0f/255.0f green:45.0f/255.0f blue:45.0f/255.0f alpha:1]];
        
        APP_WINDOW.rootViewController = tabVC;
        
        
    } errorHandler:^(NSString *errorString) {
        [hud showIndeterminaToText:errorString];
    }];
}
- (UIImage *) createImageWithColor: (UIColor *) color

{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return myImage;
    
}
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
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
