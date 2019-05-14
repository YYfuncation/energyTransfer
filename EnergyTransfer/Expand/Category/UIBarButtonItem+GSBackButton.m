//
//  UINavigationItem+GSBackButton.m
//  GreatSupervision
//
//  Created by lianditech on 2017/12/11.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#import "UIBarButtonItem+GSBackButton.h"
#import "Marco.h"

@implementation UIBarButtonItem (GSBackButton)

+ (UIBarButtonItem *)initWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.frame = CGRectMake(0, 0, 100, 44);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -100, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
