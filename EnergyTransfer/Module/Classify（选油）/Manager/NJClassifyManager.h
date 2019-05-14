//
//  NJClassifyManager.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/29.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkManager.h"

@interface NJClassifyManager : NSObject
/**
 获取选油数据
 
 @param successHandler 成功回调
 @param errorHandler 失败回调
 */
+ (void)getClassifyWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getClassifyNumberWithbrandName:(NSString *)brandName color:(NSString *)color SuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
@end
