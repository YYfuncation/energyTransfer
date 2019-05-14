//
//  NJLoginModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJLoginModel : NSObject
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *cookieStr;

+ (instancetype)shareUserModel;
@end
