//
//  NJLoginManager.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJLoginManager.h"
#import "MJExtension.h"
#import "NJLoginModel.h"

@implementation NJLoginManager
+ (void)loginWithusername:(NSString *)username password:(NSString *)password successHandler:(SuccessHandlerIdBlcok)successHanlder errorHandler:(ErrorHandlerBlock)errorHandler{
    AFNetWorkManager *netWorkManager = [[AFNetWorkManager alloc] initWithPath:loginPath];
    [netWorkManager getWithParams:@{@"username":username,@"password":password} successHandler:^(NSDictionary *resultDic) {
        if ([resultDic[kStatus] isEqualToString:KStatusYES]) {
            NJLoginModel *model = [[NJLoginModel alloc]init];
            [model mj_setKeyValues:resultDic];
//            TSUserModel *userModel = [TSUserModel shareUserModel];
//            [userModel mj_setKeyValues:resultDic[KData][@"user"]];
            if (successHanlder) successHanlder(model);
        } else {
            if (errorHandler) errorHandler(resultDic[kMessage]);
        }
    } errorHandler:^(NSString *errorString) {
        if (errorHandler) errorHandler(errorString);
    }];
}
@end
