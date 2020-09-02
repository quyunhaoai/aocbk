
//
//  MHHelpViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

static NSString *CellIdentifier = @"UITableViewCell";
#import "MHHelpViewController.h"
#import "CCPersonHeaderView.h"
#import "CCPersonCenterTableViewCell.h"

#import "MHQustReturnViewController.h"
#import "MHSecuritySetViewController.h"
@interface MHHelpViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong,nonatomic)CCPersonHeaderView *headerView;
@property (nonatomic,strong) UITableView *tableView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *iconArray;
@property (strong, nonatomic) NSArray *controllerArray;

@end

@implementation MHHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self addSubViews];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)addSubViews {
    [self customNavBarWithBlackTitle:@"帮助中心"];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.headerView.frame = CGRectMake(0, 0, Window_W, 245);
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:CCPersonCenterTableViewCell.className bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CellIdentifier];

}


#pragma mark Get
- (NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"已购内容丢失",
                       @"账号安全提示",
        ];
    }
    return _iconArray;
}
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"已购内容丢失",
                       @"账号安全提示",
        ];
    }
    return _titleArray;
}

- (NSArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = @[@"CCBaseViewController",
                             @"CCBaseViewController",
        ];
    }
    return _controllerArray;
}

- (CCPersonHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[CCPersonHeaderView alloc] init];
        XYWeakSelf;
        _headerView.click = ^(NSInteger tag) {
            switch (tag) {
                case 0:{
                    MHQustReturnViewController *vc = [[MHQustReturnViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 2 :{
                    MHSecuritySetViewController *vc = [[MHSecuritySetViewController alloc] init];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
                    break;
                case 1 :{
                    SPAlertController *alert = [SPAlertController alertControllerWithTitle:@"拨打客服热线" message:@"1010-5568" preferredStyle:SPAlertControllerStyleAlert];

                    SPAlertAction *action1 = [SPAlertAction actionWithTitle:@"确定" style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
                        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"186xxxx6979"];

                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
                    }];
                    SPAlertAction *action3 = [SPAlertAction actionWithTitle:@"取消" style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {}];
                    [alert addAction:action3];
                    [alert addAction:action1];
                    [weakSelf presentViewController: alert animated:YES completion:^{}];
                }
                    break;
                default:
                    break;
            }
        };
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;
        adjustsScrollViewInsets_NO(self.tableView, self);
    }
    return _tableView;
}



- (void)refreshTableViewData {
    [self.tableView.mj_header beginRefreshing];
}

/// 添加下拉刷新
- (void)addTableViewRefresh {
    __weak typeof (self) weakSelf = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
        });
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
        });
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCPersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kClearColor;
    cell.iconImageVice.image = IMAGE_NAME(self.iconArray[indexPath.row]);
    cell.titleLab.text = self.titleArray[indexPath.row];
    cell.titleLabLeft.constant = -20;
    cell.lineView.hidden = NO;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    UILabel *nameLab = ({
        UILabel *view = [UILabel new];
        view.textColor =Color_2A2A2A;
        view.font = STFont(18);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.text = @"热门问题";
        view ;

    });
    [view addSubview:nameLab];
    [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(10);
        make.size.mas_equalTo(CGSizeMake(277, 14));
        make.centerY.mas_equalTo(view).mas_offset(0);
    }];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CCBaseViewController *vc = [NSClassFromString(self.controllerArray[indexPath.row]) new];
    [self.navigationController pushViewController:vc animated:YES];
}


















@end
