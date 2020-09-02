//
//  MHMyHeadview.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//
typedef void(^buttonClick)(NSInteger i);
#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMyHeadview : CCBaseView
@property (strong, nonatomic) NSArray *buttosArray;
@property (copy, nonatomic) buttonClick buttonAction;
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *qianmingLab;
@property (strong, nonatomic) UIImageView *headImage;  



@end

NS_ASSUME_NONNULL_END
