
//
//  MHHomeViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *CellInder = @"commodity";
static NSString *everDayCell = @"everDayCell";
static NSString *bigCell = @"bigCell";
static NSString *newsCell = @"newsCell";
#import "MHHomeViewController.h"
#import "MHHomeHeadImageView.h"

#import "CCHeaderCollectionReusableView.h"
#import "CCCommodityCollectionViewCell.h"
#import "CCEverDayTeCollectionViewCell.h"
#import "MHBigMubltCollectionViewCell.h"
#import "MHNewsCollectionViewCell.h"

#import "MHGuoyiFirstPageModl.h"
#import "MHBannerModel.h"
#import "CCTabbarViewController.h"
#import "MHNewsListViewController.h"
#import "LSDetainViewController.h"
@interface MHHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) MHHomeHeadImageView           *headImageView;
@property (strong, nonatomic) UICollectionView              *collectionView;
@property (strong, nonatomic) NSArray                       *titleArray;
@property (strong, nonatomic) NSMutableArray *menusArray;
@property (strong, nonatomic) NSMutableArray *best_classArray;
@property (strong, nonatomic) NSMutableArray *guoyiArray;
@property (strong, nonatomic) NSMutableArray *best_class_newsArray;
@property (strong, nonatomic) NSMutableArray *newsArray;
@property (strong, nonatomic) NSMutableArray *bannerArray;

@end

@implementation MHHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self customSearchNavBar];
    [self setupUI];
//    [self initData];
}

- (void)initData {
    self.menusArray = [NSMutableArray array];
    self.best_classArray = [NSMutableArray array];
    self.guoyiArray = [NSMutableArray array];
    self.best_class_newsArray = [NSMutableArray array];
    self.newsArray = [NSMutableArray array];
    XYWeakSelf;
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:@"index"
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        weakSelf.showErrorView = NO;
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *dict = dic[@"data"];
            weakSelf.menusArray = [dict[@"menus"] mutableCopy];
            weakSelf.best_classArray = [dict[@"best_class"] mutableCopy];
            weakSelf.best_class_newsArray = [dict[@"best_class_news"] mutableCopy];
            weakSelf.bannerArray = [dict[@"banner"] mutableCopy];
            weakSelf.newsArray = [dict[@"news"] mutableCopy];
            weakSelf.headImageView.imageArray = weakSelf.bannerArray;
            weakSelf.headImageView.dataArray = weakSelf.menusArray;
            [weakSelf.collectionView reloadData];
        }else {
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
        [weakSelf.collectionView.mj_header endRefreshing];
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)setupUI {
    [self layoutCollectionView];
    XYWeakSelf;
    self.headImageView.menusClick = ^(NSInteger number) {
        switch (number) {//
            case 0:{
                [[CCTabbarViewController getTabBarController] setSelectedIndex:1];
            }

                break;
            case 1:
                [[CCTabbarViewController getTabBarController] setSelectedIndex:2];
                break;
            case 2:
            {
 
            }
                break;
            case 3:
            {

            }
                break;
            case 4:
            {

            }
                break;
            default:
                break;
        }
    };
    self.baseTableView = (UITableView *)self.collectionView;
}
- (void)layoutCollectionView {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 12;
    flowLayout.minimumInteritemSpacing = 10;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, Window_W, Window_H - 49 - NAVIGATION_BAR_HEIGHT-HOME_INDICATOR_HEIGHT) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate   = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    
    
    [self.collectionView addSubview:self.headImageView];
    self.collectionView.contentInset = UIEdgeInsetsMake(256, 0, 0, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.collectionView registerNib:CCCommodityCollectionViewCell.loadNib
          forCellWithReuseIdentifier:CellInder];
    [self.collectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:@"footer"];
    [self.collectionView registerNib:CCHeaderCollectionReusableView.loadNib
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"header"];
    [self.collectionView registerNib:CCEverDayTeCollectionViewCell.loadNib
          forCellWithReuseIdentifier:everDayCell];
    [self.collectionView registerNib:MHBigMubltCollectionViewCell.loadNib
          forCellWithReuseIdentifier:bigCell];
    [self.collectionView registerNib:MHNewsCollectionViewCell.loadNib
          forCellWithReuseIdentifier:newsCell];
    self.collectionView.contentOffset = CGPointMake(0, - 256);
    XYWeakSelf;
    self.headImageView.homeBannerClick = ^(NSInteger number) {//轮播图

    };
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf initData];
    }];
    self.collectionView.mj_header.ignoredScrollViewContentInsetTop = 256;
}
#pragma mark - Get
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"今日直播",@"试听推荐",@"资讯推荐"];
    }
    return _titleArray;
}

#pragma  mark - UICollectionViewDelegate/DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.titleArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 1) {
        return self.best_class_newsArray.count;
    } else if (section == 2){
        return 1;
    } else if (section == 3){
        return self.newsArray.count;
    }
    return self.best_classArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        CCEverDayTeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:everDayCell
                                                                                        forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2){
        MHBigMubltCollectionViewCell *cell= [collectionView dequeueReusableCellWithReuseIdentifier:bigCell
                                                                                      forIndexPath:indexPath];
        cell.dataArray = self.guoyiArray;
        return cell;
    } else if (indexPath.section == 3){
        MHNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newsCell
                                                                                   forIndexPath:indexPath];
        return cell;
    } else {
        CCCommodityCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:CellInder
                                                                                         forIndexPath:indexPath];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake((Window_W-35)/2, 145);
    } else if (indexPath.section == 1){
        return CGSizeMake(Window_W-24, 115);
    } else if (indexPath.section == 2){
        return CGSizeMake(Window_W, 140);
    } else if (indexPath.section == 3){
        return CGSizeMake(Window_W, 97);
    }
    return CGSizeMake((Window_W-35)/2, 145);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {

    } else if (indexPath.section == 1){

    } else if (indexPath.section == 3){

    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CCHeaderCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        view.titleLab.text =self.titleArray[indexPath.section];
        if (indexPath.section == 0) {
            XYWeakSelf;
            [view.moreBtn addTapGestureWithBlock:^(UIView *gestureView) {

            }];
        } else if (indexPath.section == 3){
            XYWeakSelf;
            [view.moreBtn addTapGestureWithBlock:^(UIView *gestureView) {
                MHNewsListViewController *Vc = [MHNewsListViewController new];
                [weakSelf.navigationController pushViewController:Vc animated:YES];
            }];
        }
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        return view;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(Window_W, 42);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    ///!!!: footer高度
    return CGSizeMake(Window_W, .001f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == 3) {
        return 0.1f;
    }
    return 12.f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
    
}


#pragma mark  -  get
- (MHHomeHeadImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[MHHomeHeadImageView alloc] initWithFrame:CGRectMake(0, -256, Window_W, 253+90)];
    }
    return _headImageView;
}










@end
