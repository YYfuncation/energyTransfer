//
//  NJShopCarManager.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJShopCarManager.h"
#import "MJExtension.h"
#import "NJShopCarFirstModel.h"

@implementation NJShopCarManager
+ (void)getShopCarNumberWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getShopCarPath];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *categoryDic in resultDic[@"cartItems"]){
                NJShopCarFirstModel *model = [[NJShopCarFirstModel alloc] initWithDictionary:categoryDic];
                [resultArray addObject:model];
            }
            if (successHandler) successHandler(resultArray);
        }else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)getShopCarTotalPriceWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getShopCarPath];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJShopCarFirstModel *model = [[NJShopCarFirstModel alloc]init];
            [model mj_setKeyValues:resultDic];
            if (successHandler) successHandler(model);
        }else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)deleteShopCarWithskuId:(NSInteger)skuId SuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:deleteShopCarPath];
    [netWorkManager postWithParams:@{@"skuId":@(skuId)} successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJShopCarFirstModel *model = [[NJShopCarFirstModel alloc]init];
            [model mj_setKeyValues:resultDic];
            if (successHandler) successHandler(model);
        }else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)clearShopCarWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:clearShopCarPath];
    [netWorkManager postWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            if (successHandler) successHandler(resultDic[kMessage]);
        }else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)modifyShopCarWithskuId:(NSInteger)skuId quantity:(float)quantity SuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:modifyShopCarPath];
    [netWorkManager postWithParams:@{@"skuId":@(skuId),@"quantity":@(quantity)} successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJShopCarFirstModel *model = [[NJShopCarFirstModel alloc]init];
            [model mj_setKeyValues:resultDic];
            if (successHandler) successHandler(model);
        }else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)validationIsSettlementWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:validationPath];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        
        if (successHandler) successHandler(resultDic[kStatus]);
        
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
@end
