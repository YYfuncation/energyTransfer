//
//  NJTabBarViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/2.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJTabBarViewController.h"
#import "TSConst.h"
#import "NJLoginViewController.h"

@interface NJTabBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation NJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupChildControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupChildControllers {
    self.tabBarController.delegate = self;
    //    // 1、创建自定义的CHTabBar;
    UIImage *tabbarimage = [UIImage imageNamed:@"barbei"];
    UIImageView *tabBarBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,
                                                                                           self.tabBar.frame.size.width, self.tabBar.frame.size.height)];
    tabBarBackgroundImageView.image = tabbarimage;
    
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
