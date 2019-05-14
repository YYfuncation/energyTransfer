//
//  NJHomeHotCellCollectionViewCell.h
//  EnergyTransfer
//
//  Created by Liandi on 2019/1/28.
//  Copyright © 2019年 Liandi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJHomeHotCellCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleName;
@property (weak, nonatomic) IBOutlet UILabel *secondTitleName;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;

@end
