//
//  NJLoginModel.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/12/3.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJLoginModel.h"

@implementation NJLoginModel
static NJLoginModel *_userModel;

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_userModel == nil) {
            _userModel = [super allocWithZone:zone];
        }
    });
    return _userModel;
}

+ (instancetype)shareUserModel {
    return [[self alloc] init];
}

// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
- (id)copyWithZone:(NSZone *)zone {
    return _userModel;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _userModel;
}
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.sessionId forKey:@"sessionId"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.sessionId = [aDecoder decodeObjectForKey:@"sessionId"];
        
    }
    return self;
}
@end
