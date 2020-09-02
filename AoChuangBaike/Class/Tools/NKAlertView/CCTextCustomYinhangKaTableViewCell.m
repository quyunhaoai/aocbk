//
//  CCTextCustomYinhangKaTableViewCell.m
//  CunCunTong
//
//  Created by    on 2020/4/3.
//  Copyright © 2020   . All rights reserved.
//

#import "CCTextCustomYinhangKaTableViewCell.h"

@implementation CCTextCustomYinhangKaTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titlelab.textColor = Color_2A2A2A;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected) {
//        self.selectImageView.hidden = NO;
//    } else {
//        self.selectImageView.hidden = YES;
//    }
//    self.highlighted = selected;
//    self.selectImageView.image = selected?IMAGE_NAME(@"形状 2147"):IMAGE_NAME(@"");
    // Configure the view for the selected state
}

@end
