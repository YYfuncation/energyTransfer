//
//  NJMineManager.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/29.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMineManager.h"
#import "NJMineModel.h"
#import "MJExtension.h"

@implementation NJMineManager
+ (void)getMineNumberWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getMinePath];
    [netWorkManager postWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJMineModel *model = [[NJMineModel alloc] init];
            [model mj_setKeyValues:resultDic];
            if (successHandler) successHandler(model);
        }
        else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}

+ (void)logoutWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:logoutPath];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            
            if (successHandler) successHandler(resultDic[kMessage]);
        }
        else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
@end
