//
//  JSSegmentControl.h
//  LYMail
//
//  Created by drision on 2016/11/2.
//  Copyright © 2016年 Drision. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JSSegmentControlConfig : NSObject

@property (nonatomic, assign) CGFloat buttonWidth;//按钮宽度，如果不是自适应宽度时必须设置
@property (nonatomic, assign) CGFloat buttonHeight;//按钮高度，默认是控件高度
@property (nonatomic, assign) CGFloat buttonSpace;//按钮间距，默认0
@property (nonatomic, assign) CGFloat buttonCorner;//按钮圆角，默认0
@property (nonatomic, assign) BOOL isAutoAdaptWidth;//是否自适应宽度，默认NO
@property (nonatomic, strong) UIFont *titleFont;//标题字体, 默认系统15号字体
@property (nonatomic, strong) UIColor *normalColor;//正常字体颜色，默认blackColor
@property (nonatomic, strong) UIColor *normalBackColor;//正常背景颜色，默认clearColor
@property (nonatomic, strong) UIColor *selectedColor;//选中字体颜色，默认blueColor
@property (nonatomic, strong) UIColor *selectedBackColor;//选中背景颜色，默认yellowColor
@property (nonatomic, strong) UIColor *bottomViewColor;//底部滑条父视图背景色，默认clearColor
@property (nonatomic, assign) CGFloat bottomViewHeight;//底部滑条高度，默认2

@end

@interface JSSegmentControl : UIScrollView

@property (nonatomic, strong) JSSegmentControlConfig *config;
@property (nonatomic, copy) NSArray *titleArray;//按钮标题，必须设置, 必须是最后设置
@property (nonatomic, assign) NSInteger selectIndex;//当前选中，默认0，设置完titleArray才能设置这个

@property (nonatomic, copy) void (^clickButtonEvent)(NSInteger clickIndex);

@end
