//
//  NJClassflyRightModel.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/30.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJClassflyRightModel.h"
#import "NJClassfiySecondModel.h"

#import "MJExtension.h"

@implementation NJClassflyRightModel
- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    if (self = [super init]) {
        [self mj_setKeyValues:dictionary];
        NSMutableArray *oneArray = [@[] mutableCopy];
        for (NSDictionary *categoryDic in dictionary[@"grandList"]) {
            NJClassfiySecondModel *model = [[NJClassfiySecondModel alloc] init];
            [model mj_setKeyValues:categoryDic];
            [oneArray addObject:model];
        }
        self.secnondArray = oneArray;
    }
    return self;
}
@end
