//
//  MHMyClassListViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHMyClassListViewController.h"
#import "MHMyClassHeadView.h"
#import "MHMyClassTableViewCell.h"
#import "MHMyClass2TableViewCell.h"

#import "MHMyClassModel.h"

#import "NKAlertView.h"
#import "MHMyClassContenView.h"
@interface MHMyClassListViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MHMyClassListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self customNavBarWithBlackTitle:@"教你入门心理学"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(0+NAVIGATION_BAR_HEIGHT);
    }];
//    MHMyClassHeadView *head = [MHMyClassHeadView viewFromXib];
    MHMyClassHeadView *head = [MHMyClassHeadView new];
    head.frame = CGRectMake(0, 0, Window_W, 145);
    self.tableView.tableHeaderView = head;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:MHMyClassTableViewCell.loadNib
         forCellReuseIdentifier:@"MHMyClassTableViewCell"];
    [self.tableView registerNib:MHMyClass2TableViewCell.loadNib
         forCellReuseIdentifier:@"MHMyClass2TableViewCell"];
    [self initData];
}
- (void)initData {
//    NSString *str = [NSString stringWithFormat:@"course/has_class/%@",self.classID];
        NSString *str = [NSString stringWithFormat:@"course/has_class/%@",@"20"];
    XYWeakSelf;
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:str
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSArray *data = dic[@"data"];
            weakSelf.dataSoureArray = data.mutableCopy;
            [weakSelf.tableView reloadData];
 
        }else{
            if (msg.length>0) {
                [MBManager showBriefAlert:msg];
            }
        }
    } WithFailurBlock:^(NSError * _Nonnull error) {
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
    MHMyClassModel *model = [MHMyClassModel mj_objectWithKeyValues:self.dataSoureArray[indexPath.row]];
    if (model.study == 0) {
        MHMyClass2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHMyClass2TableViewCell"];
        cell.Model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        MHMyClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MHMyClassTableViewCell"];
        XYWeakSelf;
        cell.zhangJieTip = ^(NSString * _Nonnull title) {
            [weakSelf showAlertView:title];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Model = model;
        return cell;
    }
    return nil;
}
- (void)showAlertView:(NSString *)title {
    NKAlertView *alert = [[NKAlertView alloc] init];
    MHMyClassContenView *textView = [[MHMyClassContenView alloc] initWithFrame:CGRectMake(0, 0, 302, 302)];
    alert.contentView = textView;
    alert.hiddenWhenTapBG = YES;
    alert.type = NKAlertViewTypeDef;
    [alert show];
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHMyClassModel *model = [MHMyClassModel mj_objectWithKeyValues:self.dataSoureArray[indexPath.row]];
    if (model.study == 0)  return 66;
    return 96;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
