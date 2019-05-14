//
//  NJMineManager.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/29.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkManager.h"

@interface NJMineManager : NSObject
/**
 获取会员中心数据
 
 @param successHandler 成功回调
 @param errorHandler 失败回调
 */
+ (void)getMineNumberWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)logoutWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
@end
