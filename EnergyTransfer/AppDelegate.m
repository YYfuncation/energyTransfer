//
//  AppDelegate.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/10/18.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "AppDelegate.h"
#import "NJLoginViewController.h"
#import "MainNavigationViewController.h"
#import "NJTabBarViewController.h"
#import "NJHomeViewController.h"
#import "NJMineViewController.h"
#import "NJShopCarViewController.h"
#import "NJClassifyViewController.h"
#import "NJMarketViewController.h"
#import "NJLoginViewController.h"
#import "TSConst.h"
#import "NJLoginManager.h"
#import "MBProgressHUD+LYHud.h"

@interface AppDelegate ()<UITabBarControllerDelegate>
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    // AppDelegate 进行全局设置
    BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginSuccess];
    if (isLogin) {
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
        if (name == nil) {
            name = @"";
            passWord = @"";
            [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
            } errorHandler:^(NSString *errorString) {
            }];
        }else{
            [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
            } errorHandler:^(NSString *errorString) {
            }];
        }
        
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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
    
//    NJMineViewController *mineVC = [[NJMineViewController alloc] init];
//    MainNavigationViewController *mineNav = [[MainNavigationViewController alloc] initWithRootViewController:mineVC];
//    mineNav.tabBarItem.image = [UIImage imageNamed:@"mine"];
//    mineVC.title = @"会员中心";
    MainNavigationViewController *mineNav = nil;
    if (isLogin) {
        NJMineViewController *mineVC = [[NJMineViewController alloc] init];
        mineNav = [[MainNavigationViewController alloc] initWithRootViewController:mineVC];
        mineNav.tabBarItem.image = [UIImage imageNamed:@"mine"];
        mineVC.title = @"会员中心";
    }else{
        NJLoginViewController *mineVC = [[NJLoginViewController alloc]init];
        mineNav = [[MainNavigationViewController alloc] initWithRootViewController:mineVC];
        mineNav.tabBarItem.image = [UIImage imageNamed:@"mine"];
        mineVC.title = @"会员中心";
    }
    
    
    NJTabBarViewController *tabVC = [[NJTabBarViewController alloc] init];
    tabVC.delegate = self;
    [tabVC setViewControllers:@[homeNav,marketNav,classifyNav,shopCarNav,mineNav]];
    tabVC.tabBar.tintColor = [UIColor orangeColor];
    tabVC.tabBar.backgroundImage = [self createImageWithColor:[UIColor colorWithRed:45.0f/255.0f green:45.0f/255.0f blue:45.0f/255.0f alpha:1]];
    
    self.window.rootViewController = tabVC;
    return YES;
    
}


//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//
//        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginSuccess];
//        if ([viewController.tabBarItem.title isEqualToString:@"会员中心"]) {
//            if (isLogin) {
//
//                return YES;
//            }else{
//                NJLoginViewController *loginVC = [[NJLoginViewController alloc]init];
//                NJTabBarViewController *tbc = (NJTabBarViewController *)_window.rootViewController;
//                MainNavigationViewController *nav = tbc.viewControllers[tbc.selectedIndex];
//                loginVC.hidesBottomBarWhenPushed = NO;
//                [nav pushViewController:loginVC animated:YES];
//
//                return NO;
//            }
//        }
//    return YES;
//}

//获取当前页
+ (UIViewController *)getCurrentVC {
    // 获取presentVC
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    if ([topVC isKindOfClass:[UINavigationController class]]) {
        return [(UINavigationController *)topVC topViewController];
    }
    if ([topVC isKindOfClass:[UIViewController class]]) {
        return topVC;
    }
    return nil;
    // 获取push当前页
    UIViewController *result = nil;
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
