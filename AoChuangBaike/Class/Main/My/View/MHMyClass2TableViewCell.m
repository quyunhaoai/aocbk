
//
//  MHMyClass2TableViewCell.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHMyClass2TableViewCell.h"

@implementation MHMyClass2TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.tightBtn setBackgroundColor:UIColorHex(0xA8D1FF)];
    [self.tightBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    self.tightBtn.layer.cornerRadius = 5;
    self.titlelab.font = FONT_15;
    [[CCTools sharedInstance] addShadowToView:self.bgView withColor:[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:0.27]];
    
    
}
- (void)setModel:(MHMyClassModel *)Model {
    _Model = Model;
    self.titlelab.text = [NSString stringWithFormat:@"%@",Model.name];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
