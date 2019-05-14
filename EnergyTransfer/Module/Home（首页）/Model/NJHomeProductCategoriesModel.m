//
//  NJHomeProductCategoriesModel.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/27.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJHomeProductCategoriesModel.h"
#import "NJHomeProductsModel.h"
#import "MJExtension.h"

@implementation NJHomeProductCategoriesModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self mj_setKeyValues:dictionary];
        NSMutableArray *productsArray = [@[] mutableCopy];
        for (NSDictionary *categoryDic in dictionary[@"productList"]) {
            NJHomeProductsModel *model = [[NJHomeProductsModel alloc] init];
            [model mj_setKeyValues:categoryDic];
            [productsArray addObject:model];
        }
        self.productsArray = productsArray;
    }
    return self;
}
@end
