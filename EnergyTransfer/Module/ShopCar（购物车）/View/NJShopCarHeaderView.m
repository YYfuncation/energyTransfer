//
//  NJShopCarHeaderView.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJShopCarHeaderView.h"

@implementation NJShopCarHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor= [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f];
        
        self.storeName = [[UIButton alloc] initWithFrame:CGRectMake(8, 5, 60, 40)];
        self.storeName.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.storeName.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.storeName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.storeName];
        
        self.statusName = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.storeName.frame), 15, 40, 20)];
        self.statusName.textAlignment = NSTextAlignmentCenter;
        self.statusName.font = [UIFont systemFontOfSize:14];
        self.statusName.backgroundColor = [UIColor orangeColor];
        self.statusName.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.statusName];
    }
    
    return self;
}
@end
