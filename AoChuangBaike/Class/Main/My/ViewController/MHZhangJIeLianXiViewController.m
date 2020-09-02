//
//  MHZhangJIeLianXiViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHZhangJIeLianXiViewController.h"
#import "MHZhangJieLX.h"
#import "MHAnswerViewController.h"
@interface MHZhangJIeLianXiViewController ()
@end

@implementation MHZhangJIeLianXiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBarWithTitle:self.titleStr];
    self.view.backgroundColor = COLOR_f8f8f8;
    self.baseTableView = self.tableView;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    [self initData];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)initData{
    NSString *url = [NSString stringWithFormat:@"course/item_list/%@/%@/%@",self.classID,self.zhangjieID,self.type];
//    NSString *url = @"/course/item_list/20/1/1";
    XYWeakSelf;
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:url
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSArray *data = dic[@"data"];
            for (NSDictionary *dict in data) {
                MHZhangJieLX *model = [MHZhangJieLX mj_objectWithKeyValues:dict];
                [weakSelf.dataSoureArray addObject:model];
            }
            [weakSelf.tableView reloadData];
 
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
}
- (void)tableViewDidSelect:(NSIndexPath *)indexPath {
    MHAnswerViewController *vc = [MHAnswerViewController new];
    MHZhangJieLX *model = self.dataSoureArray[indexPath.row];
    vc.AnswerId = STRING_FROM_INTAGER(model.mhid);
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickBaseButtonWithType:(KKBarButtonType)type item:(BaseModel *)item {
    MHZhangJieLX *model = (MHZhangJieLX *)item;
    NSString *url = [NSString stringWithFormat:@"course/start_test/%ld",(long)model.mhid];
    XYWeakSelf;
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:url
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *data = dic[@"data"];
            MHAnswerViewController *vc = [MHAnswerViewController new];
            vc.AnswerId = STRING_FROM_INTAGER([data[@"id"] intValue]);
            vc.titleStr = model.item_name;
            [weakSelf.navigationController pushViewController:vc animated:YES];
 
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
    }];
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
