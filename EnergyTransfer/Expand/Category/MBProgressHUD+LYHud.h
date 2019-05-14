//
//  MBProgressHUD+LYHud.h
//  LYMail
//
//  Created by drision on 2016/11/4.
//  Copyright © 2016年 Drision. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (LYHud)

+ (MBProgressHUD *)showWithString:(NSString *)string;

+ (MBProgressHUD *)showIndeterminateInView:(UIView *)view;

+ (MBProgressHUD *)showIndeterminateWithString:(NSString *)string inView:(UIView *)view;

- (void)showIndeterminaToText:(NSString *)string;

- (void)showIndeterminaToWithText:(NSString *)string;

@end
