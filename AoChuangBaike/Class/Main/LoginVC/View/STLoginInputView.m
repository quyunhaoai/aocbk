//
//  STLoginInputView.m
//  StudyOC
//
//  Created by   on 2019/10/9.
//  Copyright © 2019  . All rights reserved.
//

#import "STLoginInputView.h"
@interface STLoginInputView ()

@property (strong, nonatomic) UILabel *niceLabel; //  标签
@property (strong, nonatomic) UILabel *mobileLabel; //  标签
@property (strong, nonatomic) UILabel *passWordLabel; //  标签

@property (nonatomic,strong) KKButton *justButton; //  按钮
@property (nonatomic,strong) UIButton *loginButton; //  按钮
@end


@implementation STLoginInputView


- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.titleLabelView2];
    [self addSubview:self.titleLabelView];
    [self addSubview:self.mobileTextView];
    [self addSubview:self.passWordTextView];
    [self addSubview:self.justButton];
    [self addSubview:self.loginButton];
    [self.titleLabelView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(kHeight(42));
        make.left.mas_equalTo(self).mas_offset(77);
        make.size.mas_equalTo(CGSizeMake(kWidth(260), 40));
    }];
    [self.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabelView2.mas_bottom).mas_offset(kHeight(47));
        make.left.mas_equalTo(self).mas_offset(27);
        make.size.mas_equalTo(CGSizeMake(kWidth(200), 40));
    }];

    [self.mobileTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabelView).mas_offset(kWidth(0));
        make.top.mas_equalTo(self.titleLabelView.mas_bottom).mas_offset(60);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];

    [self.passWordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabelView).mas_offset(kWidth(0));
        make.top.mas_equalTo(self.mobileTextView.mas_bottom).mas_offset(40);
        make.right.mas_equalTo(self).mas_offset(-40);
        make.height.mas_equalTo(21);
    }];


    UIView *line2 = [[UIView alloc] init];
    line2.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mobileTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    UIView *line3 = [[UIView alloc] init];
    line3.backgroundColor = COLOR_d2d1d1;
    [self addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passWordTextView.mas_bottom).mas_offset(kHeight(11));
        make.width.mas_equalTo(Window_W-40);
        make.left.mas_equalTo(self).mas_offset(20);
        make.height.mas_equalTo(1);
    }];
    [self.justButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(kHeight(19));
        make.right.mas_equalTo(self).mas_offset(-25);
        make.size.mas_equalTo(CGSizeMake(Window_W/2, 21));
    }];
    [self.justButton layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleLeftRight imageTitleSpace:0];
    [self addSubview:self.justButton2];
    [self.justButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line3.mas_bottom).mas_offset(kHeight(19));
        make.left.mas_equalTo(self).mas_offset(25);
        make.size.mas_equalTo(CGSizeMake(Window_W/2, 21));
    }];
    [self.justButton2 layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRightLeft imageTitleSpace:0];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.justButton.mas_bottom).mas_offset(kHeight(60));
        make.left.mas_equalTo(self).mas_offset(25);
        make.width.mas_equalTo(Window_W-50);
        make.height.mas_equalTo(kHeight(45));
    }];
    
    [self addSubview:self.headIconImageView];
    [self.headIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).mas_offset(kHeight(37));
        make.width.mas_equalTo(kWidth(82));
        make.height.mas_equalTo(_headIconImageView.mas_width);
    }];
    [self addSubview:self.regestLabel];
    [self.regestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.loginButton.mas_bottom).mas_offset(kHeight(14));
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(21);
    }];
    self.regestLabel.textAlignment = kCTTextAlignmentCenter;
}

#pragma mark  -  get
- (TYAttributedLabel *)regestLabel {
    if (!_regestLabel) {
        _regestLabel = ({
            TYAttributedLabel *label = [[TYAttributedLabel alloc]initWithFrame:CGRectZero];
            label.textAlignment = NSTextAlignmentCenter;
            NSString *text = @"还没有账号？账号注册";
            label.font = FONT_13;
            [label setText:text];
            [label sizeToFit];
            label;
        });
    }
    return _regestLabel;
}
- (UIImageView *)headIconImageView {
    if (!_headIconImageView) {
        _headIconImageView =({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"headPortraitImageView"];
            view.layer.masksToBounds = YES ;
            view.layer.borderColor = [[UIColor colorWithRed:255.0f/255.0f green:159.0f/255.0f blue:16.0f/255.0f alpha:1.0f] CGColor];
            view.layer.borderWidth = 1;
            view.hidden = YES;
            view ;
        });
    }
    return _headIconImageView;
    
}
                             
- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = ({
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [btn setBackgroundColor:kMainColor];
            [btn setTag:BUTTON_TAG(7)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:@"登录" forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
            
        });
    }
    return _loginButton;
}

- (KKButton *)justButton {
    if (!_justButton) {
        _justButton =({
            KKButton *btn = [KKButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"验证码登录" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(1)];
            [btn.titleLabel setTextAlignment:NSTextAlignmentRight];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn ;
            
        });
    }
    return _justButton;
}

- (KKButton *)justButton2 {
    if (!_justButton2) {
        _justButton2 =({
            KKButton *btn = [KKButton buttonWithType:UIButtonTypeSystem];
            [btn setTitleColor:COLOR_666666 forState:UIControlStateNormal];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            [btn setBackgroundColor:[UIColor clearColor]];
            [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
            [btn setTag:BUTTON_TAG(2)];
            [btn.titleLabel setTextAlignment:NSTextAlignmentLeft];
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn ;
        });
    }
    return _justButton2;
}
- (void)btnClicked:(UIButton *)button {
    if ([self.delegate respondsToSelector:@selector(jumpBtnClicked:)]) {
        [self.delegate jumpBtnClicked:button];
    }
}
- (UILabel *)titleLabelView2 {
    if (!_titleLabelView2) {
        _titleLabelView2 = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:24];
            label.text = @"欢迎来到奥传百科教育";
            label.textColor = COLOR_333333;
            label;
        });
    }
    return _titleLabelView2;
}
- (UILabel *)titleLabelView {
    if (!_titleLabelView) {
        _titleLabelView = ({
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:20];
            label.text = @"登录";
            label.textColor = COLOR_333333;
            label;
        });
    }
    return _titleLabelView;
}

- (UITextField *)mobileTextView {
    if (!_mobileTextView) {
        _mobileTextView =  ({
                   UITextField *textfield = [[UITextField alloc] init];
                   //设置边框
                   textfield.borderStyle = UITextBorderStyleNone;
                   //设置水印提示
                   textfield.placeholder = @"请输入手机号";
                   textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
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
               textfield.placeholder = @"请输入密码";
               textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
               //设置输入框右边的一键删除（x号）
               textfield.clearButtonMode = UITextFieldViewModeAlways;
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




- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    
}




@end
