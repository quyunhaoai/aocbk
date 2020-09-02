

//
//  MHSalesClassViewController.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHSalesClassViewController.h"
#import "MLMSegmentManager.h"
#import "MLMSegmentHead.h"
#import "MLMSegmentScroll.h"
#import "MHMYSalesClassTableViewController.h"
@interface MHSalesClassViewController ()<MLMSegmentHeadDelegate,MLMSegmentScrollDelegate>
@property (strong, nonatomic) MLMSegmentHead         *segHead;
@property (strong, nonatomic) MLMSegmentScroll       *segScroll;
@end

@implementation MHSalesClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavBarWithBlackTitle:self.titleStr];
    
    [self setupUI];
}
- (void)setupUI {
    _segHead = [[MLMSegmentHead alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 44) titles:@[@"全部",@"课程",@"个案",@"解析"] headStyle:SegmentHeadStyleLine layoutStyle:MLMSegmentLayoutCenter];
    _segHead.deSelectColor = COLOR_666666;
    _segHead.selectColor = Color_2A2A2A;
    _segHead.fontScale = 1.08;
    _segHead.fontSize = 15;
    _segHead.lineScale = .4;
    _segHead.lineColor = kTipBlueColor;
    _segHead.equalSize = NO;
    _segHead.bottomLineHeight = 0;
    _segHead.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    MHMYSalesClassTableViewController *tableView1 = [[MHMYSalesClassTableViewController alloc] init];
    if ([_titleStr isEqualToString:@"已购课程"]) {
        tableView1.type = @"";
        tableView1.url = @"course/has_buy";
    } else {
        tableView1.url = @"collection/list";
        tableView1.type = @"";
    }
    MHMYSalesClassTableViewController *tableView2 = [[MHMYSalesClassTableViewController alloc] init];
    if ([_titleStr isEqualToString:@"已购课程"]) {
        tableView2.type = @"course";
        tableView2.url = @"course/has_buy";
    } else {
        tableView2.type = @"course";
        tableView2.url = @"collection/list";
    }
    MHMYSalesClassTableViewController *tableView3 = [[MHMYSalesClassTableViewController alloc] init];
    if ([_titleStr isEqualToString:@"已购课程"]) {
        tableView3.type = @"bussiness";
        tableView3.url = @"course/has_buy";
    } else {
        tableView3.type = @"bussiness";
        tableView3.url = @"collection/list";
    }
    MHMYSalesClassTableViewController *tableView4 = [[MHMYSalesClassTableViewController alloc] init];
    if ([_titleStr isEqualToString:@"已购课程"]) {
        tableView4.type = @"bussiness";
        tableView4.url = @"course/has_buy";
    } else {
        tableView4.type = @"bussiness";
        tableView4.url = @"collection/list";
    }

    _segScroll = [[MLMSegmentScroll alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT+44, SCREEN_WIDTH, SCREEN_HEIGHT-(NAVIGATION_BAR_HEIGHT+44)) vcOrViews:@[tableView1,tableView2,tableView3,tableView4]];
    _segScroll.loadAll = NO;
    _segScroll.showIndex = 0;
    _segScroll.initSource = ^(id vcOrview, NSInteger index) {
        
    };
//    _segScroll.segDelegate = self;
    [MLMSegmentManager associateHead:_segHead withScroll:_segScroll completion:^{
        [self.view addSubview:self.segHead];
        [self.view addSubview:self.segScroll];
    }];
}
#pragma mark  -  segDelegate
- (void)didSelectedIndex:(NSInteger)index {
    self.segScroll.showIndex = index;
}
///滑动结束
- (void)scrollEndIndex:(NSInteger)index{
    self.segHead.showIndex = index;
}
///动画结束
- (void)animationEndIndex:(NSInteger)index{
    
}
///偏移的百分比
- (void)scrollOffsetScale:(CGFloat)scale{
    
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
