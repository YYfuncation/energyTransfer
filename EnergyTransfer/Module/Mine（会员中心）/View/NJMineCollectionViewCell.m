//
//  NJMineCollectionViewCell.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMineCollectionViewCell.h"

@implementation NJMineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.applicationIconNumber.layer.masksToBounds = YES;
    self.applicationIconNumber.layer.cornerRadius = 11;
}

@end
