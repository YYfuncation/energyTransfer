//
//  NJHomeProductsModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/27.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJHomeProductsModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) float price;
@end
