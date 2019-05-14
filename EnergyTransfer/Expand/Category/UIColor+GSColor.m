//
//  UIColor+GSColor.m
//  GreatSupervision
//
//  Created by lianditech on 2017/11/16.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#import "UIColor+GSColor.h"
#import "Marco.h"

@implementation UIColor (GSColor)

+ (UIColor *)themeFontColor {
    return kUIColorFromRGB(0x333333);
}
+ (UIColor *)naviBarBackgoundColor {
    return kUIColorFromRGB(0x354daf);
}
+ (UIColor *)themeBackgroundColor {
    return kUIColorFromRGB(0xdedede);
}

+ (UIColor *)themeSeparatorLineColor {
    return kUIColorFromRGB(0xededed);
}

+ (UIColor *)segmentControlBottomNormalColor {
    return kUIColorFromRGB(0xdbddde);
}

+ (UIColor *)segmentControlSelectFontColor {
    return kUIColorFromRGB(0x33b5e5);
}

+ (UIColor *)textFieldSystemColor {
    return kUIColorFromRGB(0xcdcdcd);
}

@end
