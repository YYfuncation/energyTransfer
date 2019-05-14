//
//  NJMarketManager.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/13.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMarketManager.h"
#import "MJExtension.h"
#import "NJMarketModel.h"

@implementation NJMarketManager

+(void)getMarketListWithArticleCategory_id:(NSInteger)articleCategory_id pageSize:(NSInteger)pageSize pageNumber:(NSInteger)pageNumber successHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getMarketListPath];
    [netWorkManager getWithParams:@{@"articleCategory_id":@(articleCategory_id),@"pageNumber":@(pageNumber),@"pageSize":@(pageSize)} successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[KData]) {
                NJMarketModel *model = [[NJMarketModel alloc] init];
                [model mj_setKeyValues:dic];
                [resultArray addObject:model];
            }
            if (successHandler) successHandler(resultArray);
        } else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
    
}
+ (void)getMarketDetailsId:(NSInteger)id successHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getMarketDetailsPath];
    [netWorkManager getWithParams:@{@"id":@(id)} successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJMarketModel *model = [[NJMarketModel alloc] init];
            [model mj_setKeyValues:resultDic[@"article"]];
            if (successHandler) successHandler(model);
        } else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
@end
