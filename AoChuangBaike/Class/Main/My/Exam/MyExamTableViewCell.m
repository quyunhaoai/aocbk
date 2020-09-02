//
//  MyExamTableViewCell.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/8.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MyExamTableViewCell.h"

#import "Header.h"

#import "UIButton+BackgroundColor.h"

@interface MyExamTableViewCell ()

@property (strong, nonatomic) UIButton *selectedBtn;
@property (strong, nonatomic) UIView *contentCustomView;
@property (strong, nonatomic) UILabel *contentLab;


@end

@implementation MyExamTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)initView {
    [self.contentView addSubview:self.contentCustomView];
    [self.contentCustomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.top.mas_equalTo(self.contentView).mas_offset(6);
        make.right.mas_equalTo(self.contentView).mas_offset(-12);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-6);
    }];
    [self.contentCustomView addSubview:self.selectedBtn];
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(20);
        make.centerY.mas_equalTo(self.contentView).mas_offset(0);
        make.width.height.mas_equalTo(20);
    }];
    self.selectedBtn.centerY = self.contentCustomView.centerY;
    [self.contentCustomView addSubview:self.contentLab];
    [self.contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.selectedBtn.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.contentView).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(-13);
        make.height.mas_equalTo(self.contentView);
    }];
    self.selectedBtn.hidden = NO;
    self.contentLab.hidden = NO;
    [self.contentCustomView addSubview:self.fullTextView];
    [self.fullTextView masUpdateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(20);
        make.centerY.mas_equalTo(self.contentView).mas_offset(0);
        make.right.mas_equalTo(self.contentView).mas_offset(-13);
        make.height.mas_equalTo(20);
    }];
    self.fullTextView.hidden = YES;
}
- (UITextField *)fullTextView {
    if (!_fullTextView) {
        _fullTextView = ({
            UITextField *textfield = [[UITextField alloc] init];
            //设置边框
            textfield.borderStyle = UITextBorderStyleNone;
            //设置水印提示
            textfield.placeholder = @"1、请输入你的答案";
            textfield.placeholderColor= COLOR_HEX_RGB(0xbbbbbb);
            //设置输入框右边的一键删除（x号）
            textfield.clearButtonMode = 0;
            //设置密码安全样式
            textfield.secureTextEntry = NO;
            //设置键盘样式
            textfield.keyboardType = UIKeyboardTypeDefault;
             
            textfield.backgroundColor = kClearColor;
            //设置输入的字体大小
            textfield.font = [UIFont systemFontOfSize:15];

            textfield;
        
        });
    }
    return _fullTextView;
}
- (UIView *)contentCustomView {
    if (!_contentCustomView) {
        _contentCustomView = [[UIView alloc] init];
    }
    return _contentCustomView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab = ({
            UILabel *view = [UILabel new];
            view.textColor = UIColorHex(0x505050);
            view.font = STFont(14);
            view.backgroundColor = [UIColor clearColor];
            view.textAlignment = NSTextAlignmentLeft;
            view.numberOfLines = 0;
            view;
        });
    }
    return _contentLab;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn                    = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectedBtn.titleLabel.font    = [UIFont systemFontOfSize:14.0];
        [_selectedBtn      setTitleColor:UIColorHex(0x505050) forState:UIControlStateNormal];
        [_selectedBtn      setTitleColor:UIColorHex(0xfba937) forState:UIControlStateSelected];
    }
    return _selectedBtn;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setQmodel:(Answer_all *)Qmodel {
    _Qmodel = Qmodel;

    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[_Qmodel.A dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [self.contentLab setAttributedText:attrStr];
}
@end
