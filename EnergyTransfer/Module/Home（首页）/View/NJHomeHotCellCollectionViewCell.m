//
//  NJHomeHotCellCollectionViewCell.m
//  EnergyTransfer
//
//  Created by Liandi on 2019/1/28.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import "NJHomeHotCellCollectionViewCell.h"

@implementation NJHomeHotCellCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgView.layer.cornerRadius = self.imgView.frame.size.width/2;
    self.layer.cornerRadius = 8;
    
}

@end
