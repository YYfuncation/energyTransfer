//
//  NJShopCarTableViewCell.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NJShopCarTableViewCell;
@protocol NJShopCarTableViewCellDegate <NSObject>

-(void)leftClick:(NJShopCarTableViewCell *)cell number:(float)number;
-(void)rightClick:(NJShopCarTableViewCell *)cell number:(float)number;
-(void)centerNum:(NJShopCarTableViewCell *)cell number:(float)number;
-(void)imgClick:(NJShopCarTableViewCell *)cell;
-(void)LabClick:(NJShopCarTableViewCell *)cell;
@end
@interface NJShopCarTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIView *labContentView;
@property (weak, nonatomic) IBOutlet UIButton *leftReduce;

@property (weak, nonatomic) IBOutlet UITextField *centerNum;
@property (weak, nonatomic) IBOutlet UIButton *rightAdd;

@property (weak, nonatomic) IBOutlet UIButton *delectBut;
@property (weak, nonatomic) id<NJShopCarTableViewCellDegate> delegate;
@end
