//
//  NJShopCarViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/9.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJShopCarViewController.h"
#import "UIColor+GSColor.h"
#import "Marco.h"
#import "NJShopCarTableViewCell.h"
#import "NJShopCarHeaderView.h"
#import "MBProgressHUD+LYHud.h"
#import "NJShopCarManager.h"
#import "NJShopCarFirstModel.h"
#import "NJShopCarSecondModel.h"
#import "UIImageView+WebCache.h"
#import "NJBannerDetailsViewController.h"
#import "NJLoginManager.h"
#import "TSConst.h"
#import "MJRefresh.h"

@interface NJShopCarViewController ()<NJShopCarTableViewCellDegate>
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;
@property (weak, nonatomic) IBOutlet UILabel *moneyLab;

@property (weak, nonatomic) IBOutlet UIButton *clearAllBut;
@property (weak, nonatomic) IBOutlet UIButton *settlementBut;
@property (nonatomic,assign) BOOL isEditor;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, strong) NJShopCarFirstModel *model;

@property (nonatomic,assign)NSInteger  addCount;
@property (nonatomic, strong) UILabel *defultLab;
@property (nonatomic,assign)NSInteger  shopCar_id;
@property (nonatomic,assign)float  num;
@end

@implementation NJShopCarViewController

#pragma mark - load
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 44, 44);
    [leftItem addTarget:self action:@selector(cliclkEditer:) forControlEvents:UIControlEventTouchUpInside];
    [leftItem setTitle:@"编辑" forState:UIControlStateNormal];
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithCustomView:leftItem];
    self.navigationItem.rightBarButtonItem = buttonItem;
    
    self.tableVIew.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableVIew.tableFooterView = [UIView new];
    [self.tableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([NJShopCarTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableVIew registerClass:[NJShopCarHeaderView class] forHeaderFooterViewReuseIdentifier:@"SectionHeader"];
    // 头部刷新控件
    self.tableVIew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initData)];
    //进入刷新状态
    [self.tableVIew.mj_header beginRefreshing];
    //自动更改透明度
    self.tableVIew.mj_header.automaticallyChangeAlpha = YES;
    self.addCount = 1;
    self.shopCar_id = 0 ;
    self.num = 0.000;
    [self setDefult];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initData];
}

#pragma mark - 获取数据
-(void)initData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJShopCarManager getShopCarNumberWithSuccessHandler:^(NSArray *resultArray) {
        self.dataArray = resultArray;
        if (self.dataArray.count == 0) {
            self.defultLab.hidden = NO;
        }else{
            self.dataArray = resultArray;
            self.defultLab.hidden = YES;
        }
        [self initPriceData];
//        [self.tableVIew reloadData];
        [hud hideAnimated:YES];
        [self.tableVIew.mj_header endRefreshing];
    } errorHandler:^(NSString *errorString) {
        [MBProgressHUD showWithString:errorString];
        [hud hideAnimated:YES];
        [self.tableVIew.mj_header endRefreshing];
    }];
}
-(void)initPriceData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJShopCarManager getShopCarTotalPriceWithSuccessHandler:^(id object) {
        self.model = object;
        [self isLoginToSuccess];
        [self.tableVIew reloadData];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 主页面判断是否登录
-(void)isLoginToSuccess{
    if ([self.model.isLogin isEqualToString:@"1"]) {
        self.moneyLab.text = [NSString stringWithFormat:@"￥%.2f元",self.model.effectivePrice];
        [self.tableVIew reloadData];
    }else{
        self.moneyLab.text = [NSString stringWithFormat:@"￥0.00元"];
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
        if (name == nil) {
            name = @"";
            passWord = @"";
        }
        [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
            [self initData];
        } errorHandler:^(NSString *errorString) {
        }];
    }
}
#pragma mark - 设置默认页面(空数据页面)
-(void)setDefult{
    self.defultLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, kScreenW, 100)];
    self.defultLab.text = @"您的购物车是空的,立即去商城逛逛";
    self.defultLab.numberOfLines = 0;
    self.defultLab.textAlignment = NSTextAlignmentCenter;
    self.defultLab.userInteractionEnabled = YES;
    [self.view addSubview:self.defultLab];
    UITapGestureRecognizer *tapDefult = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClick:)];
    
    [self.defultLab addGestureRecognizer:tapDefult];
}
-(void)labClick:(UITapGestureRecognizer *)tap{
    self.tabBarController.selectedIndex = 0;
}
#pragma mark - 编辑按钮
-(void)cliclkEditer:(UIButton *)btn{
    
    if (!self.isEditor) {
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        self.clearAllBut.hidden = NO;
        self.isEditor = YES;
        
    }else{
        [btn setTitle:@"编辑" forState:UIControlStateNormal];
        self.clearAllBut.hidden = YES;
        self.isEditor = NO;
    }
    
    [self.tableVIew reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - tableSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    for (int i = 0 ; i < self.dataArray.count; i ++) {
        if (section == i) {
            NJShopCarFirstModel *model = self.dataArray[i];
            return model.shopCarArray.count;
        }
    }
    return 0;
}
//返回每个cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//返回区头的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

//区头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NJShopCarHeaderView *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"SectionHeader"];
    if (!sectionHeader)
        sectionHeader = [[NJShopCarHeaderView alloc] initWithReuseIdentifier:@"header"];
    NJShopCarFirstModel *model = self.dataArray[section];
    [sectionHeader.storeName setTitle:model.name forState:UIControlStateNormal];
    [sectionHeader.storeName.titleLabel  sizeToFit];
    sectionHeader.storeName.titleLabel.adjustsFontSizeToFitWidth = YES;
    sectionHeader.storeName.tag = section;
    [sectionHeader.storeName addTarget:self action:@selector(sendTo:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([model.type isEqualToString:@"SELF"]) {
        sectionHeader.statusName.text = @"自营";
        sectionHeader.statusName.hidden = NO;
    }else{
        sectionHeader.statusName.hidden = YES;
    }
    return sectionHeader;
}
#pragma mark - 按钮点击触发
-(void)sendTo:(UIButton *)sender{
    
    NJShopCarFirstModel *model = self.dataArray[sender.tag];
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,model.path];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NJShopCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    NJShopCarFirstModel *model = self.dataArray[indexPath.section];
    NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
    cell.nameLab.text = shopCarModel.name;
    [cell.img sd_setImageWithURL:[NSURL URLWithString:shopCarModel.imageUrl] placeholderImage:[UIImage imageNamed:@"icon_mainIcon"]];
    cell.priceLab.text = [NSString stringWithFormat:@"￥%.2f",shopCarModel.price];
    cell.addressLab.text = shopCarModel.area;
    cell.centerNum.text = [NSString stringWithFormat:@"%.3f",shopCarModel.quantity];
    if (self.isEditor) {
        cell.delectBut.hidden = NO;
        [cell.delectBut addTarget:self action:@selector(onTouchBtnInCell:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.labContentView.hidden = YES;
    }else{
        cell.delectBut.hidden = YES;
        cell.labContentView.hidden = NO;
    }
    cell.delegate = self;
    
    return cell;
}
-(void)LabClick:(NJShopCarTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableVIew indexPathForCell:cell];
    NJShopCarFirstModel *model = self.dataArray[indexPath.section];
    NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,shopCarModel.path];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
-(void)imgClick:(NJShopCarTableViewCell *)cell{
    NSIndexPath *indexPath = [self.tableVIew indexPathForCell:cell];
    NJShopCarFirstModel *model = self.dataArray[indexPath.section];
    NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,shopCarModel.path];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - 减操作
-(void)leftClick:(NJShopCarTableViewCell *)cell number:(float)number{
    number = number - 0.001;
    if (number<=0)  {
        number = 0.001;
        [MBProgressHUD showWithString:@"不能再减了哦"];
    }
    cell.centerNum.text = [NSString stringWithFormat:@"%.3f",number];
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    NSIndexPath *indexPath = [self.tableVIew indexPathForCell:cell];
    NJShopCarFirstModel *model = self.dataArray[indexPath.section];
    NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
    self.shopCar_id = shopCarModel.id;
    self.num = number;
    [NJShopCarManager modifyShopCarWithskuId:shopCarModel.id quantity:number SuccessHandler:^(id object) {
        self.model = object;
        [self isLoginTo];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 加操作
-(void)rightClick:(NJShopCarTableViewCell *)cell number:(float)number{
    number = number + 0.001;
    cell.centerNum.text = [NSString stringWithFormat:@"%.3f",number];
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    NSIndexPath *indexPath = [self.tableVIew indexPathForCell:cell];
    NJShopCarFirstModel *model = self.dataArray[indexPath.section];
    NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
    self.shopCar_id = shopCarModel.id;
    self.num = number;
    [NJShopCarManager modifyShopCarWithskuId:shopCarModel.id quantity:number SuccessHandler:^(id object) {
        self.model = object;
        [self isLoginTo];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 修改数量操作
-(void)centerNum:(NJShopCarTableViewCell *)cell number:(float)number{
    cell.centerNum.text = [NSString stringWithFormat:@"%.3f",number];
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    NSIndexPath *indexPath = [self.tableVIew indexPathForCell:cell];
    NJShopCarFirstModel *model = self.dataArray[indexPath.section];
    NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
    self.shopCar_id = shopCarModel.id;
    self.num = number;
    [NJShopCarManager modifyShopCarWithskuId:shopCarModel.id quantity:number SuccessHandler:^(id object) {
        self.model = object;
        [self isLoginTo];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 删除单行
- (void)onTouchBtnInCell:(UIButton *)sender {
    CGPoint point = sender.center;
    point = [self.tableVIew convertPoint:point fromView:sender.superview];
    NSIndexPath* indexPath = [self.tableVIew indexPathForRowAtPoint:point];
    NSLog(@"%ld-%ld",(long)indexPath.section,(long)indexPath.row);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"是否删除" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *recordAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NJShopCarFirstModel *model = self.dataArray[indexPath.section];
        NJShopCarSecondModel *shopCarModel = model.shopCarArray[indexPath.row];
        self.shopCar_id = shopCarModel.id;
        MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
        [NJShopCarManager deleteShopCarWithskuId:shopCarModel.id SuccessHandler:^(id object) {
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
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:recordAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
#pragma mark - （删除）判断是否登录操作
-(void)isLogin{
    if ([self.model.isLogin isEqualToString:@"1"]) {
        [self initData];
    }else{
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
        [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
            MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
            [NJShopCarManager deleteShopCarWithskuId:self.shopCar_id SuccessHandler:^(id object) {
                [self initData];
                [hud hideAnimated:YES];
            } errorHandler:^(NSString *errorString) {
                if (hud) {
                    [hud showIndeterminaToText:errorString];
                } else {
                    [MBProgressHUD showWithString:errorString];
                }
            }];
        } errorHandler:^(NSString *errorString) {
        }];
    }
}
#pragma mark - （修改数量）判断是否登录操作
-(void)isLoginTo{
    if ([self.model.isLogin isEqualToString:@"1"]) {
        [self initData];
    }else{
        NSString *name = [[NSUserDefaults standardUserDefaults] valueForKey:kUserName];
        NSString *passWord = [[NSUserDefaults standardUserDefaults] valueForKey:kPassword];
        [NJLoginManager loginWithusername:name password:passWord successHandler:^(id object) {
            MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
            [NJShopCarManager modifyShopCarWithskuId:self.shopCar_id quantity:self.num SuccessHandler:^(id object) {
                [self initData];
                [hud hideAnimated:YES];
            } errorHandler:^(NSString *errorString) {
                if (hud) {
                    [hud showIndeterminaToText:errorString];
                } else {
                    [MBProgressHUD showWithString:errorString];
                }
            }];
        } errorHandler:^(NSString *errorString) {
        }];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - 结算操作
- (IBAction)settlement:(id)sender {
    if ([self.moneyLab.text isEqualToString:@"￥0.00元"]) {
        [MBProgressHUD showWithString:@"暂无商品结算"];
    }else{
        MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
        [NJShopCarManager validationIsSettlementWithSuccessHandler:^(id object) {
            NSString* status = (NSString *)object;
            if (status.integerValue == 1) {
                [hud hideAnimated:YES];
                NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
                NSString *urlStr = @"/order/checkout";
                detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,urlStr];
                detailsVC.title = @"结算";
                detailsVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:detailsVC animated:YES];
            }else{
                [hud showIndeterminaToText:@"购物车内产品地址不一致，不能一起结算"];
            }
        } errorHandler:^(NSString *errorString) {
            if (hud) {
                [hud showIndeterminaToText:errorString];
            } else {
                [MBProgressHUD showWithString:errorString];
            }
        }];
        
    }
}
#pragma mark - 清空操作
- (IBAction)clearAll:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:@"是否清空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *recordAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
        [NJShopCarManager clearShopCarWithSuccessHandler:^(id object) {
            [self initData];
            [hud hideAnimated:YES];
        } errorHandler:^(NSString *errorString) {
            if (hud) {
                [hud showIndeterminaToText:errorString];
            } else {
                [MBProgressHUD showWithString:errorString];
            }
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:recordAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
