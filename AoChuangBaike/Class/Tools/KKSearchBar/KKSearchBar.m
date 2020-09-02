//
//  KKSearchBar.m
//  KKToydayNews
//
//  Created by finger on 2017/8/9.
//  Copyright © 2017年 finger. All rights reserved.
//

#import "KKSearchBar.h"
//#import "UISearchBar+Custom.h"

@interface KKSearchBar ()
//@property(nonatomic)UIImageView *searchIcon;
//@property(nonatomic)UILabel *placeholderLabel;
//@property (nonatomic,strong) UIButton *rightBtn;
//@property (nonatomic,strong) UIButton *searchBtn;
@end

@implementation KKSearchBar

- (id)init{
    self = [super init];
    if(self){
        [self setupUI];
    }
    return self;
}

#pragma mark -- 设置UI

- (void)setupUI{
    [self addSubview:self.searchBtn];
    [self addSubview:self.searchIcon];
    [self addSubview:self.placeholderLabel];
    [self addSubview:self.rightBtn];
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(11);
        make.size.mas_equalTo(CGSizeMake(Window_W -11-64, 35));
        make.centerY.mas_equalTo(self);
    }];
    [self.searchIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(23);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self);
    }];
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-5);
    }];
    
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-11);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self);
    }];
    self.centerYOff = STATUS_BAR_HIGHT/2;
}

- (void)setCenterYOff:(CGFloat)centerYOff {
    _centerYOff = centerYOff;
    
    [self.searchBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(11);
        make.size.mas_equalTo(CGSizeMake(Window_W -11-64, 35));
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
    }];
    [self.searchIcon mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(23);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
    }];
    [self.placeholderLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
        make.right.mas_equalTo(self).mas_offset(-5);
    }];
    
    [self.rightBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-22);
        make.size.mas_equalTo(CGSizeMake(20, 24));
        make.centerY.mas_equalTo(self).mas_offset(_centerYOff);
    }];
    
}
- (void)btnClicked:(UIButton *)sender {
    
}
#pragma mark -- @property
- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundColor:kWhiteColor];
            btn.alpha = 1.0 ;
            btn.layer.masksToBounds = NO;
            btn.layer.cornerRadius = 17.5;
            [btn setTag:BUTTON_TAG(9)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setClipsToBounds:YES];
            btn.layer.shadowColor =  [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:0.36].CGColor;
            btn.layer.shadowOffset = CGSizeMake(0,0);
            btn.layer.shadowOpacity = 1;
            btn.layer.shadowRadius = 8;
            btn ;

        });
    }
    return _searchBtn;
}
- (UIButton *)rightBtn {
    if (!_rightBtn) {
        _rightBtn = ({
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTag:BUTTON_TAG(8)];
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:IMAGE_NAME(@"消息") forState:UIControlStateNormal];
            [btn setClipsToBounds:YES];
            btn.layer.cornerRadius = 3;
            btn ;
        });
    }
    return _rightBtn;
}
- (UIImageView *)searchIcon{
    if(!_searchIcon){
        _searchIcon = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.image = [UIImage imageNamed:@"搜索"];
            view ;
        });
    }
    return _searchIcon;
}

- (UILabel *)placeholderLabel{
    if(!_placeholderLabel){
        _placeholderLabel = ({
            UILabel *view = [UILabel new];
            view.text = @"搜索你想了解的";
            view.textColor = COLOR_999999;
            view.font = [UIFont systemFontOfSize:13];
            view.textAlignment = NSTextAlignmentLeft;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view ;
        });
    }
    return _placeholderLabel;
}

@end
