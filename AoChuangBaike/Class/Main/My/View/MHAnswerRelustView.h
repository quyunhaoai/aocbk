//
//  MHAnswerRelustView.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/5/2.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHAnswerRelustView : CCBaseView
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * categoryQuestionList;
@property (strong, nonatomic) UIView *topView;


@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIButton *sendBtn;

@property (strong, nonatomic) NSMutableArray *reslutArray;

/** c */
@property (copy, nonatomic) void (^callBack)(id path);
@property (nonatomic,assign) NSInteger paperid;

@end

NS_ASSUME_NONNULL_END
