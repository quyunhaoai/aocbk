//
//  STLoginMobileInputView.h
//  StudyOC
//
//  Created by   on 2019/10/10.
//  Copyright © 2019  . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TYAttributedLabel.h>
NS_ASSUME_NONNULL_BEGIN

@interface STLoginMobileInputView : UIView
@property (weak, nonatomic) id<KKCommonDelegate> delegate; //
@property (strong, nonatomic) UITextField *mobileTextView;   //  文本域
@property (strong, nonatomic) UITextField *verWordTextView;   //  文本域

@property (strong, nonatomic) UILabel *titleLabelView; // 视图
@property (strong, nonatomic) UILabel *titleLabelView2; // 视图
@property (strong, nonatomic) UILabel *niceLabel; //  标签
@property (strong, nonatomic) UILabel *mobileLabel; //  标签
@property (strong, nonatomic) UILabel *verWordLabel; //  标签


@property (nonatomic,strong) UIButton *justButton; //  按钮
@property (nonatomic,strong) UIButton *loginButton; //  按钮
@property (nonatomic,strong) UIButton *verButton; //  按钮

@property (strong, nonatomic) UIView *line1; //  视图
@property (strong, nonatomic) UIView *line2; //  视图

@property (strong, nonatomic) TYAttributedLabel *regestLabel; //  标签
@property (strong, nonatomic) TYAttributedLabel *regestLabel2; //  标签
@end

NS_ASSUME_NONNULL_END
