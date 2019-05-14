//
//  NJHomeCollectionReusableView.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/26.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJHomeCollectionReusableView.h"
#import "Marco.h"
@interface NJHomeCollectionReusableView ()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation NJHomeCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 30)];
        [self addSubview:_img];
                    
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, frame.size.width - 60, frame.size.height)];
        _titleLabel.textColor = KRGBHex(0x224b8f);
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self addSubview:_titleLabel];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(kScreenW - 60, 5, 50, 30)];
        [_button setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
//        [self addSubview:_button];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}
@end
