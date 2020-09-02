//
//  CCTextCustomTableViewCell.m
//  CunCunTong
//
//  Created by    on 2020/3/31.
//  Copyright © 2020   . All rights reserved.
//

#import "CCTextCustomTableViewCell.h"

@implementation CCTextCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.titleLab.textColor = COLOR_333333;
    self.subTitleLab.textColor = COLOR_666666;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
