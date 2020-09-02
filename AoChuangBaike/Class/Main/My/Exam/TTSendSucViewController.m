//
//  TTSendSucViewController.m
//  TTAnswer
//
//  Created by GOOUC on 2020/3/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//
static NSString *CellIdentifier123 = @"CellIdentifier123";
#import "TTSendSucViewController.h"
#import "CCTabbarViewController.h"
//#import "TTTextTableViewCell.h"
#import "MyExamViewController.h"
@interface TTSendSucViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *reslutArray;

@end

@implementation TTSendSucViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    [self customNavBarWithTitle:@"答题"];
    self.reslutArray = [NSMutableArray array];
    self.dataSoureArray = [NSMutableArray arrayWithArray:@[@"试卷满分:",@"平均得分:",@"试卷得分:",@"成绩排名:",@"金币奖励:",@"答题用时:",@"成绩评估"]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@分",checkNull(self.reslutDic[@"scores"])]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@分",checkNull(self.reslutDic[@"avgscore"])]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@分",checkNull(self.reslutDic[@"score"])]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@",checkNull(self.reslutDic[@"ranking"])]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@个",checkNull(self.reslutDic[@"coin"])]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@秒",checkNull(self.reslutDic[@"time"])]];
    [_reslutArray addObject:[NSString stringWithFormat:@"%@",checkNull(self.reslutDic[@"pass_franction"])]];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.backgroundColor = UIColorHex(0xf5f5f5);
//    [self.tableView registerNib:TTTextTableViewCell.loadNib forCellReuseIdentifier:CellIdentifier123];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupUI];

}

- (void)setupUI {
    UIImageView *imageV = ({
        UIImageView *view = [UIImageView new];
        view.userInteractionEnabled = YES;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view.clipsToBounds = YES;
        view.image = IMAGE_NAME(@"result-pic");
        view;
    });
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT +25);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    UILabel *titleLab = ({
        UILabel *view = [UILabel new];
        view.textColor = COLOR_333333;
        view.font = STFont(22);
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.backgroundColor = [UIColor clearColor];
        view.textAlignment = NSTextAlignmentCenter;
        view.text = @"提交成功!";
        view;
    });
    [self.view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT +75);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(30);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT +60+20+20+30);
        make.right.mas_equalTo(self.view).mas_offset(-30);
        make.bottom.mas_equalTo(self.view).mas_offset(-(Window_H-NAVIGATION_BAR_HEIGHT-60-20-238-20-30));
    }];

    UIButton *but = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setUserInteractionEnabled:YES];
        [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_16];
        [view setTitle:@"返回首页" forState:UIControlStateNormal];
        [view setTag:3];
        [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self.view addSubview:but];
    [but mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(Window_W/2+20);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT +50+20+20 +238+30+30);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(42);
    }];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 21;
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];
    _gradientLayer.colors = @[(__bridge id)UIColorHex(0xffc622).CGColor, (__bridge id)UIColorHex(0xfaa539).CGColor];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(1.0, 0);
    _gradientLayer.frame = CGRectMake(0, 0, 130, 42);
    [but.layer insertSublayer:_gradientLayer below:but.titleLabel.layer];;
    UIButton *btn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setUserInteractionEnabled:YES];
        [view setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [view.titleLabel setFont:FONT_16];
        [view setTitle:@"查看解析" forState:UIControlStateNormal];
        [view setTag:4];
        [view addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self.view addSubview:btn];
    [btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-Window_W/2);
        make.top.mas_equalTo(self.view).mas_offset(NAVIGATION_BAR_HEIGHT +50+20+20 +238+30+30);
        make.width.mas_equalTo(130);
        make.height.mas_equalTo(42);
    }];
    
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 21;
    CAGradientLayer *_gradientLayer2 = [CAGradientLayer layer];
    _gradientLayer2.colors = @[(__bridge id)UIColorHex(0x44bcfe).CGColor, (__bridge id)UIColorHex(0x5999ff).CGColor];
    _gradientLayer2.startPoint = CGPointMake(0, 0);
    _gradientLayer2.endPoint = CGPointMake(1.0, 0);
    _gradientLayer2.frame = CGRectMake(0, 0, 130, 42);
    [btn.layer insertSublayer:_gradientLayer2 below:btn.titleLabel.layer];;
}

- (void)addBtnClick:(UIButton *)button {
    if (button.tag == 3) {//返回首页
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        MyExamViewController *vc = [MyExamViewController new];
        vc.isJiexi = YES;
        vc.PID = self.PID;
        vc.model = self.questListModle;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoureArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",[self class],indexPath.row];
    
    return cell;
//    TTTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier123];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = kClearColor;
//    if (indexPath.row < self.reslutArray.count ) {
//        cell.leftLab.text = self.dataSoureArray[indexPath.row];
//        cell.rightLab.text = self.reslutArray[indexPath.row];
//    }
//    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 34.f;
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

@end
