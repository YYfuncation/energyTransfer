//
//  NJMarketChildViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/11/13.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJMarketChildViewController.h"
#import "NJMarketChildTableViewCell.h"
#import "MJRefresh.h"
#import "Marco.h"
#import "MBProgressHUD+LYHud.h"
#import "NJMarketManager.h"
#import "NJMarketModel.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "NJMarketDetailsViewController.h"

@interface NJMarketChildViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *finallArray;

@end

@implementation NJMarketChildViewController

static NSString *const marketListTableCellIdf = @"marketListTableCellIdf";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    // 设置 view 的 frame(将设置 frame 提到设置 tableHeaderView 之前)
    view.frame = CGRectMake(30, 0, kScreenW - 60, 150);
    UIImageView *img = [[UIImageView alloc]init];
    img.frame = view.frame;
    if (self.category_type == 9951) {
        img.image = [UIImage imageNamed:@"industryInformation"];
    }else if (self.category_type == 9952){
        img.image = [UIImage imageNamed:@"newsBanner"];
    }else{
        img.image = [UIImage imageNamed:@"oilPrice"];
    }
    
    [view addSubview:img];
    // 设置 tableHeaderView
    self.tableView.tableHeaderView = view;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NJMarketChildTableViewCell class]) bundle:nil] forCellReuseIdentifier:marketListTableCellIdf];
    // 头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    //进入刷新状态
    [self.tableView.mj_header beginRefreshing];
    //自动更改透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 尾部刷新控件
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //自动更改透明度
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}
#pragma mark - private

- (void)loadData {
    self.pageNumber = 1;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NJMarketManager getMarketListWithArticleCategory_id:self.category_type pageSize:10 pageNumber:self.pageNumber successHandler:^(id object) {
        self.dataArray = (NSMutableArray *)object;
        if (self.dataArray.count == 0) {
            [self initDefultView];
        }else{
            self.finallArray = self.dataArray;
        }
        [self.tableView reloadData];
        self.pageNumber ++;
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
    } errorHandler:^(NSString *errorString) {
        [MBProgressHUD showWithString:errorString];
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
    }];
}
-(void)loadMoreData{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NJMarketManager getMarketListWithArticleCategory_id:self.category_type pageSize:10 pageNumber:self.pageNumber successHandler:^(id object) {
        self.dataArray = (NSMutableArray *)object;
        [self.finallArray addObjectsFromArray:self.dataArray];
        [self.tableView reloadData];
        self.pageNumber ++;
        [hud hideAnimated:YES];
        [self.tableView.mj_footer endRefreshing];
    } errorHandler:^(NSString *errorString) {
        [MBProgressHUD showWithString:errorString];
        [hud hideAnimated:YES];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)initDefultView{
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenW/2-50, kScreenH/2-40, 100, 80)];
    image.image = [UIImage imageNamed:@"zanwu"];
    [self.view addSubview:image];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(image.frame)+8, kScreenW, 40)];
    lab.text = @"暂无数据";
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor grayColor];
    lab.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:lab];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.finallArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NJMarketChildTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:marketListTableCellIdf forIndexPath:indexPath];
    NJMarketModel *model = self.finallArray[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:model.cover_picture] placeholderImage:[UIImage imageNamed:@"icon_mainIcon"]];
    cell.titleLable.text = model.title;
    cell.contextLable.text = model.text;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *strDate = [dateFormatter stringFromDate:[self getDateTimeFromMilliSeconds:model.createdDate]];
    cell.yearLable.text = strDate;
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM/dd"];
    NSString *strDate1 = [dateFormatter1 stringFromDate:[self getDateTimeFromMilliSeconds:model.createdDate]];
    cell.dateLable.text = strDate1;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NJMarketModel *model = self.finallArray[indexPath.row];
    NJMarketDetailsViewController *detailsVC = [[NJMarketDetailsViewController alloc]init];
    detailsVC.type_id = model.id;
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

#pragma mark - 将时间戳转换为NSDate类型
-(NSDate *)getDateTimeFromMilliSeconds:(long long) miliSeconds
{
    NSTimeInterval tempMilli = miliSeconds;
    NSTimeInterval seconds = tempMilli/1000.0;//这里的.0一定要加上，不然除下来的数据会被截断导致时间不一致
    return [NSDate dateWithTimeIntervalSince1970:seconds];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
