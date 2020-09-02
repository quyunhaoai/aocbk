//
//  MHYueLabView.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/28.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHYueLabView.h"

@implementation MHYueLabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    self.userInteractionEnabled = YES;
//    self.backgroundColor = kRedColor;
    self.layer.borderColor = UIColorHex(0xDCDCDC).CGColor;
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 5;
    UILabel *label = [[UILabel alloc] init];

    label.textColor = Color_2A2A2A;
    label.numberOfLines = 0;
    [self addSubview:label];
    [label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 15));
        make.top.mas_equalTo(21);
    }];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"6 学习币" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 18],NSForegroundColorAttributeName: Color_2A2A2A}];

    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 18]} range:NSMakeRange(0, 2)];

    [string addAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 14]} range:NSMakeRange(2, 3)];

    label.attributedText = string;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.textColor = COLOR_999999;
    label2.numberOfLines = 0;
    [self addSubview:label2];
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 11));
        make.bottom.mas_equalTo(-20);
    }];
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"6元" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFang SC" size: 12],NSForegroundColorAttributeName:COLOR_999999}];

    label2.attributedText = string2;
    self.titleLab = label;
    self.subLab = label2;
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(12,329,110,75);

//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = self.frame;
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:126/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:0/255.0 green:180/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(1.0f)];
//
//    [self.layer addSublayer:gl];

}
@end
