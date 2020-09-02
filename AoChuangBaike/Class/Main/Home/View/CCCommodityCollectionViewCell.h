//
//  CCCommodityCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCCommodityCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *personNumberLab;
@property (weak, nonatomic) IBOutlet UIButton *baomingBtn;

@property (weak, nonatomic) IBOutlet KKButton *lookBtn;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;


@end

NS_ASSUME_NONNULL_END
