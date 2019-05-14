//
//  NJMineModel.h
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/29.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJMineModel : NSObject
@property (nonatomic, copy) NSString *rankName;
@property (nonatomic, assign) NSInteger pendingPaymentOrderCount;//等待付款
@property (nonatomic, assign) NSInteger pendingViewOrderCount; //待确认
@property (nonatomic, assign) NSInteger pendingShipmentOrderCount;//等待提货
@property (nonatomic, assign) NSInteger pickUpGoodsingOrderCount;//提货中
@property (nonatomic, assign) NSInteger completeOrderCount;//已完成
@property (nonatomic, assign) NSInteger productNotifyCount;//到货通知
@property (nonatomic, assign) NSInteger productFavoriteCount;//商品收藏
@property (nonatomic, assign) NSInteger consultationCount;//商品咨询

@property (nonatomic, assign) NSInteger reviewCount;

@property (nonatomic, copy) NSString *isLogin;
@end
