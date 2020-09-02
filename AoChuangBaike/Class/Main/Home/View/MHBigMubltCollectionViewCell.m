//
//  MHBigMubltCollectionViewCell.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/13.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHBigMubltCollectionViewCell.h"

@implementation MHBigMubltCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setModel:(MHGuoyiFirstPageModl *)model {
    _model = model;

}
- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
//    for (int i= 0; i<_dataArray.count; i++) {
//        MHGuoyiFirstPageModl *model = [MHGuoyiFirstPageModl mj_objectWithKeyValues:_dataArray[i]];
//        switch (i) {
//            case 0:
//            {
//                [self.firstImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
//            }
//                break;
//            case 1:
//            {
//                [self.secondImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
//            }
//                break;
//            case 2:
//            {
//                [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
//            }
//                break;
//            default:
//                break;
//        }
//    }
}
@end
