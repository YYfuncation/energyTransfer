//
//  NJHomeManager.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/26.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJHomeManager.h"
#import "NJHomeChartModel.h"
#import "MJExtension.h"
#import "NJHomeMarketModel.h"
#import "NJHomeProductCategoriesModel.h"
#import "NJHomeProductsModel.h"
#import "NJHomeScrollTitleModel.h"
#import "NJHomeBannerModel.h"
#import "NJHomeHotModel.h"

@implementation NJHomeManager
+ (void)getChartsNumberWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getChartsNumber];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[@"oilPriceList"]) {
                NJHomeChartModel *model = [[NJHomeChartModel alloc] init];
                [model mj_setKeyValues:dic];
                [resultArray addObject:model];
            }
            if (successHandler) successHandler(resultArray);
        }
        else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)getMarketNumberWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getMarketNumber];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJHomeMarketModel *model = [[NJHomeMarketModel alloc] init];
            [model mj_setKeyValues:resultDic[@"oilPriceList"]];
            if (successHandler) successHandler(model);
        }
        else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
+ (void)getProduct_categoryWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getproduct_category];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *categoryDic in resultDic[@"brandList"]){
                NJHomeProductCategoriesModel *model = [[NJHomeProductCategoriesModel alloc] initWithDictionary:categoryDic];
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

+ (void)getScrollTitleWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getScrollTitle];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[@"messages"]) {
                NJHomeScrollTitleModel *model = [[NJHomeScrollTitleModel alloc] init];
                [model mj_setKeyValues:dic];
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

+ (void)getBannerWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getBanner];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[@"ads"]) {
                NJHomeBannerModel *model = [[NJHomeBannerModel alloc] init];
                [model mj_setKeyValues:dic];
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
+ (void)getHotWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getHot];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[@"list"]) {
                NJHomeHotModel *model = [[NJHomeHotModel alloc] init];
                [model mj_setKeyValues:dic];
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
@end
