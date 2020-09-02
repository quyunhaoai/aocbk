
//
//  MHChangePassView.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHChangePassView.h"

@implementation MHChangePassView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setupUI {
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 22.5;
    [[CCTools sharedInstance] addborderToView:view width:0.5 color:COLOR_e5e5e5];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(27.5));
        make.top.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-kWidth(27.5));
        make.height.mas_equalTo(45);
    }];
    [view addSubview:self.mobileTextView];
    [self.mobileTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(kWidth(62));
        make.centerY.mas_equalTo(view);
        make.right.mas_equalTo(self).mas_offset(-62);
        make.height.mas_equalTo(21);
    }];
    UIImageView *areaIcon = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"密码")];
         
        view;
    });
    [view addSubview:areaIcon];
    [areaIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view).mas_offset(29);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    UIImageView *areaIcon2 = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"查看")];
         
        view;
    });
    [view addSubview:areaIcon2];
    [areaIcon2 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view).mas_offset(-27);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(view.mas_centerY);
    }];
    XYWeakSelf;
    [areaIcon2 addTapGestureWithBlock:^(UIView *gestureView) {
        weakSelf.mobileTextView.text = @"";
    }];
    UIView *view2 = [[UIView alloc] init];
    view2.layer.cornerRadius = 22.5;
    [[CCTools sharedInstance] addborderToView:view2 width:0.5 color:COLOR_e5e5e5];
    [self addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(27.5));
        make.top.mas_equalTo(view.mas_bottom).mas_offset(13);
        make.right.mas_equalTo(self).mas_offset(-kWidth(27.5));
        make.height.mas_equalTo(45);
    }];
    [view2 addSubview:self.passWordTextView];
    [self.passWordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view2).mas_offset(kWidth(62));
        make.centerY.mas_equalTo(view2);
        make.right.mas_equalTo(self).mas_offset(-62);
        make.height.mas_equalTo(21);
    }];
    UIImageView *areaIcon3 = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"密码")];
         
        view;
    });
    [view2 addSubview:areaIcon3];
    [areaIcon3 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view2).mas_offset(29);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(view2.mas_centerY);
    }];
    self.viewTowImage = areaIcon3;
    UIImageView *areaIcon4 = ({
        UIImageView *view = [UIImageView new];
        view.contentMode = UIViewContentModeScaleAspectFill ;
        view.layer.masksToBounds = YES ;
        view.userInteractionEnabled = YES ;
        [view setImage:IMAGE_NAME(@"查看")];
         
        view;
    });
    self.lookImage = areaIcon4;
    [view2 addSubview:areaIcon4];
    [areaIcon4 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(view2).mas_offset(-27);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(view2.mas_centerY);
    }];
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(kWidth(27.5));
        make.top.mas_equalTo(view2.mas_bottom).mas_offset(48);
        make.right.mas_equalTo(self).mas_offset(-kWidth(27.5));
        make.height.mas_equalTo(45);
    }];
}

- (void)btnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
#pragma mark  -  get
                             
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:COLOR_HEX_RGB(0x007BFF)];
            [btn setTag:BUTTON_TAG(7)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"完成修改" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 22.5;
            btn ;
        });
    }
    return _loginButton;
}

- (UITextField *)mobileTextView {
    if (!_mobileTextView) {
        _mobileTextView =  ({
                   UITextField *textfield = [[UITextField alloc] init];
                   //设置边框
                   textfield.borderStyle = UITextBorderStyleNone;
                   //设置水印提示
                   textfield.placeholder = @"请输入密码";
                   textfield.placeholderColor= COLOR_999999;
                   //设置输入框右边的一键删除（x号）
                   textfield.clearButtonMode = 0;
                   //设置密码安全样式
                   textfield.secureTextEntry = NO;
                   //设置键盘样式
                   textfield.keyboardType = UIKeyboardTypeNumberPad ;
                   textfield.backgroundColor = kClearColor;
                   //设置输入的字体大小
                   textfield.font = [UIFont systemFontOfSize:15];

                   textfield;
               });
    }
    return _mobileTextView;
}

- (UITextField *)passWordTextView {
    if (!_passWordTextView) {
        _passWordTextView = ({
               UITextField *textfield = [[UITextField alloc] init];
               //设置边框
               textfield.borderStyle = UITextBorderStyleNone;
               //设置水印提示
               textfield.placeholder = @"请输再次入密码";
               textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
               //设置输入框右边的一键删除（x号）
//               textfield.clearButtonMode = UITextFieldViewModeAlways;
               //设置密码安全样式
               textfield.secureTextEntry = YES;
               //设置键盘样式
               textfield.keyboardType = 0;
                
               textfield.backgroundColor = kClearColor;
               //设置输入的字体大小
               textfield.font = [UIFont systemFontOfSize:15];

               textfield;
           });
    }
    return _passWordTextView;
}

@end
