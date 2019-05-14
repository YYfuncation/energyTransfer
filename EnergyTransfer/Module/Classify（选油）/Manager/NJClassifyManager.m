//
//  NJClassifyManager.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/29.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJClassifyManager.h"
#import "MJExtension.h"
#import "NJClassifyFirstModel.h"
#import "NJClassflyRightModel.h"

@implementation NJClassifyManager

+ (void)getClassifyWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getClassflyPath];
    [netWorkManager getWithParams:nil successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[@"brandList"]){
                NJClassifyFirstModel *model = [[NJClassifyFirstModel alloc] init];
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
+ (void)getClassifyNumberWithbrandName:(NSString *)brandName color:(NSString *)color SuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:getClassflyNumberPath];
    [netWorkManager getWithParams:@{@"brandName":brandName,@"color":color} successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NSMutableArray *resultArray = [NSMutableArray array];
            for (NSDictionary *dic in resultDic[@"list"]){
                NJClassflyRightModel *model = [[NJClassflyRightModel alloc] initWithDictionary:dic];
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
