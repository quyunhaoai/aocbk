//
//  MHSecuritySetViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHSecuritySetViewController.h"
#import "CCPersonCenterTableViewCell.h"
#import "PushViewController.h"
#import "MHChangeMobleViewController.h"
@interface MHSecuritySetViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UILabel *titleLab;
@end

@implementation MHSecuritySetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_f8f8f8;
    self.tableView.backgroundColor = kClearColor;
    self.titlesArray = @[@[@"修改密码",@"更换手机号"],@[@"注销账号"]];
    [self customNavBarWithBlackTitle:@"安全设置"];
    self.navTitleView.splitView.backgroundColor = COLOR_e5e5e5;
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.titleLab.frame = CGRectMake(0, 0, Window_W, 80);
    self.tableView.tableHeaderView = self.titleLab;
    self.titleLab.text = @"157****1772";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:CCPersonCenterTableViewCell.loadNib forCellReuseIdentifier:@"UITableViewCell"];

}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor =  COLOR_333333;
            view.font = FONT_16;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.textAlignment = NSTextAlignmentCenter;
            view.backgroundColor = kWhiteColor;
            view;
        });
    }
    return _titleLab;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.titlesArray[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCPersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kWhiteColor;
    NSArray *arr = self.titlesArray[indexPath.section];
    cell.titleLab.text = arr[indexPath.row];
    cell.titleLabLeft.constant = -20;
    cell.lineView.hidden = NO;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view =[UIView new];
    view.backgroundColor = COLOR_f8f8f8;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 && indexPath.section == 0) {//修改密码
        PushViewController *vc = [[PushViewController alloc] initWithPushViewController:@"13822226666"];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row ==1){//修改手机
        MHChangeMobleViewController *vc = [MHChangeMobleViewController new];
        [self.navigationController pushViewController:vc animated:YES];
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
