//
//  NJShopCarFirstModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NJShopCarSecondModel;

@interface NJShopCarFirstModel : NSObject
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, assign) float effectivePrice;
@property (nonatomic, copy) NSArray<NJShopCarSecondModel *>*shopCarArray;
@property (nonatomic, copy) NSString *isLogin;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
