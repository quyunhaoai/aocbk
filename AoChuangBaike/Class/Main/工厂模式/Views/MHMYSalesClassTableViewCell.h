//
//  MHMYSalesClassTableViewCell.h
//  MentalHorizonProject
//
//  Created by    on 2020/4/27.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHMYSalesClassTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewsss;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;



+ (CGFloat)height;
@end

NS_ASSUME_NONNULL_END
