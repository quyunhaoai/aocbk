//
//  YJAnswerPopCollectionViewCell.h
//  答题详情
//
//  Created by 冯垚杰 on 2017/7/3.
//  Copyright © 2017年 冯垚杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJAnswerPopModel.h"

@interface YJAnswerPopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic,strong) YJAnswerPopModel *model;
@property (nonatomic,strong) YJAnswerPopModel *cmodel;
@end
