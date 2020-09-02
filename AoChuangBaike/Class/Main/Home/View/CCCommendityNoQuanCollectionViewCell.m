//
//  CCCommendityNoQuanCollectionViewCell.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "CCCommendityNoQuanCollectionViewCell.h"

@implementation CCCommendityNoQuanCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(0.0, 0.0, 0.0, 0.1)];
    self.titleLab.textColor = Color_2A2A2A;
    self.subLab.textColor = COLOR_999999;
    self.nameLab.textColor = COLOR_666666;
    [self.lookBtn setBackgroundColor:kTipBlueColor];
    self.lookBtn.layer.cornerRadius = 9;
    self.iconImageView.layer.cornerRadius = 8;
    
}
- (void)setModel:(MHCommonModel *)Model {
    _Model = Model;
    self.titleLab.text = _Model.title;
    self.subLab.text = _Model.short_title;
    self.nameLab.text = [NSString stringWithFormat:@"%@",_Model.lecturer.name];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_Model.image]];
}


@end
