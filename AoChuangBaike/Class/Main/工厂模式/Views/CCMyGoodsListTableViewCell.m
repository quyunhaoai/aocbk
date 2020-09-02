
//
//  CCMyGoodsListTableViewCell.m
//  CunCunTong
//
//  Created by    on 2020/4/11.
//  Copyright © 2020   . All rights reserved.
//

#import "CCMyGoodsListTableViewCell.h"

@implementation CCMyGoodsListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    [self.bgView setCornerRadius:5 withShadow:YES withOpacity:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)height {
    return 171;
}
@end
