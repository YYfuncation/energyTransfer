//
//  NJShopCarFirstModel.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJShopCarFirstModel.h"
#import "NJShopCarSecondModel.h"
#import "MJExtension.h"

@implementation NJShopCarFirstModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self mj_setKeyValues:dictionary];
        NSMutableArray *productsArray = [@[] mutableCopy];
        for (NSDictionary *categoryDic in dictionary[@"items"]) {
            NJShopCarSecondModel *model = [[NJShopCarSecondModel alloc] init];
            [model mj_setKeyValues:categoryDic];
            [productsArray addObject:model];
        }
        self.shopCarArray = productsArray;
    }
    return self;
}
@end
