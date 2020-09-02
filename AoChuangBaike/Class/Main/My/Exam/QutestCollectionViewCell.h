//
//  QutestCollectionViewCell.h
//  Exam
//
//  Created by 郑敏捷 on 17/2/8.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTTiKaSendView.h"
#import "TTQuestionModel.h"
#import "TTListAnswerModel.h"
typedef void(^SingleSelectActionBlock)(NSIndexPath *seleIndexPath, NSInteger btnTag);
typedef void(^MultiSelectActionBlock)(NSInteger btnTagSum);
typedef void(^callModel)(TTQuestionModel *Qmodel);
@interface QutestCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) SingleSelectActionBlock SingleSelectBlock;

@property (strong, nonatomic) NSString    *seleIndexStr;

@property (strong, nonatomic) NSIndexPath *seleIndexPath;

@property (assign, nonatomic) NSInteger index;

@property (nonatomic,strong) TTQuestionModel *model;

@property (copy, nonatomic) MultiSelectActionBlock MultiSelectBlock;

@property (strong, nonatomic) TTTiKaSendView *sendView; 

@property (strong, nonatomic) NSMutableArray *selectArr;   

@property(nonatomic,strong) TTQuestionModel *mmmmodel;

@property (assign, nonatomic) BOOL isJiexi;

@property (strong, nonatomic) NSMutableArray * myAnswerArray;//结果数组
/*
 *   block
 */
@property (copy, nonatomic) callModel blackModel;
@property (strong, nonatomic) NSMutableArray    *relustArray;
@property (nonatomic,assign) NSInteger paperid;
@property (nonatomic,strong) TTListAnswerModel *listModel;
@end
