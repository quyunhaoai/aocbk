//
//  CCEverDayTeTableViewCell.h
//  CunCunTong
//
//  Created by    on 2020/3/17.
//  Copyright © 2020   . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewCell.h"
//#import "MHLiveListModel.h"
#import "MHCommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCEverDayTeTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *rightNumberLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *timelab;

@property (weak, nonatomic) IBOutlet UIView *bgView;

//@property (nonatomic,strong) MHLiveListModel *liveModel;  
@property (strong, nonatomic) MHCommonModel *geanmodel;   
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraints;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConst;
+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
