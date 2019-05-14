//
//  NJMineCollectionReusableView.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMineCollectionReusableView.h"
@interface NJMineCollectionReusableView ()
@property (nonatomic, strong) UILabel *leftTitleLabel;
@property (nonatomic, strong) UILabel *rightTitleLabel;
@end
@implementation NJMineCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _leftTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width / 2, frame.size.height)];
        _leftTitleLabel.textColor = [UIColor blackColor];
        _leftTitleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_leftTitleLabel];
        
        _rightTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width / 2, 0, frame.size.width / 2 - 20, frame.size.height)];
        _rightTitleLabel.textColor = [UIColor blackColor];
        _rightTitleLabel.font = [UIFont systemFontOfSize:14];
        _rightTitleLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_rightTitleLabel];
        
        _rightBut = [[UIButton alloc]initWithFrame:CGRectMake(frame.size.width - 80, 0, 60, frame.size.height)];
        [_rightBut setTitle:@"更多＞" forState:UIControlStateNormal];
        [_rightBut setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _rightBut.hidden = YES;
        _rightBut.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_rightBut];
    }
    return self;
}

- (void)setLeftTitle:(NSString *)leftTitle {
    _leftTitle = leftTitle;
    _leftTitleLabel.text = _leftTitle;
}
-(void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    _rightTitleLabel.text = _rightTitle;
}
@end
