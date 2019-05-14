//
//  UIColor+GSColor.h
//  GreatSupervision
//
//  Created by lianditech on 2017/11/16.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (GSColor)
/**
 导航栏背景色
*/
+ (UIColor *)naviBarBackgoundColor;

/**
 主题字体颜色
 */
+ (UIColor *)themeFontColor;

/**
 主题背景色
 */
+ (UIColor *)themeBackgroundColor;

/**
 主题分割线颜色
 */
+ (UIColor *)themeSeparatorLineColor;

/**
 分段选择控件底部滑条背景色
 */
+ (UIColor *)segmentControlBottomNormalColor;

/**
 分段选择控件选中字体颜色
 */
+ (UIColor *)segmentControlSelectFontColor;

/**
 textField系统自带边框颜色
 */
+ (UIColor *)textFieldSystemColor;

@end
