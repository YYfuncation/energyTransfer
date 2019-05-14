//
//  NJMarketManager.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/13.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetWorkManager.h"

@interface NJMarketManager : NSObject

+ (void)getMarketListWithArticleCategory_id:(NSInteger)articleCategory_id pageSize:(NSInteger)pageSize pageNumber:(NSInteger)pageNumber successHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

+ (void)getMarketDetailsId:(NSInteger)id successHandler:(SuccessHandlerIdBlcok)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
@end
