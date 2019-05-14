//
//  NJHomeManager.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/26.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkManager.h"

@interface NJHomeManager : NSObject
/**
 获取图表数据
 
 @param successHandler 成功回调
 @param errorHandler 失败回调
 */
+ (void)getChartsNumberWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getMarketNumberWithSuccessHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getProduct_categoryWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getScrollTitleWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getBannerWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getHotWithSuccessHandler:(SuccessHandlerArrayBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
@end
