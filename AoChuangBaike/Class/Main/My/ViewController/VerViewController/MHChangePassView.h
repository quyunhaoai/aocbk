//
//  MHChangePassView.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/7.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHChangePassView : CCBaseView
@property (weak,nonatomic) id <KKCommonDelegate>delegate;
@property (strong, nonatomic) UITextField *niceTextView;   //  文本域
@property (strong, nonatomic) UITextField *mobileTextView;   //  文本域
@property (strong, nonatomic) UITextField *passWordTextView;   //  文本域
@property (strong, nonatomic) UILabel *titleLabelView; // 视图
@property (nonatomic,strong) KKButton           *verButton; //  按钮
@property (nonatomic,strong) UIButton           *loginButton; //  按钮
@property (strong, nonatomic) UIImageView       *lookImage;
@property (strong, nonatomic) UIImageView       *viewTowImage;



@property (strong, nonatomic) UILabel *verLoginLab; //  标签
@property (strong, nonatomic) UILabel *fastLoginLab; //  标签
@property (strong, nonatomic) UILabel *fongetpassWordLabel; //  标签

@property (assign, nonatomic) BOOL isVerLogin;
@property (assign, nonatomic) BOOL isOpen;
@end

NS_ASSUME_NONNULL_END
