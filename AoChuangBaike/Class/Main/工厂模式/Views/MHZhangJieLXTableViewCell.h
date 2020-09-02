//
//  MHZhangJieLXTableViewCell.h
//  MentalHorizonProject
//
//  Created by    on 2020/4/30.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MHZhangJieLX.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHZhangJieLXTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title1Lab;
@property (weak, nonatomic) IBOutlet UILabel *title2Lab;
@property (weak, nonatomic) IBOutlet UILabel *title3Lab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) MHZhangJieLX *modelcc;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
