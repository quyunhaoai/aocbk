//
//  GHValidationCodeView.m
//  GhuiDemo
//
//  Created by Ghui on 2020/3/24.
//  Copyright © 2020 Ghui. All rights reserved.
//
#define GHCodeViewHeight self.frame.size.height

#define GH_WIDTH        [[UIScreen mainScreen] bounds].size.width
#define Head_W          70.0f      // 第一个头像的宽
#define Head_H          50.0f     // 第一个头像的高
#define Width_Space      ([[UIScreen mainScreen] bounds].size.width-280)/5


#import "GHValidationCodeView.h"

@interface GHValidationCodeView()<UITextFieldDelegate>

// 存放 label 的数组
@property (nonatomic, strong) NSMutableArray *labelArr;
// label 的数量
@property (nonatomic, assign) NSInteger labelCount;
// label 之间的距离
@property (nonatomic, assign) CGFloat labelDistance;
// 输入文本框
@property (nonatomic, strong) GHTextField *codeTextField;

@end

@implementation GHValidationCodeView
- (instancetype)initWithFrame:(CGRect)frame andLabelCount:(NSInteger)labelCount andLabelDistance:(CGFloat)labelDistance {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.labelCount = labelCount;
        self.labelDistance = labelDistance;
        self.changedColor = [UIColor redColor];
        self.defaultColor = [UIColor blackColor];
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.codeTextField.text = @"";

    //起始位置 居中 Ghui
    CGFloat startX = (GH_WIDTH - (self.labelCount*Head_W + (self.labelCount-1)*Width_Space))/2;

    for (int i = 0; i < self.labelCount; i++) {

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * (Head_W + Width_Space) + startX, 0, Head_W, Head_H)];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        [self.labelArr addObject:label];
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSInteger i = textField.text.length;
    if (i == 0) {
        ((UILabel *)[self.labelArr objectAtIndex:0]).text = @"";
        ((UILabel *)[self.labelArr objectAtIndex:0]).layer.borderColor = _defaultColor.CGColor;
    } else {
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).text = [NSString stringWithFormat:@"%C", [textField.text characterAtIndex:i - 1]];
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).layer.borderColor = _changedColor.CGColor;
        ((UILabel *)[self.labelArr objectAtIndex:i - 1]).textColor = _changedColor;
        if (self.labelCount > i) {
            ((UILabel *)[self.labelArr objectAtIndex:i]).text = @"";
            ((UILabel *)[self.labelArr objectAtIndex:i]).layer.borderColor = _defaultColor.CGColor;
        }
    }
    if (self.codeBlock) {
        self.codeBlock(textField.text);
    }
}
- (void)clearCoed{
    self.codeTextField.text = @"";
    for (int i = 0; i < 4; i++) {
        ((UILabel *)[self.labelArr objectAtIndex:i]).text = @"";
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    } else if (string.length == 0) {
        return YES;
    } else if (textField.text.length >= self.labelCount) {
        return NO;
    } else {
        return YES;
    }
}

#pragma mark - 懒加载
- (GHTextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [[GHTextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, GHCodeViewHeight)];
        _codeTextField.backgroundColor = [UIColor clearColor];
        _codeTextField.textColor = [UIColor clearColor];
        _codeTextField.tintColor = [UIColor clearColor];
        _codeTextField.delegate = self;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.layer.borderColor = [[UIColor grayColor] CGColor];
        [_codeTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_codeTextField];
    }
    return _codeTextField;
}

#pragma mark - 懒加载
- (NSMutableArray *)labelArr {
    if (!_labelArr) {
        _labelArr = [NSMutableArray array];
    }
    return _labelArr;
}

@end


@implementation GHTextField

/// 重写 UITextFiled 子类, 解决长按复制粘贴的问题
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
