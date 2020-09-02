//
//  MHFillTextContentView.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/17.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHFillTextContentView.h"

@implementation MHFillTextContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {

    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 10;
    self.clipsToBounds = YES;
    
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"编辑个性签名";
    titleLab.textColor = Color_2A2A2A;
    titleLab.font = [UIFont systemFontOfSize:16];
    [self addSubview:titleLab];
    titleLab.frame = CGRectMake(0, 14, CGRectGetWidth(self.frame), 20);
    self.titleLab = titleLab;
    // shop_invite_icon
    UITextView *imgView = [[UITextView alloc] init];
    imgView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];;
    [self addSubview:imgView];
    imgView.frame = CGRectMake(20,  CGRectGetMaxY(titleLab.frame) + 10, CGRectGetWidth(self.frame) - 40, CGRectGetHeight(self.frame) - (CGRectGetMaxY(titleLab.frame) + 10 + 60));
    self.myTextView = imgView;
    UIView *botVIew = [[UIView alloc] init];
    botVIew.backgroundColor = kWhiteColor;
    [self addSubview:botVIew];
    botVIew.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 50, CGRectGetWidth(self.frame), 50);
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];;
    leftBtn.tag = 11;
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [botVIew addSubview:leftBtn];
    leftBtn.frame = CGRectMake(25, 1, (CGRectGetWidth(self.frame) - 1) * 0.5-25-10, 40);
    leftBtn.layer.masksToBounds = YES;
    leftBtn.layer.cornerRadius = 20;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.backgroundColor = kTipBlueColor;
    rightBtn.tag = 12;
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [botVIew addSubview:rightBtn];
    rightBtn.frame = CGRectMake((CGRectGetWidth(self.frame) - 1) * 0.5 + 10, 1, (CGRectGetWidth(self.frame) - 10) * 0.5-25, 40);
    rightBtn.layer.masksToBounds = YES;
    rightBtn.layer.cornerRadius = 20;

}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (btn.tag == 11) {
        
    }else
    {
        if (self.callBack) {
            self.callBack(self.myTextView.text);
        }
    }
}



@end
