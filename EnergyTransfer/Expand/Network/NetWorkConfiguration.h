//
//  NetWorkConfiguration.h
//  GreatSupervision
//
//  Created by lianditech on 2017/11/16.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#ifndef NetWorkConfiguration_h
#define NetWorkConfiguration_h

#define kUserDefaultPhone @"kUserDefaultPhone"
#define kUserDefaultPasswrod @"kUserDefaultPasswrod"

#define kStatus @"status"
#define kMessage @"msg"
#define KData @"page"
#define KStatusYES @"1"
#define KStatusNO @"0"

//测试环境
//#define hostName @"http://www.liandisoft.com/nengyuanhui"
//正式环境
#define hostName @"https://www.jhnyh.com/nengyuanhui"

#define getMarketListPath @"activity/article/list"//获取行情列表
#define getMarketDetailsPath @"activity/article/edit"//获取行情详情
#define getChartsNumber @"oilPrice/todayList"//获取图表数据
#define getMarketNumber @"oilPrice/listAll"//获取首页行情数据
#define getproduct_category @"product_category/brand"//获取首页分类数据
#define getScrollTitle @"adPosition/queryMessage"//获取走马灯信息
#define getBanner @"adPosition/queryById"//获取轮播图
#define getHot @"product_tag/queryHot?id=1"//获取推荐产品
#define loginPath @"activity/autologin"//登录
#define logoutPath @"activity/logout"//退出登录
#define getMinePath @"cart/count"//获取会员中心数据
#define getClassflyPath @"product_category/brandList"//获取分类数据
#define getClassflyNumberPath @"product_category/byBrand"//获取联动数据
#define getShopCarPath @"cart/listAll"//购物车数据
#define validationPath @"order/checkCart"//验证是否可以结算
#define deleteShopCarPath @"cart/removeOne"//删除购物车数据
#define clearShopCarPath @"cart/clearAll"//清空购物车数据
#define modifyShopCarPath @"cart/modifyOne"//修改购物车数据

#endif /* NetWorkConfiguration_h */
