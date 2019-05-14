//
//  NJMarketModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/13.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJMarketModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover_picture;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *district_name;
@property (nonatomic, assign) NSInteger lastModifiedDate;
@property (nonatomic, assign) NSInteger createdDate;
@property (nonatomic, assign) NSInteger id;
@end
