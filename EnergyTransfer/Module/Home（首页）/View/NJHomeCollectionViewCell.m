//
//  NJHomeCollectionViewCell.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/26.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJHomeCollectionViewCell.h"
#import "Marco.h"

@implementation NJHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.borderWidth = .3;
    self.layer.borderColor = KRGBHex(0x2f84c4).CGColor;
}

@end
