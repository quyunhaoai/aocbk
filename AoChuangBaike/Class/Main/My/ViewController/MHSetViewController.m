

//
//  MHSetViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHSetViewController.h"
#import "CCBaseViewController.h"
@interface MHSetViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MHSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBarWithBlackTitle:@"设置"];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT);
    }];
    self.titlesArray = @[@"账号/绑定设置",@"推送消息设置",@"隐私设置",@"给软件打分",@"清除缓存",@"关于我们"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Window_W, 130)];
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"退出登录" forState:UIControlStateNormal];
        [view.titleLabel setTextColor:kWhiteColor];
        [view.titleLabel setFont:STFont(17)];
        [view setBackgroundColor:kMainColor];
        [view setUserInteractionEnabled:YES];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 24;
         [view addTarget:self action:@selector(quitBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [footerView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(48);
        make.bottom.mas_equalTo(footerView.mas_bottom).mas_offset(-10);
    }];
    self.tableView.tableFooterView = footerView;
}
- (void)quitBtnClick:(UIButton *)button {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:userInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [kNotificationCenter postNotificationName:@"refreshMyInfo" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = Color_2A2A2A;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.titlesArray[indexPath.row]];
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
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
    CCBaseViewController *vc = [CCBaseViewController new];
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
