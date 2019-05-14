//
//  NJClassifyViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/9.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJClassifyViewController.h"
#import "UIColor+GSColor.h"
#import "Marco.h"
#import "NJClassifyCollectionViewCell.h"
#import "NJClassifyTableViewCell.h"
#import "NJClassifyManager.h"
#import "NJClassifyFirstModel.h"
#import "NJClassfiySecondModel.h"
#import "NJClassifyThirdModel.h"
#import "MBProgressHUD+LYHud.h"
#import "NJClassflyRightModel.h"
#import "NJClassflyCollectionReusableView.h"
#import "NJBannerDetailsViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface NJClassifyViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *dishArray;
@property (nonatomic, strong) NJClassifyFirstModel *model;
@end

@implementation NJClassifyViewController

static NSString *const TableCellIdf = @"TableCellIdf";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenW/3, kScreenH - KNaviH - kTabbarH - STATUS_BAR_HEIGHT) style:UITableViewStylePlain];
    self.table.dataSource = self;
    self.table.delegate = self;
    self.table.rowHeight = 40;
    self.table.tableFooterView = [UIView new];
    self.table.showsVerticalScrollIndicator = NO;
    [self.table registerClass:[NJClassifyTableViewCell class] forCellReuseIdentifier:TableCellIdf];
    self.table.backgroundColor = [UIColor clearColor];
//    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    [self.table selectRowAtIndexPath:0 animated:YES scrollPosition:UITableViewScrollPositionTop];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(kScreenW/3, 0, kScreenW * 2 / 3,kScreenH - KNaviH - kTabbarH - STATUS_BAR_HEIGHT) collectionViewLayout:layout];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    self.collection.backgroundColor = [UIColor clearColor];
    [self.collection registerNib:[UINib nibWithNibName:@"NJClassifyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJClassifyCollectionViewCell"];
    
    // 注册头视图
    [self.collection registerClass:[NJClassflyCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    [self.view addSubview:self.collection];
    
    self.selectIndex = 0;
    
    [self initData];
    
}
-(void)initData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJClassifyManager getClassifyWithSuccessHandler:^(NSArray *resultArray) {
        self.dataArray = resultArray;
        [hud hideAnimated:YES];
        [self.table reloadData];
        [self.table selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        NJClassifyFirstModel *model = self.dataArray[0];
        [self initNumberDatabrandName:model.name color:model.color];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionView代理
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NJClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJClassifyCollectionViewCell" forIndexPath:indexPath];
    NJClassflyRightModel *model = self.dishArray[indexPath.section];
    NJClassfiySecondModel *md = model.secnondArray[indexPath.row];
    cell.nameLab.text = md.name;
    cell.nameLab.textColor = [UIColor blackColor];
    if (indexPath.section == 0) {
        cell.backgroundColor = [UIColor colorWithRed:252.0f/255.0f green:199.0f/255.0f blue:11.0f/255.0f alpha:1];
    }else{
        cell.backgroundColor = [UIColor colorWithRed:124.0f/255.0f green:220.0f/255.0f blue:224.0f/255.0f alpha:1];
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        NJClassflyCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        NJClassflyRightModel *model = self.dishArray[indexPath.section];
        headerView.leftTitle = model.name;
        return headerView;
    }else{
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenW,40);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dishArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    for (int i = 0 ; i < self.dataArray.count; i ++) {
        if (section == i) {
            NJClassflyRightModel *model = self.dishArray[i];
            return model.secnondArray.count;
        }
    }
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenW * 2 / 3 - 40) / 2, 50);
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NJClassflyRightModel *model = self.dishArray[indexPath.section];
    NJClassfiySecondModel *md = model.secnondArray[indexPath.row];
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,md.path];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark - tableSoure
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NJClassifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TableCellIdf forIndexPath:indexPath];
    NJClassifyFirstModel *model = self.dataArray[indexPath.row];
    cell.name.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.selectIndex = (int)indexPath.row;
    NJClassifyFirstModel *model = self.dataArray[indexPath.row];
    [self initNumberDatabrandName:model.name color:model.color];
}
-(void)initNumberDatabrandName:(NSString *)brandName color:(NSString *)color{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    
    [NJClassifyManager getClassifyNumberWithbrandName:brandName color:color SuccessHandler:^(NSArray *resultArray) {
        self.dishArray = resultArray;
        [self.collection reloadData];
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
@end
