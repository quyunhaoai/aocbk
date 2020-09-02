//
//  MyExamFooterView.h
//  Exam
//
//  Created by 郑敏捷 on 17/2/9.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyExamFooterView : UIView
@property (strong, nonatomic) UILabel *answerLabel;

@property (strong, nonatomic) UILabel *analysisLabel;

@property (strong, nonatomic) UILabel *titleLab;

@property (strong, nonatomic) UIImageView *stateImage;  

/** a */
@property (copy, nonatomic) void (^nextAnswer)(void);
@end
