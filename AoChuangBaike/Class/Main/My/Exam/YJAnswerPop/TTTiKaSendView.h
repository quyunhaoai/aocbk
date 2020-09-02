//
//  TTTiKaSendView.h
//  TTAnswer
//
//  Created by GOOUC on 2020/3/25.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"
#import "TTQuestionModel.h"
#import "TTListAnswerModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTTiKaSendView : CCBaseView

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * categoryQuestionList;
@property (nonatomic,strong) UILabel *topView;
@property (nonatomic,strong) UIButton *sendBtn;
@property (nonatomic,strong) TTQuestionModel *answerModel;
@property (strong, nonatomic) NSMutableArray *reslutArray;   

/** c */
@property (copy, nonatomic) void (^callBack)(id path);
@property (nonatomic,assign) NSInteger paperid;
@property (strong, nonatomic) TTListAnswerModel *questListModel;   
@end

NS_ASSUME_NONNULL_END
