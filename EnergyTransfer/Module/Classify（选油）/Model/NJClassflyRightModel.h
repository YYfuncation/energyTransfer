//
//  NJClassflyRightModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/30.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NJClassfiySecondModel;

@interface NJClassflyRightModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSArray<NJClassfiySecondModel *>*secnondArray;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
