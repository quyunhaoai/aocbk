//
//  MyExamFooterView.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/9.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MyExamFooterView.h"

#import "Header.h"

@interface MyExamFooterView ()


@end

@implementation MyExamFooterView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 100);
        self.backgroundColor = kWhiteColor;
        [self initView];
    }
    return self;
}

- (void)initView {
    
    [self addSubview:self.answerLabel];
    [self addSubview:self.analysisLabel];
    [self addSubview:self.titleLab];
    [self addSubview:self.stateImage];
    [self.titleLab masMakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.top.mas_equalTo(self).mas_offset(35);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [self.analysisLabel masMakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.top.mas_equalTo(self.titleLab.mas_bottom).mas_offset(5);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(20);
    }];
    [self.answerLabel masMakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).mas_offset(0);
        make.top.mas_equalTo(self).mas_offset(5);
        make.width.mas_equalTo(116);
        make.height.mas_equalTo(14);
    }];
    [self.stateImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.answerLabel.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self.answerLabel).mas_offset(0);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    UIButton *sureBtn = ({
        UIButton *view = [UIButton buttonWithType:UIButtonTypeCustom];
        [view setTitle:@"下一题" forState:UIControlStateNormal];
        [view.titleLabel setTextColor:kWhiteColor];
        [view.titleLabel setFont:FONT_14];
        [view setBackgroundColor:kMainColor];
        [view setUserInteractionEnabled:YES];
        view.layer.cornerRadius = 25;
        [view addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        view ;
    });
    [self addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(_analysisLabel.mas_bottom).mas_offset(19);
    }];
}
- (void)commentBtnClick:(UIButton *)button {
    if (self.nextAnswer) {
        self.nextAnswer();
    }
}
- (void)drawRect:(CGRect)rect {

}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = ({
            UILabel *view = [UILabel new];
            view.textColor = COLOR_333333;
            view.font = FONT_14;
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.text = @"解析";
            view ;
        });
    }
    return _titleLab;
}
- (UILabel *)answerLabel {
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc]init];
        _answerLabel.font = [UIFont systemFontOfSize:13.0];
        _answerLabel.textColor = UIColorHex(0x505050);
        _answerLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _answerLabel;
}

- (UILabel *)analysisLabel {
    if (!_analysisLabel) {
        _analysisLabel = [[UILabel alloc]init];
        _analysisLabel.font = [UIFont systemFontOfSize:13.0];
        _analysisLabel.textColor =COLOR_666666;
        _analysisLabel.numberOfLines = 0;
    }
    return _analysisLabel;
}

- (UIImageView *)stateImage {
    if (!_stateImage) {
        _stateImage = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill ;
            view.layer.masksToBounds = YES ;
            view.userInteractionEnabled = YES ;
            view;
        });
    }
    return _stateImage;
}

@end
