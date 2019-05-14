//
//  TSConst.h
//  TelecomSupervision
//
//  Created by lianditech on 2018/1/9.
//  Copyright © 2018年 lianditech. All rights reserved.
//

#import <Foundation/Foundation.h>

// 用户
extern NSString *const kUserName;//保存用户名关键字
extern NSString *const kPassword;//保存密码关键字
extern NSString *const kAutoLogin;//保存自动登录关键字
extern NSString *const kUserModel;//保存userModel关键字
extern NSString *const kLoginSuccess;//保存登录成功与否关键字

// 通知
extern NSString *const kUpdateBusinessListNotification;//更新商机列表通知
extern NSString *const kUpdatePartnerListNotification;//更新合作方列表通知
extern NSString *const kUpdateSoleBeforeListNotification;//更新售前列表
extern NSString *const kUpdateInSoleListNotification;//更新售中列表

// 角色
extern NSInteger const kSuperManager;// 超级管理员关键字
extern NSInteger const kCityLeader;// 市领导 上级领导
extern NSInteger const kSecondRole;// 二级角色
extern NSInteger const kThirdRole;// 三级角色

