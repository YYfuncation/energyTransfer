//
//  Marco.h
//  iOSNav
//
//  Created by lazyjiu on 16/6/22.
//  Copyright © 2016年 啾三万. All rights reserved.
//

#ifndef Marco_h
#define Marco_h
#ifdef DEBUG
//#define MLog(...) printf("%s [Line %d] %s\n",__PRETTY_FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#define MLog(...) printf("%s [Line %d] %s\n",__PRETTY_FUNCTION__,__LINE__,[[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

#else
#define MLog(...)
#endif

//判断ios7
#define IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue]<8.0)
//start
//判断ios10以上 by jhonsun 20170816
#define IOS10 ([[[UIDevice currentDevice] systemVersion] floatValue]>=10.0)
//end

//随机色
#define IWRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

//屏幕的宽度和高度
#define kScreenW  [UIScreen mainScreen].bounds.size.width
#define kScreenH  [UIScreen mainScreen].bounds.size.height
#define kStatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define KNaviH 44
#define kTabbarH 49
#define STATUS_BAR_HEIGHT 20

//16进制颜色值
#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//rgb颜色值
#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define KColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]

#define kScaleInHeight ([UIScreen mainScreen].bounds.size.height/480.0)

#define kScaleInWith ([UIScreen mainScreen].bounds.size.width/320.0)

#define kMaxScaleInHeight ([UIScreen mainScreen].bounds.size.height/736.0)

#define kMaxScaleInWidth ([UIScreen mainScreen].bounds.size.width/414.0)

#define KRGBHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define ssRGBHexAlpha(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]


//验证法时间
#define verifyCodeTime 30


#define kMainColor kUIColorFromRGB(0x4b9df9)
#define KBackColorGray kUIColorFromRGB(0xecebe8)



#define VerifyValue(value)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = nil;\
else \
tmp = value;\
tmp;\
})\

#define VerifyValues(value,str)\
({id tmp;\
if ([value isKindOfClass:[NSNull class]])\
tmp = str;\
else \
tmp = value;\
tmp;\
})\


#endif /* Marco_h */
