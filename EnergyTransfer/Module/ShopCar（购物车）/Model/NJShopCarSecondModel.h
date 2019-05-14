//
//  NJShopCarSecondModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJShopCarSecondModel : NSObject
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) float quantity;
@property (nonatomic, assign) float price;
@property (nonatomic, assign) NSInteger id;
@end
