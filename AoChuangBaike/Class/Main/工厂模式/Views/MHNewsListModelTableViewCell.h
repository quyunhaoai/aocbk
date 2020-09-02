//
//  MHNewsListModelTableViewCell.h
//  MentalHorizonProject
//
//  Created by    on 2020/4/29.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHNewsListModelTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet KKButton *lookBtn;
@property (weak, nonatomic) IBOutlet KKButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageIVew;

+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
