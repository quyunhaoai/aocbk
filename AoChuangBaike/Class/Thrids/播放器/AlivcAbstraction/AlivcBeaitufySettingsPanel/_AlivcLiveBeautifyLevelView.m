//
//  _AlivcLiveBeautifyLevelView.m
//  BeautifySettingsPanel
//
//  Created by 汪潇翔 on 2018/5/29.
//  Copyright © 2018 汪潇翔. All rights reserved.
//

#import "_AlivcLiveBeautifyLevelView.h"
#import "_AlivcLiveBeautifyNavigationView.h"
#import "NSString+AlivcHelper.h"
#import "AlivcUIConfig.h"
#import "AlivcMacro.h"
static const CGFloat AlivcLiveButtonWidth = 45.0f;

@implementation _AlivcLiveBeautifyLevelView{
    _AlivcLiveBeautifyNavigationView *_navigationView;
    NSArray<UIButton *> *_buttons;
    UIView *_buttonsContentView;
    __weak UIButton *_selectedButton;
    UIImageView *_triangleImageView;
    UIButton *_advenceButton;
    UIButton *_normalButton;
    AlivcBeautySettingViewStyle _uiStyle;
    UITextView *_bottomTextView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _level = 0;
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        
        UIButton *titleButton = [[UIButton alloc] init];
        [titleButton setImage:[UIImage imageNamed:@"AlivcIconBeauty"] forState:UIControlStateNormal];
        [titleButton setTitle:[NSString stringWithFormat:@"  %@",[@"Face Filter" localString]] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [titleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        titleButton.frame = CGRectMake(0, 0, 120, 44);
        self.titleButton = titleButton;
        _navigationView = [_AlivcLiveBeautifyNavigationView navigationViewTitleView:titleButton];
        [self addSubview:_navigationView];
        
        _buttonsContentView = [[UIView alloc] initWithFrame:CGRectZero];
        [self addSubview:_buttonsContentView];
        _buttons  = [self _buttonsWithCount:6];
        
        UIButton *button = _buttons[_level];
        button.selected = YES;
        _selectedButton = button;
        
        _uiStyle = AlivcBeautySettingViewStyle_Default;
    }
    return self;
}

- (NSArray<UIButton *> *)_buttonsWithCount:(NSInteger)count {
    NSMutableArray<UIButton *> *array = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, AlivcLiveButtonWidth, AlivcLiveButtonWidth);
        button.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        button.layer.cornerRadius = AlivcLiveButtonWidth * 0.5;
        
        [button setTitle:@(index).stringValue forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_btn_image"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_btn_image_selected"] forState:UIControlStateNormal | UIControlStateSelected];
        
        [button addTarget:self action:@selector(_levelButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [array addObject:button];
        [_buttonsContentView addSubview:button];
    }
    return [array copy];
}

- (_AlivcLiveBeautifyNavigationView *)navigationView {
    return _navigationView;
}

- (void)setUIStyle:(AlivcBeautySettingViewStyle)uiStyle{
    _uiStyle = uiStyle;
    dispatch_async(dispatch_get_main_queue(), ^{//录制界面会出现设置了专业版，但是显示的仍然是基础版的问题，查到c原因是子线程进行了UI操作，这里规避下
        [self setTheDitailButtonWithType:_uiStyle];
        //move san jiao biao
        switch (uiStyle) {
            case AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Base:
            {
                CGFloat buttonsContentHeight =  CGRectGetHeight(_buttonsContentView.frame);
                CGFloat imcy = buttonsContentHeight - 2 - _triangleImageView.frame.size.height / 2;
                _triangleImageView.center = CGPointMake(_normalButton.center.x, imcy - SafeBeautyBottom);
                
            }
                break;
            case AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Advanced:{
                CGFloat buttonsContentHeight =  CGRectGetHeight(_buttonsContentView.frame);
                CGFloat imcy = buttonsContentHeight - 2 - _triangleImageView.frame.size.height / 2;
                _triangleImageView.center = CGPointMake(_advenceButton.center.x, imcy - SafeBeautyBottom);
            }
                break;
            case AlivcBeautySettingViewStyle_ShortVideo_BeautySkin:
                [self addThirdInfo];
                break;
                
            default:
                break;
        }
    });
  
    
}


/**
 添加三方信息
 */
- (void)addThirdInfo{
    if (!_bottomTextView) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 180 - 20, ScreenWidth, 30)];
        [self addSubview:textView];
        _bottomTextView = textView;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[@"Advanced Beauty is provided by faceunity  How to get" localString] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        [attributedString addAttributes:@{
                                          NSLinkAttributeName:@"click://",
                                          NSUnderlineStyleAttributeName:@(1)
                                          } range:[[attributedString string] rangeOfString:[@"How to get" localString]]];
        
        
        _bottomTextView.attributedText = attributedString;
        _bottomTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[AlivcUIConfig shared].kAVCThemeColor};
        _bottomTextView.backgroundColor = [UIColor clearColor];
        _bottomTextView.textAlignment = NSTextAlignmentCenter;
        _bottomTextView.delegate = self;
        _bottomTextView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _bottomTextView.scrollEnabled = NO;
    }
}

#pragma mark UITextVeiwDelegate

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"click"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(levelViewDidSelectHowToGet:)]) {
            [self.delegate levelViewDidSelectHowToGet:self];
        }
        return NO;
    }
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange interaction:(UITextItemInteraction)interaction NS_AVAILABLE_IOS(10_0){
    if ([[URL scheme] isEqualToString:@"click"]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(levelViewDidSelectHowToGet:)]) {
            [self.delegate levelViewDidSelectHowToGet:self];
        }
        return NO;
    }
    return YES;
}

- (void)setTheDitailButtonWithType:(AlivcBeautySettingViewStyle)style{
    if (_uiStyle != AlivcBeautySettingViewStyle_Default) {
        //微调按钮移动
        CGRect frame = self.navigationView.rightButton.frame;
        frame.origin = CGPointMake(ScreenWidth - 136, 8);
        [_buttonsContentView addSubview:self.navigationView.rightButton];
        if (style == AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Base) {
            self.navigationView.rightButton.hidden = YES;
        }else{
            self.navigationView.rightButton.hidden = NO;
        }
    }
}

- (AlivcBeautySettingViewStyle)currentUIStyle{
    return _uiStyle;
}

- (UIButton *)_buttonWithTitle:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateSelected];
    [button setTitleColor:[UIColor groupTableViewBackgroundColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [button sizeToFit];
    return button;
}

- (void)advancedButtonTouched:(UIButton *)button{
   
    [self setUIStyle:AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Advanced];
    if ([self.delegate respondsToSelector:@selector(levelView:didChangeUIStyle:)]) {
        [self.delegate levelView:self didChangeUIStyle:AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Advanced];
    }
}

- (void)normalButtonTouched:(UIButton *)button{
    [self setUIStyle:AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Base];
    if ([self.delegate respondsToSelector:@selector(levelView:didChangeUIStyle:)]) {
        [self.delegate levelView:self didChangeUIStyle:AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Base];
    }
}

- (void)layoutSubviews {
    _navigationView.frame =
        CGRectMake(0, 0, CGRectGetWidth(self.bounds), 44.f);
    
    _buttonsContentView.frame = CGRectMake(15.f,
                                           CGRectGetMaxY(_navigationView.frame),
                                           CGRectGetWidth(self.bounds) - 15 * 2,
                                           CGRectGetHeight(self.bounds) - CGRectGetMaxY(_navigationView.frame));
    
    CGFloat buttonsContentWidth = CGRectGetWidth(_buttonsContentView.frame);
    CGFloat buttonsContentHeight =  CGRectGetHeight(_buttonsContentView.frame);
    CGFloat buttonsInterval = (buttonsContentWidth - AlivcLiveButtonWidth * _buttons.count) / (_buttons.count - 1);
    CGFloat buttonY = (buttonsContentHeight - AlivcLiveButtonWidth) * 0.5;
    CGFloat buttonX = 0;
    for (UIButton *button in _buttons) {
        CGRect frame = button.frame;
        frame.origin.x = buttonX;
        frame.origin.y = buttonY;
        button.frame = frame;
        buttonX = CGRectGetMaxX(frame) + buttonsInterval;
        
    }
    
    //短视频对于视图的调整
    [self setTheDitailButtonWithType:_uiStyle];
    if (_uiStyle != AlivcBeautySettingViewStyle_Default) {
        self.backgroundColor = [UIColor clearColor];
        //移除顶部栏里的视图，背景变透明
        for (UIView *view in self.navigationView.subviews){
            [view removeFromSuperview];
        }
        self.navigationView.backgroundColor = [UIColor clearColor];
        
        if (_uiStyle == AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Base || _uiStyle == AlivcBeautySettingViewStyle_ShortVideo_BeautyFace_Advanced) {
            //添加高级，普通按钮,三角选中标识
            CGFloat abcx = buttonsContentWidth / 2 - 36;
            
            if (!_advenceButton) {
                _advenceButton = [self _buttonWithTitle:[@"高级" localString]];
                [_advenceButton addTarget:self action:@selector(advancedButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
                [_buttonsContentView addSubview:_advenceButton];
            }
            _advenceButton.center = CGPointMake(abcx, buttonsContentHeight - 20 - SafeBeautyBottom);
            
            if (!_normalButton) {
                _normalButton = [self _buttonWithTitle:[@"普通" localString]];
                [_normalButton addTarget:self action:@selector(normalButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
                [_buttonsContentView addSubview:_normalButton];
            }
            _normalButton.center = CGPointMake(buttonsContentWidth / 2 + 36, buttonsContentHeight - 20 - SafeBeautyBottom);
            
            if (!_triangleImageView) {
                _triangleImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alivc_triangle"]];
                [_triangleImageView sizeToFit];
//                CGFloat imcy = buttonsContentHeight - 2 - _triangleImageView.frame.size.height / 2;
//                _triangleImageView.center = CGPointMake(abcx, imcy - SafeBeautyBottom);
                [self setUIStyle:self.currentUIStyle];
                [_buttonsContentView addSubview:_triangleImageView];
            }
            CGFloat imcy = buttonsContentHeight - 2 - _triangleImageView.frame.size.height / 2;
            _triangleImageView.center = CGPointMake(abcx, imcy - SafeBeautyBottom);
        }
       
        
    }
    
}

- (void)setLevel:(NSInteger)level {
    if (_level != level) {
        _level = level;
        UIButton *button = _buttons[level];
        button.selected = YES;
        if (button != _selectedButton) {
            _selectedButton.selected = NO;
            _selectedButton = button;
        }
        
    }
}


- (void)_levelButtonOnClick:(UIButton *)sender {
    if(sender.selected) return;
    sender.selected = YES;
    _selectedButton.selected = NO;
    _selectedButton = sender;
    if (self.delegate && [self.delegate respondsToSelector:@selector(levelView:didChangeLevel:)]) {
        [self.delegate levelView:self didChangeLevel:[_buttons indexOfObject:sender]];
    }
}

@end
