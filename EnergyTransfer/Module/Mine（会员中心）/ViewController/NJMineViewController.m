//
//  NJMineViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/2.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMineViewController.h"
#import "NJLoginViewController.h"
#import "UIColor+GSColor.h"
#import "Marco.h"
#import "NJMineCollectionViewCell.h"
#import "NJMineTableCollectionViewCell.h"
#import "NJCollectionViewCell.h"
#import "NJMineCollectionReusableView.h"
#import "NJMineCollectionFooterReusableView.h"
#import "NJBannerDetailsViewController.h"
#import "NetWorkConfiguration.h"
#import "TSConst.h"
#import "NJMineModel.h"
#import "NJMineManager.h"
#import "MBProgressHUD+LYHud.h"
#import "MainNavigationViewController.h"
#import "NJLoginManager.h"
#import "UIBarButtonItem+GSBackButton.h"
#import "MainNavigationViewController.h"
#import "NJTabBarViewController.h"
#import "NJHomeViewController.h"
#import "NJShopCarViewController.h"
#import "NJClassifyViewController.h"
#import "NJMarketViewController.h"
#define APP_WINDOW [[[UIApplication sharedApplication]delegate]window]
@interface NJMineViewController ()<UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NJMineModel *model;

@end

@implementation NJMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUI];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = nil;
    [self initData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(back) image:@"navi_back" highImage:@"navi_back"];
}

-(void)initData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJMineManager getMineNumberWithSuccessHandler:^(id object) {
        self.model = object;
        [self isLogin];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}

-(void)isLogin{
    if ([self.model.isLogin isEqualToString:@"1"]) {
        [self.collectionView reloadData];
    }else{
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
        [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
            [self initData];
        } errorHandler:^(NSString *errorString) {
        }];
    }
}
-(void)setUI{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerReferenceSize = CGSizeMake(kScreenW, 50);
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NJMineCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJMineCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NJMineTableCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJMineTableCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NJCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJCollectionViewCell"];
    
    // 注册头视图
    [self.collectionView registerClass:[NJMineCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    // 注册尾视图
    [self.collectionView registerClass:[NJMineCollectionFooterReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back {
//    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - UICollectionView代理
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NJMineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJMineCollectionViewCell" forIndexPath:indexPath];
    NJMineTableCollectionViewCell *tabCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJMineTableCollectionViewCell" forIndexPath:indexPath];
    NJCollectionViewCell *butCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.titleLab.text = @"商品收藏";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.productFavoriteCount];
            cell.img.image = [UIImage imageNamed:@"like"];
        }else if (indexPath.row == 1) {
            cell.titleLab.text = @"到货通知";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.productNotifyCount];
            cell.img.image = [UIImage imageNamed:@"notice"];
        }else{
            cell.titleLab.text = @"商品咨询";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.consultationCount];
            cell.img.image = [UIImage imageNamed:@"question"];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.titleLab.text = @"待付款";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.pendingPaymentOrderCount];
            cell.img.image = [UIImage imageNamed:@"pay"];
        }else if (indexPath.row == 1) {
            cell.titleLab.text = @"待确认";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.pendingViewOrderCount];
            cell.img.image = [UIImage imageNamed:@"waitsure"];
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"待提货";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.pendingShipmentOrderCount];
            cell.img.image = [UIImage imageNamed:@"waitgoods"];
        }else if (indexPath.row == 3){
            cell.titleLab.text = @"提货中";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.pickUpGoodsingOrderCount];
            cell.img.image = [UIImage imageNamed:@"goodsing"];
        }else {
            cell.titleLab.text = @"已完成";
            cell.applicationIconNumber.hidden = NO;
            cell.applicationIconNumber.text = [NSString stringWithFormat:@"%ld",(long)self.model.completeOrderCount];
            cell.img.image = [UIImage imageNamed:@"completed"];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.titleLab.text = @"收件箱";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"message"];
        }else{
            cell.titleLab.text = @"发送消息";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"forward"];
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.titleLab.text = @"店铺收藏";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"favor"];
        }else if (indexPath.row == 1) {
            cell.titleLab.text = @"优惠券";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"ticket"];
        }else if (indexPath.row == 2){
            cell.titleLab.text = @"兑换优惠券";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"order"];
        }else if (indexPath.row == 3){
            cell.titleLab.text = @"我的积分";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"present"];
        }else if (indexPath.row == 4){
            cell.titleLab.text = @"预存款";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"recharge"];
        }else if (indexPath.row == 5){
            cell.titleLab.text = @"预存款充值";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"refund"];
        }else if (indexPath.row == 6){
            cell.titleLab.text = @"账户绑定";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"friend_add"];
        }
        else{
            cell.titleLab.text = @"我的售后";
            cell.applicationIconNumber.hidden = YES;
            cell.img.image = [UIImage imageNamed:@"shouhou"];
        }
    }else if (indexPath.section == 4) {
        tabCell.leftLab.text = @"收货地址";
        tabCell.rightLab.text = @"收货地址";
        return tabCell;
    }else if (indexPath.section == 5) {
        tabCell.leftLab.text = @"个人资料";
        tabCell.rightLab.text = @"个人资料";
        return tabCell;
    }else if (indexPath.section == 6) {
        tabCell.leftLab.text = @"修改密码";
        tabCell.rightLab.text = @"修改密码";
        return tabCell;
    }else {
        [butCell.exitBut addTarget:self action:@selector(exitBut) forControlEvents:UIControlEventTouchUpInside];
        return butCell;
    }
    return cell;
}

#pragma mark - 退出登录
-(void)exitBut{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"是否退出登录" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *recordAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
        [NJMineManager logoutWithSuccessHandler:^(id object) {
            NSString *str = (NSString *)object;
            if ([str isEqualToString:@"退出登录成功"]) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:kLoginSuccess];
                [userDefaults removeObjectForKey:kUserName];
                [userDefaults removeObjectForKey:kPassword];
                [userDefaults synchronize];
                
                NJHomeViewController *homeVC = [[NJHomeViewController alloc] init];
                MainNavigationViewController *homeNav = [[MainNavigationViewController alloc] initWithRootViewController:homeVC];
                homeNav.tabBarItem.image = [UIImage imageNamed:@"home"];
                homeVC.title = @"首页";
                
                NJMarketViewController *marketVC = [[NJMarketViewController alloc] init];
                MainNavigationViewController *marketNav = [[MainNavigationViewController alloc] initWithRootViewController:marketVC];
                marketNav.tabBarItem.image = [UIImage imageNamed:@"market"];
                marketVC.title = @"行情";
                
                NJClassifyViewController *classifyVC = [[NJClassifyViewController alloc] init];
                MainNavigationViewController *classifyNav = [[MainNavigationViewController alloc] initWithRootViewController:classifyVC];
                classifyNav.tabBarItem.image = [UIImage imageNamed:@"classify"];
                classifyVC.title = @"选油";
                
                NJShopCarViewController *shopCarVC = [[NJShopCarViewController alloc] init];
                MainNavigationViewController *shopCarNav = [[MainNavigationViewController alloc] initWithRootViewController:shopCarVC];
                shopCarNav.tabBarItem.image = [UIImage imageNamed:@"shopCar"];
                shopCarVC.title = @"购物车";
                
                NJLoginViewController *mineVC = [[NJLoginViewController alloc] init];
                MainNavigationViewController *mineNav = [[MainNavigationViewController alloc] initWithRootViewController:mineVC];
                mineNav.tabBarItem.image = [UIImage imageNamed:@"mine"];
                mineVC.title = @"会员中心";
                
                NJTabBarViewController *tabVC = [[NJTabBarViewController alloc] init];
                tabVC.delegate = self;
                [tabVC setViewControllers:@[homeNav,marketNav,classifyNav,shopCarNav,mineNav]];
                tabVC.tabBar.tintColor = [UIColor orangeColor];
                tabVC.tabBar.backgroundImage = [self createImageWithColor:[UIColor colorWithRed:45.0f/255.0f green:45.0f/255.0f blue:45.0f/255.0f alpha:1]];
                
                APP_WINDOW.rootViewController = tabVC;
                
                [hud showIndeterminaToText:str];
            }
            
        } errorHandler:^(NSString *errorString) {
            [hud showIndeterminaToText:errorString];
        }];
        
        
//        NJLoginViewController *loginVC = [[NJLoginViewController alloc] init];
//        [self.navigationController pushViewController:loginVC animated:YES];
        
//        [self.navigationController popViewControllerAnimated:NO];
//        self.tabBarController.selectedIndex = 0;
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:recordAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (UIImage *) createImageWithColor: (UIColor *) color

{
    
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *myImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return myImage;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return CGSizeMake((kScreenW - 40) / 3, 80);
    }else if (indexPath.section == 1){
        return CGSizeMake((kScreenW - 40) / 5, 80);
    }
    else if (indexPath.section == 2) {
        return CGSizeMake((kScreenW - 40) / 2, 80);
    }else if (indexPath.section == 3) {
        return CGSizeMake((kScreenW - 40) / 4, 80);
    }else{
        return CGSizeMake(kScreenW , 50);
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    CGSize size = CGSizeMake(kScreenW, 10);
    return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1 || section == 2 || section == 3) {
        return CGSizeMake(kScreenW,50);
    }else{
        return CGSizeMake(0, 0);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1) {
        return 5;
    }else if (section == 2) {
        return 2;
    }else if (section == 3) {
        return 8;
    }else{
        return 1;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        NJMineCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
            headerView.leftTitle = [NSString stringWithFormat:@"%@,%@",@"您好",name];
            headerView.rightTitle = [NSString stringWithFormat:@"会员等级:%@",self.model.rankName];
            headerView.rightBut.hidden = YES;
        }else if (indexPath.section == 1) {
            headerView.leftTitle = @"我的订单";
            headerView.rightTitle = @"";
            headerView.rightBut.hidden = NO;
            [headerView.rightBut addTarget:self action:@selector(moreTo) forControlEvents:UIControlEventTouchUpInside];
        }else if (indexPath.section == 2) {
            headerView.leftTitle = @"我的消息";
            headerView.rightTitle = @"";
            headerView.rightBut.hidden = YES;
        }else if (indexPath.section == 3){
            headerView.leftTitle = @"其它";
            headerView.rightTitle = @"";
            headerView.rightBut.hidden = YES;
        }
        return headerView;
    }else {
        NJMineCollectionFooterReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return footerView;
    }
}
-(void)moreTo{
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    NSString *urlStr = @"/member/order/list";
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
    detailsVC.title = @"我的订单";
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/product_favorite/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 1) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/product_notify/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 2) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/consultation/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/order/list?status=PENDING_PAYMENT&hasExpired=false";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 1) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/order/list?status=PENDING_REVIEW&hasExpired=false";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 2){
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/order/list?status=PENDING_SHIPMENT&hasExpired=false";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 3){
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/order/list?status=PICKUP_GOODS_ING&hasExpired=false";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else{
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/order/list?status=COMPLETED&hasExpired=false";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/message_group/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else{
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/message/send";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/store_favorite/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 1) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/coupon_code/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 2) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/coupon_code/exchange";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 3) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/point_log/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 4) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/member_deposit/log";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 5) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/member_deposit/recharge";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }else if (indexPath.row == 6) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/social_user/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
        else if (indexPath.row == 7) {
            NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
            NSString *urlStr = @"/member/aftersales/list";
            detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
            detailsVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:detailsVC animated:YES];
        }
    }else if (indexPath.section == 4) {
        NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
        NSString *urlStr = @"/member/receiver/list";
        detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
        detailsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }else if (indexPath.section == 5) {
        NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
        NSString *urlStr = @"/member/profile/edit";
        detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
        detailsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }else if (indexPath.section == 6) {
        NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
        NSString *urlStr = @"/member/password/edit";
        detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
        detailsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
    
}
@end
