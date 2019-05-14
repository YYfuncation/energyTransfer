//
//  NJHomeProductCategoriesModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/27.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NJHomeProductsModel;

@interface NJHomeProductCategoriesModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray<NJHomeProductsModel *>*productsArray;


- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
