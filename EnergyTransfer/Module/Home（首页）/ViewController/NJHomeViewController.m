
//
//  NJHomeViewController.m
//  EnergyTransfer
//
//  Created by Liandi on 2018/10/31.
//  Copyright © 2018年 Liandi. All rights reserved.
//

#import "NJHomeViewController.h"
#import "UIColor+GSColor.h"
#import "Marco.h"
#import "NJHomeCollectionViewCell.h"
#import "NJHomeCollectionReusableView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "NJHomeMarketCollectionViewCell.h"
#import "AAChartKit.h"
#import "NJHomeManager.h"
#import "MBProgressHUD+LYHud.h"
#import "NJHomeChartModel.h"
#import "NJHomeMarketModel.h"
#import "TXScrollLabelView.h"
#import "NJHomeProductCategoriesModel.h"
#import "NJHomeProductsModel.h"
#import "NJHomeScrollTitleModel.h"
#import "NJHomeBannerModel.h"
#import "NJBannerDetailsViewController.h"
#import "MJRefresh.h"
#import "MenuControlView.h"
#import "NJHomeHotModel.h"
#import "TSConst.h"

@interface NJHomeViewController ()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AAChartViewDidFinishLoadDelegate,TXScrollLabelViewDelegate,MenuControlViewDeleagte>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIView *header;
@property (strong, nonatomic) NSArray *imagesURLStrings;
@property (strong, nonatomic) NSArray *titles;
@property (strong, nonatomic) UICollectionView *marketCollectView;

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *productDataArray;
@property (nonatomic, copy) NSArray *scrollTitleDataArray;
@property (nonatomic, copy) NSArray *bannerDataArray;
@property (nonatomic, strong) NSMutableArray *resultArray;
@property (nonatomic, strong) NSMutableArray *bannerArray;

@property (nonatomic, strong) NJHomeChartModel  *model;
@property (nonatomic, strong) NJHomeMarketModel  *marketModel;
@property (nonatomic, strong) NJHomeScrollTitleModel  *scrollTitleModel;
@property (nonatomic, strong) NJHomeBannerModel  *bannerModel;
@property (weak, nonatomic) IBOutlet UIView *scrollLabelView;
@property (nonatomic, copy) NSString *scrollTitle;
@property(strong , nonatomic)MenuControlView *MenuControlView;
@property (strong, nonatomic) NSArray *MenuDataArray;

@end

@implementation NJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self makeUI];
    [self initScrollTitleData];
//    [self initData];
}
#pragma mark - 获取Banner数据
-(void)initBannerData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJHomeManager getBannerWithSuccessHandler:^(NSArray *resultArray) {
        self.bannerDataArray = resultArray;
        [hud hideAnimated:YES];
        [self setupUI];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 获取走马灯数据
-(void)initScrollTitleData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJHomeManager getScrollTitleWithSuccessHandler:^(NSArray *resultArray) {
        self.scrollTitleDataArray = resultArray;
        [hud hideAnimated:YES];
        [self initScrollTitle];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 走马灯
-(void)initScrollTitle{
    self.resultArray = [NSMutableArray array];
    for (int i = 0 ; i < self.scrollTitleDataArray.count; i ++) {
        self.scrollTitleModel = self.scrollTitleDataArray[i];
        self.scrollTitle = [NSString stringWithFormat:@"%@ %@ %@ %ld",self.scrollTitleModel.area,self.scrollTitleModel.date,self.scrollTitleModel.name,(long)self.scrollTitleModel.shippedQuantity];

        [self.resultArray addObject:self.scrollTitle];
    }
//    NSString *string = [self.resultArray componentsJoinedByString:@"        "];
//    NSLog(@"-----------%@",string);
    TXScrollLabelView *scrollLabelView = nil;
    scrollLabelView = [TXScrollLabelView scrollWithTextArray:self.resultArray type:TXScrollLabelViewTypeLeftRight velocity:1 options:UIViewAnimationOptionCurveEaseInOut inset:UIEdgeInsetsZero];
    scrollLabelView.scrollLabelViewDelegate = self;
    scrollLabelView.frame = CGRectMake(0, 0, kScreenW, 30);
    [self.scrollLabelView addSubview:scrollLabelView];
    scrollLabelView.tx_centerX  = [UIScreen mainScreen].bounds.size.width * 0.5;
    scrollLabelView.scrollInset = UIEdgeInsetsMake(0, 10 , 0, 10);
    scrollLabelView.scrollSpace = 10;
    [scrollLabelView setScrollTitleColor:[UIColor blackColor]];
    scrollLabelView.font = [UIFont systemFontOfSize:15];
    scrollLabelView.textAlignment = NSTextAlignmentCenter;
    scrollLabelView.backgroundColor = [UIColor whiteColor];
    [scrollLabelView beginScrolling];
}
#pragma mark - 走马灯代理
- (void)scrollLabelView:(TXScrollLabelView *)scrollLabelView didClickWithText:(NSString *)text atIndex:(NSInteger)index{
    NSLog(@"%@--%ld",text, index);
}
#pragma mark - UICollectionView设置
-(void)makeUI{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NJHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJHomeCollectionViewCell"];
    
    // 注册头视图
    [self.collectionView registerClass:[NJHomeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    //设置滚动范围偏移
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(400, 0, 0, 0);
    //设置内容范围偏移
    self.collectionView.contentInset = UIEdgeInsetsMake(400, 0, 0, 0);
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.tag = 100;
    
    // 头部刷新控件
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(initProductData)];
    //进入刷新状态
    [self.collectionView.mj_header beginRefreshing];
    //自动更改透明度
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
}
#pragma mark - UICollectionView头区
-(void)setupUI{
    
    //给collectionView添加子控件 这里是作为头部 记得设置y轴为负值
    self.header = [[UIView alloc] initWithFrame:CGRectMake(0, -400, CGRectGetWidth(self.collectionView.bounds), 400)];
    self.header.backgroundColor = [UIColor whiteColor];
    [self.collectionView addSubview:self.header];
    
    //图片轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0,  CGRectGetWidth(self.collectionView.bounds), 150)  delegate:self placeholderImage:[UIImage imageNamed:@"industryInformation"]];
    
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.header addSubview:cycleScrollView];
    
    //采用网络图片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.bannerArray = [NSMutableArray array];
        for (int i = 0 ; i < self.bannerDataArray.count; i ++) {
            self.bannerModel = self.bannerDataArray[i];
            [self.bannerArray addObject:self.bannerModel.path];
        }
        cycleScrollView.imageURLStringsGroup = self.bannerArray;
    });
    cycleScrollView.clickItemOperationBlock = ^(NSInteger index) {
        self.bannerModel = self.bannerDataArray[index];
        NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
        detailsVC.urlString = self.bannerModel.url;
        detailsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailsVC animated:YES];
    };
    
    //油价行情
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(cycleScrollView.frame), CGRectGetWidth(self.collectionView.bounds), 40)];
    [self.header addSubview:titleView];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    img.image = [UIImage imageNamed:@"indevTit1"];
    [titleView addSubview:img];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, CGRectGetWidth(self.collectionView.bounds) - 60, 40)];
    titleLabel.text = @"1F / 油价行情";
    titleLabel.textColor = KRGBHex(0x2a5caa);
    titleLabel.font = [UIFont systemFontOfSize:16];
    [titleView addSubview:titleLabel];
    
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.marketCollectView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView.frame), CGRectGetWidth(self.collectionView.bounds), 85) collectionViewLayout:layout];
    self.marketCollectView.delegate = self;
    self.marketCollectView.dataSource = self;
    self.marketCollectView.tag = 200;
    self.marketCollectView.backgroundColor =[UIColor whiteColor];
    [self.header addSubview:self.marketCollectView];
    
    [self.marketCollectView registerNib:[UINib nibWithNibName:@"NJHomeMarketCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NJHomeMarketCollectionViewCell"];
    
    //油价行情
    UIView *titleView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.marketCollectView.frame), CGRectGetWidth(self.collectionView.bounds), 40)];
    [self.header addSubview:titleView2];
    UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    img2.image = [UIImage imageNamed:@"indevTit2"];
    [titleView2 addSubview:img2];
    UILabel *titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(38, 0, CGRectGetWidth(self.collectionView.bounds) - 60, 40)];
    titleLabel2.text = @"2F / 推荐产品 热销产品";
    titleLabel2.textColor = KRGBHex(0xde4849);
    titleLabel2.font = [UIFont systemFontOfSize:16];
    [titleView2 addSubview:titleLabel2];
    
    self.MenuControlView = [[MenuControlView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleView2.frame), CGRectGetWidth(self.collectionView.bounds), 85) withmacCol:2 maxRow:1];
    self.MenuControlView.delegate = self;
    [self.header addSubview:self.MenuControlView];
}
#pragma mark - CustomerScrollViewDeleagte
-(void)menuControlViewDeleagte:(MenuControlView *)MenuControlViewDeleagte index:(NSInteger)index{
    
    NJHomeHotModel * model = _MenuDataArray[index];
    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
    detailsVC.urlString = [NSString stringWithFormat:@"%@%@",hostName,model.path];
    detailsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 获取油价行情数据
-(void)initMarketData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJHomeManager getMarketNumberWithSuccessHandler:^(id object) {
        self.marketModel = object;
        [hud hideAnimated:YES];
        [self.marketCollectView reloadData];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 获取推荐产品数据
-(void)initHotData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJHomeManager getHotWithSuccessHandler:^(NSArray *resultArray) {
        self.MenuDataArray = resultArray;
        self.MenuControlView.dataArray = self.MenuDataArray;
        [hud hideAnimated:YES];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}

#pragma mark - 获取图表数据
-(void)initData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJHomeManager getChartsNumberWithSuccessHandler:^(NSArray *resultArray) {
        self.dataArray = resultArray;
        [hud hideAnimated:YES];
        
        AAChartType chartType;
        
        chartType = AAChartTypeLine;
        
        [self setUpTheAAChartViewWithChartType:chartType];
    } errorHandler:^(NSString *errorString) {
        if (hud) {
            [hud showIndeterminaToText:errorString];
        } else {
            [MBProgressHUD showWithString:errorString];
        }
    }];
}
#pragma mark - 获取产品分类数据
-(void)initProductData{
    MBProgressHUD *hud = [MBProgressHUD showIndeterminateInView:self.view];
    [NJHomeManager getProduct_categoryWithSuccessHandler:^(NSArray *resultArray) {
        self.productDataArray = resultArray;
        [hud hideAnimated:YES];
        [self initMarketData];
        [self initBannerData];
        [self initHotData];
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
    } errorHandler:^(NSString *errorString) {
        [MBProgressHUD showWithString:errorString];
        [hud hideAnimated:YES];
        [self.collectionView.mj_header endRefreshing];
    }];
}
#pragma mark - 图表设置
- (void)setUpTheAAChartViewWithChartType:(AAChartType)chartType {
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(0, CGRectGetMaxY(self.marketCollectView.frame), kScreenW,150);
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
    //    设置aaChartVie 的内容高度(content height)
//    self.aaChartView.contentHeight = 150;
    [self.header addSubview:self.aaChartView];
    
    //设置 AAChartView 的背景色是否为透明
    self.aaChartView.isClearBackgroundColor = YES;
    
    self.aaChartModel= AAChartModel.new
    .chartTypeSet(chartType)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
    .legendEnabledSet(false)
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置Y轴标题
    .tooltipValueSuffixSet(@"")//设置浮动提示框单位后缀
    .backgroundColorSet(@"#4b2b7f")
    .yAxisGridLineWidthSet(@0);//y轴横向分割线宽度为0(即是隐藏分割线)
    NSMutableArray *XArr = [@[] mutableCopy];
    NSMutableArray *BrentArr = [@[] mutableCopy];
    NSMutableArray *WTIArr = [@[] mutableCopy];
    for (int i = 0 ; i < self.dataArray.count; i++){
        self.model = self.dataArray[i];
        [XArr addObject:self.model.hmDate];
        [BrentArr addObject:@(self.model.brentOilPrice.doubleValue)];
        [WTIArr addObject:@(self.model.clOilPrice.doubleValue)];
    }
    _aaChartModel.markerRadius = @0;//设置折线连接点的半径长度
    _aaChartModel.categories = XArr;//设置 X 轴坐标文字内容
    _aaChartModel.seriesSet(@[
                 AASeriesElement.new
                 .nameSet(@"Brent")
                 .dataSet(BrentArr),
                 AASeriesElement.new
                 .nameSet(@"WTI")
                 .dataSet(WTIArr),
                 ]
               );
    
    
    /*配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果(NOTE:必须设置 Y 轴可见)*/
    //        [self configureTheYAxisPlotLineForAAChartView];
    
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}

#pragma mark - 图表AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}
#pragma mark - UICollectionView代理
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        NJHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJHomeCollectionViewCell" forIndexPath:indexPath];
        NJHomeProductCategoriesModel *model = self.productDataArray[indexPath.section];
        NJHomeProductsModel *productModel = model.productsArray[indexPath.row];
        cell.titleName.text = productModel.name;
        cell.titleName.textColor = KRGBHex(0x2f84c4);
        BOOL isLogin = [[NSUserDefaults standardUserDefaults] boolForKey:kLoginSuccess];
        if (isLogin) {
            cell.priceLabel.text = [NSString stringWithFormat:@"￥%.2f",productModel.price];
        }else{
            cell.priceLabel.text = @"企业用户可见";
        }
        
        return cell;
    }else{
        NJHomeMarketCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"NJHomeMarketCollectionViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.titleLab.text = @"布伦特原油";
            cell.centerLab.text = self.marketModel.brentOilPrice;
            cell.leftLab.text = self.marketModel.brentIncreasePrice;
            cell.rightLab.text = self.marketModel.brentIncreasePricePercent;
            if (self.marketModel.brentIncreasePrice.doubleValue >= 0) {
                cell.centerImg.image = [UIImage imageNamed:@"uparrow"];
            }else{
                cell.centerImg.image = [UIImage imageNamed:@"arrow"];
            }
        }else{
            cell.titleLab.text = @"NYMEX原油";
            cell.centerLab.text = self.marketModel.clOilPrice;
            cell.leftLab.text = self.marketModel.clIncreasePrice;
            cell.rightLab.text = self.marketModel.clIncreasePricePercent;
            if (self.marketModel.clIncreasePrice.doubleValue >= 0) {
                cell.centerImg.image = [UIImage imageNamed:@"uparrow"];
            }else{
                cell.centerImg.image = [UIImage imageNamed:@"arrow"];
            }
        }
        return cell;
    }
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView.tag == 100) {
        return self.productDataArray.count;
    }else{
        return 1;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 100) {
        return CGSizeMake((kScreenW - 20) / 2, 120);
    }else{
        return CGSizeMake((CGRectGetWidth(collectionView.bounds) - 40) / 2, 85);
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (collectionView.tag == 100) {
        return CGSizeMake(kScreenW,40);
    }else{
        return CGSizeMake(0,0);
    }
    
}
//两个cell之间的间距（同一行的cell的间距）
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag == 100) {
        return 0;
    }else{
        return 20;
    }
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (collectionView.tag == 100) {
        return 0;
    }else{
        return 20;
    }
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView.tag == 100) {
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }else{
        return UIEdgeInsetsMake(0, 10, 0, 10);
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 100) {
        for (int i = 0 ; i < self.productDataArray.count; i ++) {
            if (section == i) {
                NJHomeProductCategoriesModel *model = self.productDataArray[i];
                return model.productsArray.count;
            }
        }
        return 0;
    }else{
        return 2;
    }
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader) {
        NJHomeCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        NJHomeProductCategoriesModel *model = self.productDataArray[indexPath.section];
        headerView.title = model.name;
        headerView.img.image = [UIImage imageNamed:@"headerIcon"];
        headerView.button.tag = indexPath.section;
        [headerView.button addTarget:self action:@selector(sendTo:) forControlEvents:UIControlEventTouchUpInside];
        return headerView;
    }else {
        return nil;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag == 100) {
        NJHomeProductCategoriesModel *model = self.productDataArray[indexPath.section];
        NJHomeProductsModel *productModel = model.productsArray[indexPath.row];
        NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
        NSString *urlStr = @"/product/detail/";
        detailsVC.urlString = [NSString stringWithFormat:@"%@%@%ld",hostName,urlStr,(long)productModel.id];
        detailsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
}
#pragma mark - 按钮点击触发
- (void)sendTo:(UIButton *)sender{
    
//    NJHomeProductCategoriesModel *model = self.productDataArray[sender.tag];
//    NJBannerDetailsViewController *detailsVC = [[NJBannerDetailsViewController alloc]init];
//    NSString *urlStr = @"/product/list/";
//    detailsVC.urlString = [NSString stringWithFormat:@"%@%@%ld",hostName,urlStr,(long)model.id];
//    [self.navigationController pushViewController:detailsVC animated:YES];
    
}
@end
