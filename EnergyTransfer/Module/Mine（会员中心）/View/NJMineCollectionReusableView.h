//
//  NJMineCollectionReusableView.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJMineCollectionReusableView : UICollectionReusableView
@property (nonatomic, copy) NSString *leftTitle;
@property (nonatomic, copy) NSString *rightTitle;
@property (nonatomic, strong) UIButton *rightBut;
@end
