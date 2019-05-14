//
//  MBProgressHUD+LYHud.m
//  LYMail
//
//  Created by drision on 2016/11/4.
//  Copyright © 2016年 Drision. All rights reserved.
//

#import "MBProgressHUD+LYHud.h"

@implementation MBProgressHUD (LYHud)

+ (MBProgressHUD *)showWithString:(NSString *)string {
    MBProgressHUD *hud = [self showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    //去除毛玻璃效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    if (string.length > 10) {
        hud.detailsLabel.text = string;
    } else {
        hud.label.text = string;
    }
    
    [hud hideAnimated:YES afterDelay:1.0f];
    return hud;
}

+ (MBProgressHUD *)showIndeterminateInView:(UIView *)view {
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    //去除毛玻璃效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (MBProgressHUD *)showIndeterminateWithString:(NSString *)string inView:(UIView *)view {
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor colorWithWhite:0 alpha:0.8];
    //去除毛玻璃效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.contentColor = [UIColor whiteColor];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    if (string.length > 10) {
        hud.detailsLabel.text = string;
    } else {
        hud.label.text = string;
    }
    return hud;
}

- (void)showIndeterminaToText:(NSString *)string {
    self.mode = MBProgressHUDModeText;
    if (string.length > 10) {
        self.detailsLabel.text = string;
        self.label.text = nil;
    } else {
        self.label.text = string;
        self.detailsLabel.text = nil;
    }
    
    [self hideAnimated:YES afterDelay:1.0f];
}

- (void)showIndeterminaToWithText:(NSString *)string {
    if (string.length > 10) {
        self.detailsLabel.text = string;
        self.label.text = nil;
    } else {
        self.label.text = string;
        self.detailsLabel.text = nil;
    }
}

@end
