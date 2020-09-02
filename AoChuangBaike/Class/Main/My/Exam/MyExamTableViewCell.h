//
//  MyExamTableViewCell.h
//  Exam
//
//  Created by 郑敏捷 on 17/2/8.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHPactioceModel.h"
@interface MyExamTableViewCell : UITableViewCell

@property (strong, nonatomic, readonly) UIButton *selectedBtn;
@property (strong, nonatomic, readonly) UIView *contentCustomView;
@property (strong, nonatomic, readonly) UILabel *contentLab;

@property (strong, nonatomic) UITextField *fullTextView;

@property (nonatomic,strong) Answer_all *Qmodel;  


@end
