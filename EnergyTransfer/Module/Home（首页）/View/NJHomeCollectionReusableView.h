//
//  NJHomeCollectionReusableView.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/26.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NJHomeCollectionReusableView : UICollectionReusableView
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIButton *button;
@end
