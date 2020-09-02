

//
//  MHMYSalesClassTableViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHMYSalesClassTableViewController.h"
#import "MHMYSalesClass.h"
@interface MHMYSalesClassTableViewController ()

@end

@implementation MHMYSalesClassTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.page = 1;
    [self addTableViewRefresh];
    self.baseTableView = self.tableView;
    [self initData];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{@"page":@(self.page),
                             @"limit":@10,
                             @"type":self.type,
    };
    [[STHttpResquest sharedManager] requestWithMethod:[self.url isEqualToString:@"course/has_buy"]? GET:POST
                                             WithPath:_url
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
                    MHMYSalesClass *model = [MHMYSalesClass mj_objectWithKeyValues:dict];
                    if (![self.url isEqualToString:@"course/has_buy"]) {
                        model.isCollection = YES;
                    } else {
                        model.isCollection = NO;
                    }
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

- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    MHMYSalesClass *model = self.dataSoureArray[indexPath.row];
    switch (model.type) {//0视频录播 1视频直播 2语音3 文章
        case 0:
            {

            }
            break;
        case 1:
            {

            }
            break;
        case 2:
            {

            }
            break;
        default:
            break;
    }
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
