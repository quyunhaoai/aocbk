//
//  CCPersonHeaderView.m
//  CunCunTong
//
//  Created by GOOUC on 2020/3/14.
//  Copyright © 2020 GOOUC. All rights reserved.
//
#import "CCPersonHeaderView.h"
#import "ImageTitleButton.h"
@interface CCPersonHeaderView ()



@end
@implementation CCPersonHeaderView

- (void)setupUI {
    [self addSubview:self.bgImageView];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(184);
        make.top.right.left.mas_equalTo(self);
    }];
    

    
    //Base style for 矩形 3 拷贝 2
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(10, 146, kWidth(355), 84)];
    style.layer.cornerRadius = 10;
    style.layer.backgroundColor = [[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] CGColor];
    style.alpha = 1;
    [[CCTools sharedInstance] addShadowToView:style withColor:KKColor(0, 0, 0, 0.15)];
    [self addSubview:style];
    
    NSArray *arr = @[@"意见反馈",@"在线客服",@"安全设置"];
    NSMutableArray *tolAry = [NSMutableArray new];
    for (int i = 0; i <arr.count; i ++) {
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(0, 0, 0, 0) padding:CGSizeMake(0, 0)];
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_12];
        [button setTitleColor:krgb(51, 51, 51) forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImage:IMAGE_NAME(arr[i]) forState:UIControlStateNormal];
        [button setTag:i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [style addSubview:button];
        [tolAry addObject:button];
    }
    [tolAry mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:24 leadSpacing:20 tailSpacing:20];
    [tolAry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@0).mas_offset(-15);
        make.height.equalTo(@54);
    }];
    self.toaArray = tolAry.copy;
    
}
- (void)buttonClick:(UIButton *)button {
    if (self.click) {
        self.click(button.tag);
    }
}

- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = ({
            UIImageView *view = [UIImageView new];
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.image = [UIImage imageNamed:@"帮助中心背景"];
            view ;
        });
    }
    return _bgImageView;
}






@end
