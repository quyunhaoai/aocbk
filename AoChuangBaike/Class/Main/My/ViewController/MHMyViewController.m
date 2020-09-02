

//
//  MHMyViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *CellIdentifier = @"UITableViewCell";
#import "MHMyViewController.h"
#import "MHMyHeadview.h"
#import "CCYouHuiQuanViewController.h"
#import "CCPersonCenterTableViewCell.h"
#import "MHFillUserInfoViewController.h"

#import "MHMyUserInfoModel.h"
#import "MHSetViewController.h"
#import "MHHelpViewController.h"
#import "CCBalanceViewController.h"
#import "MHZhuanJIaViewController.h"
#import "MHSalesClassViewController.h"

#import "CCBaseViewController.h"
#import "MHClassTableViewController.h"
@interface MHMyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) MHMyHeadview                          *headView;
@property (strong, nonatomic) NSArray                               *titleArray;
@property (strong, nonatomic) NSArray                               *group_titleArray;
@property (strong, nonatomic) NSArray                               *iconArray;
@property (strong, nonatomic) NSArray                               *controllerArray;
@property (strong, nonatomic) MHMyUserInfoModel                     *userInfo;
@end

@implementation MHMyViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSString *token =  [kUserDefaults objectForKey:@"token"];
    if ([token isNotBlank]) {//已登录

    } else {//未登录
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.backgroundColor = kWhiteColor;
    self.headView.frame = CGRectMake(0, 0, Window_W, 187+95);
    self.tableView.tableHeaderView = self.headView;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:CCPersonCenterTableViewCell.loadNib
         forCellReuseIdentifier:CellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    XYWeakSelf;
    self.headView.buttonAction = ^(NSInteger i) {
        if (i == 12) {
            MHSalesClassViewController *vc = [MHSalesClassViewController new];
            vc.titleStr = @"我的收藏";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else if (i == 13){
            MHSalesClassViewController *vc = [MHSalesClassViewController new];
            vc.titleStr = @"已购课程";
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else if (i == 20){
            CCBalanceViewController *vc = [CCBalanceViewController new];
            vc.price = weakSelf.userInfo.now_money;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else if (i == 0){
            MHClassTableViewController *vc = [MHClassTableViewController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        } else {
            CCBaseViewController *vc = [[CCBaseViewController alloc] init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    };
//    [self initData];
    [kNotificationCenter addObserver:self selector:@selector(initData) name:@"refreshMyInfo" object:nil];
}

- (void)initData {
    XYWeakSelf;
    NSDictionary *params = @{};
    [[STHttpResquest sharedManager] requestWithMethod:GET
                                             WithPath:@"userinfo"
                                           WithParams:params
                                     WithSuccessBlock:^(NSDictionary * _Nonnull dic) {
        NSInteger status = [[dic objectForKey:@"status"] integerValue];
        NSString *msg = [[dic objectForKey:@"msg"] description];
        if(status == 200){
            NSDictionary *data = dic[@"data"];
            NSData * data2  = [NSKeyedArchiver archivedDataWithRootObject:data];
            [kUserDefaults setObject:data2 forKey:@"userInfo"];
            [kUserDefaults synchronize];
            weakSelf.userInfo = [MHMyUserInfoModel mj_objectWithKeyValues:data];
            [weakSelf.headView.headImage sd_setImageWithURL:[NSURL URLWithString:weakSelf.userInfo.avatar]];
            weakSelf.headView.nameLab.text = weakSelf.userInfo.nickname;
            weakSelf.headView.qianmingLab.text = weakSelf.userInfo.person_sign;
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
    return self.group_titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return self.titleArray.count;
    } else {
        return 0;
    }
 
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CCPersonCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = kWhiteColor;
    cell.iconImageVice.image = IMAGE_NAME(self.titleArray[indexPath.row]);
    cell.titleLab.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 42.0001f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    UILabel *pricelab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = FONT_16;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentLeft;
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 1;
        view ;
    });
    [view addSubview:pricelab];
    [pricelab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(view).mas_offset(0);
        make.left.mas_equalTo(view).mas_offset(15);
        make.width.mas_equalTo(Window_W/2);
        make.height.mas_equalTo(17);
    }];
    pricelab.text = self.group_titleArray[section];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CCBaseViewController *vc = [NSClassFromString(self.controllerArray[indexPath.row]) new];
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark Get
- (MHMyHeadview *)headView {
    if (!_headView) {
        _headView = [[MHMyHeadview alloc] init];
    }
    return _headView;
}

- (NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"余额图标",
                       @"销售录入图标",
                       @"退出图标",
        ];
    }
    return _iconArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"个人信息",
                        @"投诉建议",
                        @"在线客服",
        ];
    }
    return _titleArray;
}
- (NSArray *)group_titleArray {
    if (!_group_titleArray) {
        _group_titleArray = @[@"学习中心",@"订单管理 ",@"个人资料",@"帮助中心"];
    }
    return _group_titleArray;
}
- (NSArray *)controllerArray {
    if (!_controllerArray) {
        _controllerArray = @[
//            @"MHZhuanJIaViewController",
//                             @"MHHelpViewController",
//                             @"MHSetViewController",
        ];
    }
    return _controllerArray;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)dealloc {
    [kNotificationCenter removeObserver:self name:@"refreshMyInfo" object:nil];
}

@end
