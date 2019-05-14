//
//  UINavigationItem+GSBackButton.h
//  GreatSupervision
//
//  Created by lianditech on 2017/12/11.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (GSBackButton)

+ (UIBarButtonItem *)initWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

@end
