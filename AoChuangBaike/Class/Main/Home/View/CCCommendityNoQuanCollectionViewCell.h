//
//  CCCommendityNoQuanCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHCommonModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCCommendityNoQuanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIButton *lookBtn;
@property (nonatomic,strong) MHCommonModel *Model;
@end

NS_ASSUME_NONNULL_END
