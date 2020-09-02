
//
//  BottomAlert3ContentView.m
//  CunCunTong
//
//  Created by    on 2020/4/3.
//  Copyright © 2020   . All rights reserved.
//

#import "BottomAlert3ContentView.h"
#import "NKAlertView.h"
#import "CCTextCustomYinhangKaTableViewCell.h"
#import "KKButton.h"
#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface BottomAlert3ContentView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation BottomAlert3ContentView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50.f;
        [self addSubview:_tableView];
    }
    return _tableView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = COLOR_333333;
        titleLab.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, 0, CGRectGetWidth(frame), 10);
        self.tableView.frame = CGRectMake(0, CGRectGetMaxY(titleLab.frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 66);
        [self.tableView registerNib:CCTextCustomYinhangKaTableViewCell.loadNib forCellReuseIdentifier:@"cell12345"];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        KKButton *rightBtn = [KKButton buttonWithType:UIButtonTypeCustom];
        rightBtn.tag = 12;
        [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
        [rightBtn setTitleColor:Color_2A2A2A forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:rightBtn];
        rightBtn.frame = CGRectMake(10, CGRectGetHeight(frame) - 56, CGRectGetWidth(frame)-10, 46);
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CCTextCustomYinhangKaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell12345"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titlelab.text = self.dataArray[indexPath.row];
    if ([self.selectStr isEqualToString:self.dataArray[indexPath.row]]) {
        cell.selectImageView.image =IMAGE_NAME(@"形状 2147");
    } else {
        cell.selectImageView.image =IMAGE_NAME(@"");
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.btnClick) {
        self.btnClick(self.dataArray[indexPath.row]);
    }
    [self botBtnClick:nil];
}
- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
}

@end
