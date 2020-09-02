//
//  MyExamViewController.h
//  Exam
//
//  Created by 郑敏捷 on 17/2/8.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCBaseViewController.h"
#import "TTListAnswerModel.h"
@interface MyExamViewController : CCBaseViewController
@property (nonatomic,strong) TTListAnswerModel *model;
@property (assign, nonatomic) BOOL isJiexi;
@property (copy, nonatomic) NSString *PID;  
@end
