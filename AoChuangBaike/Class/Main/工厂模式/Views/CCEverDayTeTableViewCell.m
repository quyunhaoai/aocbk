//
//  CCEverDayTeTableViewCell.m
//  CunCunTong
//
//  Created by    on 2020/3/17.
//  Copyright © 2020   . All rights reserved.
//

#import "CCEverDayTeTableViewCell.h"
#import "CCEverDayTe.h"
@implementation CCEverDayTeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:[UIColor colorWithRed:197/255.0 green:197/255.0 blue:197/255.0 alpha:0.36]];
    self.titlelab.textColor = Color_2A2A2A;
    self.subTitleLab.textColor = COLOR_999999;
    self.nameLab.textColor = COLOR_666666;
    self.timelab.textColor = kTipBlueColor;
    self.rightNumberLab.textColor = COLOR_999999;
    self.iconImageView.layer.cornerRadius = 8;
}
- (void)setGeanmodel:(MHCommonModel *)geanmodel {
    _geanmodel = geanmodel;
    self.titlelab.text = _geanmodel.title;
     self.subTitleLab.text = _geanmodel.mhshort;
    self.nameLab.text = [NSString stringWithFormat:@"%@·%@",_geanmodel.lecturer.name,_geanmodel.lecturer.title];
    self.timelab.text = [NSString stringWithFormat:@"%@学习币",_geanmodel.price];
     self.rightNumberLab.text = [NSString stringWithFormat:@"%ld人已查看",(long)_geanmodel.view];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_geanmodel.lecturer.pic]];
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:kWhiteColor];
    self.topConstraints.constant = 0;
    self.bottomConst.constant = 0;
}
- (void)setModel:(BaseModel *)model {
    CCEverDayTe *ccModel = (CCEverDayTe *)model;
    self.titlelab.text = [NSString stringWithFormat:@"%@ %@",ccModel.lecturer.name,ccModel.title];
    self.subTitleLab.text = ccModel.short_title;
    self.nameLab.text = ccModel.lecturer.name;
    self.timelab.text = [NSString stringWithFormat:@"%ld讲/%@学习币",(long)ccModel.class_num,ccModel.price];
    self.rightNumberLab.text = [NSString stringWithFormat:@"%ld人加入学习",(long)ccModel.buy_num];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:ccModel.lecturer.pic]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 142.f;
}

@end
