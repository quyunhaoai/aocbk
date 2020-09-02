//
//  MHNewsListViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/29.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHNewsListViewController.h"
#import "MHNewsListModel.h"
#import "LSDetainViewController.h"
@interface MHNewsListViewController ()

@end

@implementation MHNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBarWithBlackTitle:@"新闻"];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    self.page = 1;
    self.baseTableView = self.tableView;
    [self initData];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    [self addTableViewRefresh];
}
- (void)initData {
    NSString *path = [NSString stringWithFormat:@"news/list/0/0"];
    XYWeakSelf;
    NSDictionary *params = @{@"limit":@10,
                             @"page":@(self.page),
    };
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:path
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
                    MHNewsListModel *model = [MHNewsListModel mj_objectWithKeyValues:dict];
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
        }else if(status == 410000) {//未登录

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
- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    MHNewsListModel *model = self.dataSoureArray[indexPath.row];
    LSDetainViewController *vc = [LSDetainViewController new];
    vc.classId = STRING_FROM_INTAGER(model.mhid);// model.mhid;
    [self.navigationController pushViewController:vc animated:YES];
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
