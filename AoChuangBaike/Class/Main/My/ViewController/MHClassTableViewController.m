

//
//  MHClassTableViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHClassTableViewController.h"
#import "CCMessageModel.h"
#import "MHMyClassListViewController.h"
@interface MHClassTableViewController ()
@property (nonatomic,strong) UIImageView *headIconImageView;
@end

@implementation MHClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self setupUI];
    [self initData];
    [self customNavBarWithTitle:@"我的学习"];
    self.navTitleView.backgroundColor = kClearColor;
    [self addTableViewRefresh];
    self.baseTableView = self.tableView;
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"page":@(self.page),
                             @"limit":@10,
    };
    [[STHttpResquest sharedManager] requestWithMethod:POST
                                             WithPath:@"course/need_study"
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        weakSelf.showErrorView = NO;
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSArray *data = dic[@"data"];
            if (weakSelf.page >1) {
                    
            } else {
                [weakSelf.dataSoureArray removeAllObjects];
                weakSelf.baseTableDataArray = data.mutableCopy;
            }
            
            if (data.count) {
                for (NSDictionary *dict  in data) {
                    CCMessageModel *model = [CCMessageModel mj_objectWithKeyValues:dict];
                    [weakSelf.dataSoureArray addObject:model];
                }
            }

            [weakSelf.tableView.mj_footer endRefreshing];
              if (data.count<10) {
                  [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
              } else {
                  [weakSelf.tableView.mj_footer resetNoMoreData];
              }
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.page ++;
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
            [weakSelf.tableView.mj_header endRefreshing];
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
        weakSelf.showErrorView = YES;
    }];
}

- (void)upRefreshData {
    [self initData];
}

- (void)setupUI {
    [self.view addSubview:self.headIconImageView];
    [self.headIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(225);
    }];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NAVIGATION_BAR_HEIGHT);
    }];
    [self.view sendSubviewToBack:self.headIconImageView];
    self.tableView.backgroundColor = kClearColor;
}

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    MHMyClassListViewController *vc = [MHMyClassListViewController new];
    CCMessageModel *model = self.dataSoureArray[indexPath.row];
    vc.classID = STRING_FROM_INTAGER(model.mhid);
    [self.navigationController pushViewController:vc
                                         animated:YES];
}
- (void)clickBaseButtonWithType:(KKBarButtonType)type item:(BaseModel *)item {
    
    MHMyClassListViewController *vc = [MHMyClassListViewController new];
    CCMessageModel *model = (CCMessageModel *)item;
    vc.classID = STRING_FROM_INTAGER(model.mhid);
    [self.navigationController pushViewController:vc
                                         animated:YES];
}
- (UIImageView *)headIconImageView {
    if (!_headIconImageView) {
        _headIconImageView =({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = IMAGE_NAME(@"我的课程背景");
            view.layer.masksToBounds = YES ;
            view ;
        });
    }
    return _headIconImageView;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;;
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
