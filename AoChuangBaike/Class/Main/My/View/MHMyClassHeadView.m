

//
//  MHMyClassHeadView.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHMyClassHeadView.h"

@implementation MHMyClassHeadView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.frame = CGRectMake(0, 0, Window_W, 120);
     NSLog(@"%@",NSStringFromCGRect(self.frame));
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    KKButton *forntBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [forntBtn setBackgroundColor:kWhiteColor];
    [forntBtn.titleLabel setFont:STFont(17)];
    [forntBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [forntBtn setTitle:@"我的试卷" forState:UIControlStateNormal];
    [forntBtn setImage:IMAGE_NAME(@"我的试卷") forState:UIControlStateNormal];
    [forntBtn setBackgroundImage:IMAGE_NAME(@"我的试卷背景") forState:UIControlStateNormal];
    forntBtn.layer.cornerRadius = 5;
    [forntBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    forntBtn.layer.masksToBounds = YES;
    [self addSubview:forntBtn];
    

    KKButton *backBtn = [KKButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundColor:kWhiteColor];
    [backBtn.titleLabel setFont:STFont(17)];
    [backBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    [backBtn setTitle:@"错题本" forState:UIControlStateNormal];
    [backBtn setImage:IMAGE_NAME(@"错题本") forState:UIControlStateNormal];
    [backBtn setBackgroundImage:IMAGE_NAME(@"错题本背景") forState:UIControlStateNormal];
    backBtn.layer.cornerRadius = 5;
    backBtn.layer.masksToBounds = YES;
    [backBtn addTarget:self action:@selector(timeSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    [forntBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo((Window_W-12-21-12)/2);
        make.height.mas_equalTo(80);
    }];

    [backBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(forntBtn.mas_right).mas_offset(21);
        make.top.mas_equalTo(15);
        make.width.mas_equalTo((Window_W-12-21-12)/2);
        make.height.mas_equalTo(80);
    }];
    [forntBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    [backBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeft imageTitleSpace:5];
    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(12.5,187.5,70.5,17);
    label.numberOfLines = 0;
    [self addSubview:label];

    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"我的课程" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName: [UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:1.0]}];

    label.attributedText = string;
    [label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.bottom.mas_equalTo(1);
        make.width.mas_equalTo((Window_W-12-21-12)/2);
        make.height.mas_equalTo(20);
    }];
}
- (void)timeSelect:(UIButton *)button {
    CCBaseViewController *vc = [CCBaseViewController new];
    [button.superview.viewController.navigationController pushViewController:vc animated:YES];
}
@end

