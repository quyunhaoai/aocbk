//
//  MyExamHeaderView.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/9.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MyExamHeaderView.h"

#import "Header.h"

@interface MyExamHeaderView ()

@property (strong, nonatomic) UILabel *subjectLabel;
@property (strong, nonatomic) UILabel *subjectTypeLabel;
@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MyExamHeaderView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 180);
        self.backgroundColor = kWhiteColor;
        
        [self initView];
    }
    return self;
}

- (void)initView {
    
    [self addSubview:self.subjectLabel];
    [self addSubview:self.subjectTypeLabel];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.top.mas_equalTo(self).mas_offset(4);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(20);
    }];
    [self.subjectTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.top.mas_equalTo(self).mas_offset(4);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
    [self.subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(10);
        make.top.mas_equalTo(self).mas_offset(12);
        make.width.mas_equalTo(Window_W-20-15);
        make.bottom.mas_equalTo(self);
    }];
}

- (UILabel *)subjectLabel {
    if (!_subjectLabel) {
        _subjectLabel               = [[UILabel alloc]init];
        _subjectLabel.textColor     =Color_2A2A2A;
        _subjectLabel.font          = [UIFont systemFontOfSize:10.0];
        _subjectLabel.textAlignment = NSTextAlignmentLeft;
        _subjectLabel.numberOfLines	 = 0;
    }
    return _subjectLabel;
}

- (UILabel *)subjectTypeLabel {
    if (!_subjectTypeLabel) {
        _subjectTypeLabel =( {
            UILabel *view = [UILabel new];
            view.textColor =kMainColor;
            view.font = STFont(10);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentCenter;
            view.layer.masksToBounds = YES;
            view.layer.borderColor = kMainColor.CGColor;
            view.layer.cornerRadius = 5;
            view.layer.borderWidth = 0.5;
            view.hidden = YES;
            view;
            
        });
    }
    return _subjectTypeLabel;

}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = ( {
            
            UILabel *view = [UILabel new];
            view.textColor = UIColorHex(0x505050);
            view.font = STFont(10);
            view.lineBreakMode = NSLineBreakByTruncatingTail;
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.hidden = YES;
            view;
            
        });
    }
    return _titleLabel;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
