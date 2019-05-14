//
//  NJLoginManager.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/28.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkManager.h"

@interface NJLoginManager : NSObject
/**
 登录
 
 @param username 手机号
 @param password 密码
 @param successHanlder 成功回调
 @param errorHandler 失败回调
 */
+ (void)loginWithusername:(NSString *)username password:(NSString *)password successHandler:(SuccessHandlerIdBlcok)successHanlder errorHandler:(ErrorHandlerBlock)errorHandler;
@end
