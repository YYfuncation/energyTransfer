//
//  NJClassflyCollectionReusableView.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/30.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJClassflyCollectionReusableView.h"
@interface NJClassflyCollectionReusableView ()

@end
@implementation NJClassflyCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.2];
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width , frame.size.height)];
        _leftTitleLabel.font = [UIFont systemFontOfSize:14];
        _leftTitleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_leftTitleLabel];
        
        
    }
    return self;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    _leftTitleLabel.text = _leftTitle;
}

@end
