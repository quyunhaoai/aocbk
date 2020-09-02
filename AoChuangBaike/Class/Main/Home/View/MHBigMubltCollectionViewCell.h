//
//  MHBigMubltCollectionViewCell.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHGuoyiFirstPageModl.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHBigMubltCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *firstImageView;
@property (weak, nonatomic) IBOutlet UIImageView *secondImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (nonatomic,copy) MHGuoyiFirstPageModl *model;
@property (strong, nonatomic) NSMutableArray *dataArray;   

@end

NS_ASSUME_NONNULL_END
