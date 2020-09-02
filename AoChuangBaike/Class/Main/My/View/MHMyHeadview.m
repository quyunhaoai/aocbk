

//
//  MHMyHeadview.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHMyHeadview.h"
#import "ImageTitleButton.h"
#import "MHFillUserInfoViewController.h"
#import "CCBaseNavController.h"
@implementation MHMyHeadview


- (void)setupUI {
    UIImageView *imageBgView = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        view;
    });
    XYWeakSelf;
    [imageBgView addTapGestureWithBlock:^(UIView *gestureView) {
        NSString *token =  [kUserDefaults objectForKey:@"token"];
        if ([token isNotBlank]) {//已登录
            MHFillUserInfoViewController *VC=[MHFillUserInfoViewController new];
            [weakSelf.superview.viewController.navigationController pushViewController:VC animated:YES];
        } else {//未登录
            [kNotificationCenter postNotificationName:@"refreshMyInfo" object:nil];//refreshMyInfo
        }
    }];
    [self addSubview:imageBgView];
    [imageBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(210);
    }];
    CAGradientLayer *gradientLayer0 = [[CAGradientLayer alloc] init];
    gradientLayer0.frame = CGRectMake(0, 0, Window_W, 210);
    gradientLayer0.colors = @[
        (id)[UIColor colorWithRed:71.0f/255.0f green:167.0f/255.0f blue:248.0f/255.0f alpha:1.0f].CGColor,
        (id)[UIColor colorWithRed:5.0f/255.0f green:123.0f/255.0f blue:223.0f/255.0f alpha:1.0f].CGColor];
    gradientLayer0.locations = @[@0, @1];
    [gradientLayer0 setStartPoint:CGPointMake(1, 1)];
    [gradientLayer0 setEndPoint:CGPointMake(0, 0)];
    [imageBgView.layer insertSublayer:gradientLayer0 atIndex:0];
    
    UIImageView *areaIcon = ({
         UIImageView *view = [UIImageView new];
         view.contentMode = UIViewContentModeScaleAspectFill ;
         view.layer.masksToBounds = YES ;
         view.userInteractionEnabled = YES ;
         view.layer.cornerRadius = 30;
         [view setImage:IMAGE_NAME(@"人头像")];
         view;
     });
    self.headImage = areaIcon;
     [self addSubview:areaIcon];
     [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self).mas_offset(13);
         make.size.mas_equalTo(CGSizeMake(69, 69));
         make.top.mas_equalTo(self).mas_offset(NAVIGATION_BAR_HEIGHT +18);
     }];
    
     UILabel *nameLab = ({
         UILabel *view = [UILabel new];
         view.textColor =kWhiteColor;
         view.font = STFont(18);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view ;
     });
     [self addSubview:nameLab];
     [nameLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(areaIcon.mas_right).mas_offset(14);
         make.size.mas_equalTo(CGSizeMake(177, 17.5));
         make.top.mas_equalTo(areaIcon.mas_top).mas_offset(9);
     }];
     UILabel *addressLab = ({
         UILabel *view = [UILabel new];
         view.textColor =kWhiteColor;
         view.font = STFont(15);
         view.lineBreakMode = NSLineBreakByTruncatingTail;
         view.backgroundColor = [UIColor clearColor];
         view.textAlignment = NSTextAlignmentLeft;
         view.numberOfLines = 2;
         view.userInteractionEnabled = YES;
         view ;
     });
     [self addSubview:addressLab];
     [addressLab mas_updateConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(areaIcon.mas_right).mas_offset(14);
         make.size.mas_equalTo(CGSizeMake(247, 40.5));
         make.top.mas_equalTo(nameLab.mas_bottom).mas_offset(8);
     }];
    
    nameLab.text = @"你的名字";
    addressLab.text = @"点击编辑完整信息";
    self.nameLab = nameLab;
    self.qianmingLab = addressLab;
    [addressLab addTapGestureWithBlock:^(UIView *gestureView) {
        NSString *token =  [kUserDefaults objectForKey:@"token"];
        if ([token isNotBlank]) {//已登录
            MHFillUserInfoViewController *VC=[MHFillUserInfoViewController new];
            [weakSelf.superview.viewController.navigationController pushViewController:VC animated:YES];
        } else {//未登录
            [kNotificationCenter postNotificationName:@"refreshMyInfo" object:nil];//refreshMyInfo
        }
    }];
    UIImageView *areaIcon2 = ({
         UIImageView *view = [UIImageView new];
         view.contentMode = UIViewContentModeScaleAspectFill ;
         view.layer.masksToBounds = YES ;
         view.userInteractionEnabled = YES ;
         [view setImage:IMAGE_NAME(@"矩形 967")];
         view;
     });
     [self addSubview:areaIcon2];
     [areaIcon2 mas_updateConstraints:^(MASConstraintMaker *make) {
         make.right.mas_equalTo(self).mas_offset(-31.5);
         make.size.mas_equalTo(CGSizeMake(11, 19.5));
         make.top.mas_equalTo(self).mas_offset(74);
     }];
    self.buttosArray = [NSArray array];
    UIView *style = [[UIView alloc] initWithFrame:CGRectZero];//CGRectMake(10, 207, 355, 102)
    style.layer.cornerRadius = 10;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [self addSubview:style];
    [style mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.top.mas_equalTo(imageBgView.mas_bottom).mas_offset(-41);
        make.height.mas_equalTo(90);
    }];
    [[CCTools sharedInstance] addShadowToView:style withColor: [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:0.41]];
    
    
    NSArray *arr = @[@"我的网课",@"直播观看",@"我的课表"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 0)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTag:i];
        [button.titleLabel setFont:FONT_13];
        [button setTitleColor:Color_363636 forState:UIControlStateNormal];
//        退换货图标
        NSString *str = [NSString stringWithFormat:@"%@",arr[i]];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(str) forState:UIControlStateNormal];
        [style addSubview:button];
        [tolAry addObject:button];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0).mas_offset(0);
        make.height.equalTo(@54);
    }];
    self.buttosArray = [tolAry copy];
    
}
- (void)buttonClick:(UIButton *)button {
    if (self.buttonAction) {
        self.buttonAction(button.tag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
