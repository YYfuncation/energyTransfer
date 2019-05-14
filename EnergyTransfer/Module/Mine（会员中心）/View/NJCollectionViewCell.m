//
//  NJCollectionViewCell.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJCollectionViewCell.h"

@implementation NJCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.exitBut.backgroundColor = [UIColor colorWithRed:251.0f/255.0f green:199.0f/255.0f blue:12.0f/255.0f alpha:1];
}

@end
