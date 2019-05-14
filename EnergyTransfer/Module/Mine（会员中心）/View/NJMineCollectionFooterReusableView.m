//
//  NJMineCollectionFooterReusableView.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMineCollectionFooterReusableView.h"
@interface NJMineCollectionFooterReusableView ()
@property (nonatomic, strong) UILabel *leftTitleLabel;
@end
@implementation NJMineCollectionFooterReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _leftTitleLabel.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
        [self addSubview:_leftTitleLabel];
    }
    return self;
}
@end
