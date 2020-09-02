//
//  MyExamTopView.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/10.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MyExamTopView.h"

#import "Header.h"

@interface MyExamTopView ()

@property (strong, nonatomic) UILabel *subjectTypeLabel;

@property (strong, nonatomic) UILabel *subjectNumLabel;

@end

@implementation MyExamTopView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, 75);
        self.backgroundColor = UIColorHex(0xf7f7f7);
        [self initView];
    }
    return self;
}

- (void)initView {
    [self addSubview:self.subjectTypeLabel];
    [self addSubview:self.subjectNumLabel];
    [self addSubview:self.timeLab];
    [self addSubview:self.iconImage];
    UIView *cornerView = [UIView new];
    [[CCTools sharedInstance] addborderToView:cornerView width:0.8 color:UIColorHex(0xfba937)];
    [self addSubview:cornerView];
    [cornerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [cornerView addSubview:self.headLab];
    [self.timeLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self).mas_offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    [self.iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(10);
        make.right.mas_equalTo(self.timeLab.mas_left).mas_offset(0);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    [self.headLab mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(cornerView).mas_offset(0);
        make.size.mas_equalTo(CGSizeMake(14, 14));
    }];
    
    cornerView.layer.masksToBounds = YES;
    cornerView.layer.cornerRadius = 10;
    
    UIView *line = [UIView new];
    line.backgroundColor = COLOR_e5e5e5;
    [self addSubview:line];
    [line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cornerView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self).mas_offset(0);
        make.width.mas_equalTo(Window_W);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab = ({
            UILabel *view = [UILabel new];
            view.textColor = UIColorHex(0x707070);
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentCenter;
//            view.text = @"不限时";
            view;

        });
    }
    return _timeLab;
}

- (UIImageView *)iconImage {
    if (!_iconImage) {
        _iconImage =  ({
               UIImageView *view1 = [UIImageView new];
               view1.contentMode = UIViewContentModeScaleAspectFit;
               view1.image = [UIImage imageNamed:@"dowm_time_pic"];
               view1 ;
           });
    }
    return _iconImage;
}

- (UILabel *)headLab {
    if (!_headLab) {
        _headLab = ({
            
            UILabel *view = [UILabel new];
            view.textColor = UIColorHex(0xfba937);
            view.font = STFont(14);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.textAlignment = NSTextAlignmentLeft;
//            view.text = @"八";
            view;
        });
    }
    return _headLab;
}

- (UILabel *)subjectTypeLabel {
    if (!_subjectTypeLabel) {
        _subjectTypeLabel                    = [[UILabel alloc]init];
        _subjectTypeLabel.frame              = CGRectMake(40, 10, (SCREEN_WIDTH - 20) / 3, 20);
        _subjectTypeLabel.textColor          = COLOR_333333;
        _subjectTypeLabel.font               = [UIFont systemFontOfSize:22.0];
        _subjectTypeLabel.textAlignment      = NSTextAlignmentLeft;
//        _subjectNumLabel.text                = @"测试";
    }
    return _subjectTypeLabel;
}

- (UILabel *)subjectNumLabel {
    if (!_subjectNumLabel) {
        _subjectNumLabel                    = [[UILabel alloc]init];
        _subjectNumLabel.frame              = CGRectMake(SCREEN_WIDTH / 2, 50, (SCREEN_WIDTH - 20) / 2, 20);
        _subjectNumLabel.textColor          = COLOR_999999;
        _subjectNumLabel.font               = [UIFont systemFontOfSize:12.0];
        _subjectNumLabel.textAlignment      = NSTextAlignmentRight;
    }
    return _subjectNumLabel;
}






@end
