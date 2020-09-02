//
//  CCEverDayTeCollectionViewCell.h
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CCEverDayTeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *sureSales;
@property (weak, nonatomic) IBOutlet UILabel *tittleLab;
@property (weak, nonatomic) IBOutlet UILabel *subTitltLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageview;

@end

NS_ASSUME_NONNULL_END
