//
//  MainNavigationViewController.m
//  导诊
//
//  Created by elaine on 15/4/20.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "MainNavigationViewController.h"
#import "Marco.h"
#import "UIColor+GSColor.h"
#import "UIBarButtonItem+GSBackButton.h"

@interface MainNavigationViewController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation MainNavigationViewController


+ (void)initialize
{
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    [navigationBar setBarTintColor:[UIColor colorWithRed:45.0f/255.0f green:45.0f/255.0f blue:45.0f/255.0f alpha:1]];
    [navigationBar setTranslucent:NO];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:20]}];
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    barItem.tintColor = [UIColor whiteColor];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = self;
        self.delegate = self;
    }
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //大于0 表示不是根控制器
    if (self.viewControllers.count > 0) {
//        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.hidesBackButton = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(back) image:@"navi_back" highImage:@"navi_back"];
    }
    
    [super pushViewController:viewController animated:animated];
    
    
}

- (void)back {
    [self popViewControllerAnimated:NO];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated {
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        if ([navigationController.viewControllers count] == 1) {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        } else {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
            
        }
    }
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
