//
//  NJHomeMarketModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/26.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJHomeMarketModel : NSObject
@property (nonatomic, copy) NSString *brentOilPrice;
@property (nonatomic, copy) NSString *brentIncreasePrice;
@property (nonatomic, copy) NSString *brentIncreasePricePercent;
@property (nonatomic, copy) NSString *clOilPrice;
@property (nonatomic, copy) NSString *clIncreasePrice;
@property (nonatomic, copy) NSString *clIncreasePricePercent;
@end
