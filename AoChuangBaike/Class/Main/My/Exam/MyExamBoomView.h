//
//  MyExamBoomView.h
//  Exam
//
//  Created by 郑敏捷 on 17/2/10.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^subjectActionBlock)(NSInteger btnTag);

@interface MyExamBoomView : UIView

@property (copy, nonatomic) subjectActionBlock subjectBlock;

@end
