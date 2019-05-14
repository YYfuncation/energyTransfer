//
//  NJMarketViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/13.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMarketViewController.h"
#import "JSSegmentControl.h"
#import "Marco.h"
#import "UIColor+GSColor.h"
#import "GSPageViewController.h"
#import "NJMarketChildViewController.h"

@interface NJMarketViewController ()
@property (nonatomic, strong) JSSegmentControl *segmentControl;
@property (nonatomic, copy) NSArray *segmentTitleArray;
@property (nonatomic, strong) GSPageViewController *pageVC;
@property (nonatomic, strong) NSMutableArray *childVCArray;
@end

@implementation NJMarketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.segmentTitleArray = @[@"新闻中心", @"行业咨询", @"油价分析"];
    [self.view addSubview:self.segmentControl];
    
    self.childVCArray = [@[] mutableCopy];
    for (int i = 0;i < self.segmentTitleArray.count;i++) {
        NJMarketChildViewController *childVC = [[NJMarketChildViewController alloc] init];
        childVC.category_type = 9951 + i;
        [self.childVCArray addObject:childVC];
    }
    
    [self addChildViewController:self.pageVC];
    self.pageVC.view.frame = CGRectMake(0, 40, kScreenW, kScreenH - 40);
    [self.view addSubview:self.pageVC.view];
    [self.pageVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - lazy
- (JSSegmentControl *)segmentControl {
    if (!_segmentControl) {
        __weak typeof(self) weakSelf = self;
        _segmentControl = [[JSSegmentControl alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 40)];
        JSSegmentControlConfig *config = _segmentControl.config;
        config.buttonWidth = kScreenW / self.segmentTitleArray.count;
        config.normalColor = [UIColor themeFontColor];
        config.selectedColor = [UIColor orangeColor];
        config.bottomViewColor = [UIColor clearColor];
        config.bottomViewHeight = 5;
        _segmentControl.titleArray = self.segmentTitleArray;
        [_segmentControl setClickButtonEvent:^(NSInteger clickIndex) {
            weakSelf.pageVC.selectIndex = clickIndex;
        }];
    }
    return _segmentControl;
}

- (GSPageViewController *)pageVC {
    if (!_pageVC) {
        __weak typeof(self) weakSelf = self;
        _pageVC = [[GSPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil childVCArray:self.childVCArray];
        [_pageVC setScrollBlock:^(NSInteger index) {
            weakSelf.segmentControl.selectIndex = index;
        }];
    }
    return _pageVC;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
