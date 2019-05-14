//
//  JSSegmentControl.m
//  LYMail
//
//  Created by drision on 2016/11/2.
//  Copyright © 2016年 Drision. All rights reserved.
//

#define buttonAutoAdaptOtherWidth 10
#define animationDurtion 0.5

#import "JSSegmentControl.h"

@implementation JSSegmentControlConfig

- (void)setIsAutoAdaptWidth:(BOOL)isAutoAdaptWidth {
    _isAutoAdaptWidth = isAutoAdaptWidth;
    if (_isAutoAdaptWidth) {
        self.bottomViewHeight = 0;
    }
}

@end

@interface JSSegmentControl ()

@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *bottomScrollView;

@end

@implementation JSSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initCSS];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initData];
        [self initCSS];
    }
    return self;
}

#pragma mark - get、set
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        [_bottomView addSubview:self.bottomScrollView];
    }
    return _bottomView;
}

- (UIView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIView alloc] init];
    }
    return _bottomScrollView;
}

- (void)setTitleArray:(NSArray *)titleArray {
    _titleArray = titleArray;
    for (UIButton *button in self.buttonArray) {
        [button removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    CGFloat contentWidth = 0;
    CGFloat buttonOriginX = self.config.buttonSpace;
    for (int i = 0;i < _titleArray.count;i++) {
        NSString *title = _titleArray[i];
        CGFloat buttonWidth = self.config.buttonWidth;
        if (self.config.isAutoAdaptWidth) buttonWidth = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, self.config.buttonHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.config.titleFont} context:nil].size.width + buttonAutoAdaptOtherWidth;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX, (self.bounds.size.height - self.config.buttonHeight) / 2, buttonWidth, self.config.buttonHeight)];
        button.titleLabel.font = self.config.titleFont;
        button.layer.cornerRadius = self.config.buttonCorner;
        button.layer.masksToBounds = YES;
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.buttonArray addObject:button];
        contentWidth = button.frame.origin.x + buttonWidth + self.config.buttonSpace;
        buttonOriginX += self.config.buttonSpace + buttonWidth;
    }
    self.bottomView.frame = CGRectMake(0, self.bounds.size.height - self.config.bottomViewHeight, contentWidth, self.config.bottomViewHeight);
    self.bottomView.backgroundColor = self.config.bottomViewColor;
    self.bottomScrollView.frame = CGRectMake(self.selectIndex * self.config.buttonWidth + (self.selectIndex + 1) * self.config.buttonSpace, 0, self.config.buttonWidth, self.config.bottomViewHeight);
    self.bottomScrollView.backgroundColor = self.config.selectedColor;
    self.contentSize = CGSizeMake(contentWidth, 0);
    self.selectIndex = self.selectIndex;
}

#pragma mark - private
- (void)initData {
    JSSegmentControlConfig *config = [[JSSegmentControlConfig alloc] init];
    config.buttonHeight = self.bounds.size.height;
    config.isAutoAdaptWidth = NO;
    config.titleFont = [UIFont systemFontOfSize:15];
    config.normalColor = [UIColor blackColor];
    config.normalBackColor = [UIColor clearColor];
    config.selectedColor = [UIColor blueColor];
    config.selectedBackColor = [UIColor yellowColor];
    config.bottomViewColor = [UIColor clearColor];
    config.bottomViewHeight = 2;
    self.config = config;
    self.buttonArray = [NSMutableArray array];
}

- (void)initCSS {
    self.showsHorizontalScrollIndicator = NO;
    self.bounces = NO;
    [self addSubview:self.bottomView];
}

- (void)changeButtonColor {
    if (self.config.isAutoAdaptWidth) {
        for (UIButton *button in self.buttonArray) {
            NSInteger index = [self.buttonArray indexOfObject:button];
            if (index == self.selectIndex) {
                [button setTitleColor:self.config.selectedColor forState:UIControlStateNormal];
                button.backgroundColor = self.config.selectedBackColor;
            } else {
                [button setTitleColor:self.config.normalColor forState:UIControlStateNormal];
                button.backgroundColor = self.config.normalBackColor;
            }
        }
    } else {
        for (UIButton *button in self.buttonArray) {
            NSInteger index = [self.buttonArray indexOfObject:button];
            if (index == self.selectIndex) {
                [button setTitleColor:self.config.selectedColor forState:UIControlStateNormal];
            } else {
                [button setTitleColor:self.config.normalColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)changeButtonLocation {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (self.contentSize.width <= screenWidth) return;
    CGFloat x = self.contentOffset.x;
    UIButton *selectButton = self.buttonArray[self.selectIndex];
    CGFloat buttonWidth = selectButton.frame.size.width;
    CGFloat originX = selectButton.frame.origin.x;
    if (originX > screenWidth / 2 && self.contentSize.width - originX - buttonWidth > screenWidth / 2) {
        x = originX  + buttonWidth / 2 - (screenWidth / 2);
    } else if (originX <= screenWidth / 2) {
        x = 0;
    } else if (self.contentSize.width - originX - buttonWidth <= screenWidth / 2) {
        x = self.contentSize.width - screenWidth;
    }
    [UIView animateWithDuration:animationDurtion animations:^{
        [self setContentOffset:CGPointMake(x, 0)];
    }];
}

#pragma mark - public
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (_selectIndex > 0) {
        NSAssert(self.titleArray.count > 0, @"请先设置titleArray");
        NSAssert(_selectIndex < self.titleArray.count, @"你选择的index超出titleArray的范围");
    }
    CGRect frame = self.bottomScrollView.frame;
    frame.origin.x = self.selectIndex * self.config.buttonWidth + (self.selectIndex + 1) * self.config.buttonSpace;
    [UIView animateWithDuration:animationDurtion animations:^{
        self.bottomScrollView.frame = frame;
    }];
    [self changeButtonLocation];
    [self changeButtonColor];
}

#pragma mark - IBAction
- (void)clickAction:(UIButton *)sender {
    NSInteger index = [self.buttonArray indexOfObject:sender];
    self.selectIndex = index;
    if (self.clickButtonEvent) self.clickButtonEvent(index);
}

@end
