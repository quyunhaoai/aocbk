//
//  CCHeaderCollectionReusableView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/16.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "KKButton.h"
#import "CCHeaderCollectionReusableView.h"

@implementation CCHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];

    self.titleLab.font = [UIFont fontWithName:@"PingFang-SC-Bold" size:18];
    self.titleLab.textColor = Color_2A2A2A;
    [self.moreBtn layoutButtonWithEdgeInsetsStyle:KKButtonEdgeInsetsStyleRight imageTitleSpace:5];
    [self.moreBtn.titleLabel setTextColor:COLOR_999999];
}
#ifdef __IPHONE_11_0
+ (Class)layerClass {
    return [LQLayer class];
}
#endif
@end
#ifdef __IPHONE_11_0
@implementation LQLayer

- (CGFloat) zPosition {
    return 0;
}

@end
#endif
