//
//  GHValidationCodeView.h
//  GhuiDemo
//
//  Created by Ghui on 2020/3/24.
//  Copyright © 2020 Ghui. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^GHCodeDidChangeBlock)(NSString *codeString);

NS_ASSUME_NONNULL_BEGIN

@interface GHValidationCodeView : UIView

- (instancetype)initWithFrame:(CGRect)frame andLabelCount:(NSInteger)labelCount andLabelDistance:(CGFloat)labelDistance;
- (void)clearCoed;
// 回调的 block , 获取输入的数字
@property (nonatomic, copy) GHCodeDidChangeBlock codeBlock;
// 默认颜色 不设置的话是黑色
@property (nonatomic, strong) UIColor *defaultColor;
// 改变后的颜色 不设置的话是红色
@property (nonatomic, strong) UIColor *changedColor;

@end

@interface GHTextField : UITextField

@end
NS_ASSUME_NONNULL_END
