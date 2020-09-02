//
//  MHMyClassContenView.m
//  MentalHorizonProject
//
//  Created by    on 2020/4/30.
//  Copyright © 2020   . All rights reserved.
//

#import "MHMyClassContenView.h"
#import "NKAlertView.h"

#define NKColorWithRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation MHMyClassContenView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        
        // shop_invite_icon
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"chahua"];
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds = YES;
        [self addSubview:imgView];
        imgView.frame = CGRectMake(40,  20 + 10, CGRectGetWidth(frame) - 80, CGRectGetHeight(frame) - (50 + 10 + 60));
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.text = @"请在章节练习完成后解锁";
        titleLab.textColor = [UIColor grayColor];
        titleLab.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLab];
        titleLab.frame = CGRectMake(0, MaxY(imgView.frame), CGRectGetWidth(frame), 50);
        
        UIView *botVIew = [[UIView alloc] init];
        botVIew.backgroundColor = NKColorWithRGB(0xEFEFF4);
        [self addSubview:botVIew];
        botVIew.frame = CGRectMake(0, CGRectGetHeight(frame) - 50, CGRectGetWidth(frame), 50);
        
        UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.backgroundColor = [UIColor whiteColor];
        leftBtn.tag = 11;
        [leftBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [leftBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:leftBtn];
        leftBtn.frame = CGRectMake(0, 1, (CGRectGetWidth(frame) - 1) * 0.5, 49);
        
        UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.backgroundColor = [UIColor whiteColor];
        rightBtn.tag = 12;
        [rightBtn setTitle:@"前往章节练习" forState:UIControlStateNormal];
        [rightBtn setTitleColor:NKColorWithRGB(0xFED953) forState:UIControlStateNormal];
        rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rightBtn addTarget:self action:@selector(botBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [botVIew addSubview:rightBtn];
        rightBtn.frame = CGRectMake((CGRectGetWidth(frame) - 1) * 0.5 + 1, 1, (CGRectGetWidth(frame) - 1) * 0.5, 49);
    }
    return self;
}

- (void)botBtnClick:(UIButton *)btn
{
    NKAlertView *alertView = (NKAlertView *)self.superview;
    [alertView hide];
    if (btn.tag == 11) {
        
    }else
    {
        
    }
}
@end
