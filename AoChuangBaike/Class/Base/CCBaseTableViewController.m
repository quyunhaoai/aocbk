//
//  CCBaseTableViewController.m
//  CunCunTong
//
//  Created by    on 2020/3/13.
//  Copyright © 2020   . All rights reserved.
//

#import "CCBaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "CCBalanceTableViewCell.h"
#import "CCMyOrderModelTableViewCell.h"
#import "CCDaySalesTableViewCell.h"
#import "CCWarningReminderModelTableViewCell.h"
#import "CCSureOrderTableViewCell.h"
#import "CCOrderDetailTableViewCell.h"
#import "CCModifyArddressTableViewCell.h"
#import "CCMessageModelTableViewCell.h"
#import "CCGoodsSelectModelTableViewCell.h"
#import "CCYouHuiQuanTableViewCell.h"
#import "CCMyGoodsListTableViewCell.h"
#import "CCEverDayTeTableViewCell.h"
#import "MHMYSalesClassTableViewCell.h"
#import "MHNewsListModelTableViewCell.h"
#import "MHZhangJieLXTableViewCell.h"
@interface CCBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,KKCommonDelegate>
@property (nonatomic,readonly) UITableViewStyle style;
@end

@implementation CCBaseTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super self];
    if (self) {
        _style = style;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
//    self.tableView.backgroundColor = COLOR_f5f5f5;
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    [self.tableView registerNib:CCBalanceTableViewCell.loadNib
         forCellReuseIdentifier:@"CCBalance"];
    [self.tableView registerNib:CCMyOrderModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCMyOrderModel"];
    [self.tableView registerNib:CCDaySalesTableViewCell.loadNib
         forCellReuseIdentifier:@"CCDaySales"];
    [self.tableView registerNib:CCWarningReminderModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCWarningReminderModel"];
    [self.tableView registerNib:CCSureOrderTableViewCell.loadNib
         forCellReuseIdentifier:@"CCSureOrder"];
    [self.tableView registerNib:CCOrderDetailTableViewCell.loadNib
         forCellReuseIdentifier:@"CCOrderDetail"];
    [self.tableView registerNib:CCModifyArddressTableViewCell.loadNib
         forCellReuseIdentifier:@"CCModifyArddress"];
    [self.tableView registerNib:CCMessageModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCMessageModel"];
    [self.tableView registerNib:CCGoodsSelectModelTableViewCell.loadNib
         forCellReuseIdentifier:@"CCGoodsSelectModel"];
    [self.tableView registerNib:CCYouHuiQuanTableViewCell.loadNib
         forCellReuseIdentifier:@"CCYouHuiQuan"];
    [self.tableView registerNib:CCMyGoodsListTableViewCell.loadNib
         forCellReuseIdentifier:@"CCMyGoodsList"];
    [self.tableView registerNib:CCEverDayTeTableViewCell.loadNib
         forCellReuseIdentifier:@"CCEverDayTe"];
    [self.tableView registerNib:MHMYSalesClassTableViewCell.loadNib
         forCellReuseIdentifier:@"MHMYSalesClass"];
    [self.tableView registerNib:MHNewsListModelTableViewCell.loadNib
         forCellReuseIdentifier:@"MHNewsListModel"];
    [self.tableView registerNib:MHZhangJieLXTableViewCell.loadNib
         forCellReuseIdentifier:@"MHZhangJieLX"];
//    [self addTableViewRefresh];
//    self.dataSoureArray = [NSMutableArray array];
    self.baseTableView = self.tableView;
}
#pragma mark  - Get

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.style];
        _tableView.accessibilityIdentifier = @"table_view";
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
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
        weakSelf.page = 1;
        [weakSelf initData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf upRefreshData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     UITableViewCell *cell = [BaseTableViewCell cellWithTableView:tableView model:self.dataSoureArray[indexPath.row] indexPath:indexPath];
    [(BaseTableViewCell *)cell setDelegate:self];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *modelName = NSStringFromClass([self.dataSoureArray[indexPath.row] class]);
    Class CellClass = NSClassFromString([modelName stringByAppendingString:@"TableViewCell"]);
    return [CellClass height];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self tableViewDidSelect:indexPath];
}

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    
}
- (void)clickButtonWithType:(KKBarButtonType)type item:(id)item {
    [self clickBaseButtonWithType:type item:item];
}
- (void)clickBaseButtonWithType:(KKBarButtonType)type item:(BaseModel *)item {
    
}
- (NSMutableArray *)dataSoureArray {
    if (!_dataSoureArray) {
        _dataSoureArray = [[NSMutableArray alloc] init];
    }
    return _dataSoureArray;
}
- (NSArray *)titlesArray {
    if (!_titlesArray) {
        _titlesArray = [[NSArray alloc] init];
    }
    return _titlesArray;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setBaseTableDataArray:(NSMutableArray *)baseTableDataArray{
    _baseTableDataArray = baseTableDataArray;
    if (!self.baseTableDataArray.count) {
        [self.tableView addSubview:self.noDataView];
        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top).mas_offset(0);
            make.left.right.bottom.mas_equalTo(self.view);
            make.centerX.mas_equalTo(self.view);
        }];
    } else {
        [self.noDataView removeFromSuperview];
    }
}





@end
