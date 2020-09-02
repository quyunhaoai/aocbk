//
//  CCBalanceViewController.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBalanceViewController.h"
#import "CCBalance.h"
#import "BRDatePickerView.h"
#import "MHYueLabView.h"
@interface CCBalanceViewController ()
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *monryLab;
@property (weak, nonatomic) IBOutlet KKButton *goPayBtn;
@property (strong, nonatomic) MHYueLabView *PView;

@property (strong, nonatomic) CAGradientLayer *glGradientLayer;
@end

@implementation CCBalanceViewController

- (IBAction)payButton:(id)sender {//充值
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavBarWithTitle:@"账户余额"];
    [self.tableView removeFromSuperview];
    self.navTitleView.backgroundColor = kClearColor;
    [self setupUI];
    [self initData];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;;
}
- (void)setupUI {
    NSArray * arrayTitle = @[@"我的房屋",@"物业报修",@"我的收藏",@"我的消息",@"我的管家",@"设置"];
    int SPNum = 3;//水平一行放几个
    CGFloat JGGMinX = kWidth(12);//起始x值
    CGFloat JGGMinY = 329+10;//起始y值
    CGFloat SPspace = kWidth(15);//水平距离
    CGFloat CXspace = kHeight(11);//垂直距离
    CGFloat widthJGG = (Window_W- JGGMinX * 2 -SPspace * (SPNum-1)) / SPNum ;//九宫格宽
    CGFloat heightJGG = 75;//九宫格高
    NSMutableArray *totalArr = [NSMutableArray array];
    for ( int  i = 0; i < arrayTitle.count ; i++) {
        MHYueLabView *view = [[MHYueLabView alloc]init];
        view.tag = i;
        [self.view addSubview:view];

        [view mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.mas_equalTo(JGGMinX + i % SPNum * (widthJGG + SPspace));
            make.top.mas_equalTo(JGGMinY + i / SPNum * (heightJGG + CXspace));
            make.width.mas_equalTo(widthJGG);
            make.height.mas_equalTo(heightJGG);
            //不能再这里跟新约束，否则会警告,控件错位
        }];
        XYWeakSelf;
        [view addTapGestureWithBlock:^(UIView *gestureView) {
            [weakSelf LableViewTagAction:gestureView];
        }];
        [totalArr addObject:view];
    }
    KKButton *forntBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [forntBtn setBackgroundColor:kMainColor];
    [forntBtn.titleLabel setFont:STFont(17)];
    [forntBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [forntBtn setTitle:@"确认支付" forState:UIControlStateNormal];
    forntBtn.layer.cornerRadius = 25;
    [forntBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    forntBtn.layer.masksToBounds = YES;
    [self.view addSubview:forntBtn];
    [forntBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(12.5);
        make.top.mas_equalTo(339+160+20);
        make.width.mas_equalTo(Window_W-25);
        make.height.mas_equalTo(50);
    }];
    self.PView = totalArr[0];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0, 0, widthJGG, heightJGG);
    gl.cornerRadius = 5;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:126/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0f)];
    self.glGradientLayer = gl;
    self.PView.titleLab.textColor = kWhiteColor;
    self.PView.subLab.textColor = kWhiteColor;
    [self.PView.layer insertSublayer:gl atIndex:0];
}
- (void)LableViewTagAction:(UIView *)view {

    for (CAGradientLayer *layer in self.PView.layer.sublayers) {
        if ([layer.class isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    self.PView.titleLab.textColor = Color_2A2A2A;
    self.PView.subLab.textColor = COLOR_999999;

    [view.layer insertSublayer:self.glGradientLayer atIndex:0];
    MHYueLabView *vv = (MHYueLabView *)view;
    vv.titleLab.textColor = kWhiteColor;
    vv.subLab.textColor = kWhiteColor;
    self.PView = vv;
}
- (void)initData {
    NSString *str = [NSString stringWithFormat:@"¥%@学习币",self.price];
    //0-00
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSFontAttributeName value:STFont(26) range:NSMakeRange(0, 1)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(0, 1)];

    //0-00 text-style1
    [attributedString addAttribute:NSFontAttributeName value:STFont(38) range:NSMakeRange(1, self.price.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] range:NSMakeRange(1, self.price.length)];
    self.monryLab.attributedText = attributedString;
}
- (void)timeSelect:(UIButton *)button {

}
- (IBAction)goChongZhi:(UIButton *)sender {
    
}













@end
