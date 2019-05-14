//
//  NJShopCarManager.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkManager.h"

@interface NJShopCarManager : NSObject
+ (void)getShopCarNumberWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getShopCarTotalPriceWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
+ (void)deleteShopCarWithskuId:(NSInteger)skuId SuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
+ (void)clearShopCarWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
+ (void)modifyShopCarWithskuId:(NSInteger)skuId quantity:(float)quantity SuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)validationIsSettlementWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
@end
