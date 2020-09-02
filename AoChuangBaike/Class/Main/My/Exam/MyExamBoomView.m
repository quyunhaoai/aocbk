//
//  MyExamBoomView.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/10.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MyExamBoomView.h"

#import "Header.h"
#import "ImageTitleButton.h"
//#import "UIButton+RepeatEventInterval.h"
@interface MyExamBoomView ()
@property (assign,nonatomic) NSTimeInterval lastTapTime;
@end

@implementation MyExamBoomView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 51, SCREEN_WIDTH, 51);
        
        [self initView];
        
        self.backgroundColor = kWhiteColor;
        
        [[CCTools sharedInstance] addShadowToView:self withColor:KKColor(157, 157, 157, 0.6)];
    }
    return self;
}

- (void)initView {
    
    NSArray *array = @[@"上一题",@"题卡",@"下一题"];
    NSArray *iconArr = @[@"left-blue-pic",@"menu",@"right-blue-pic"];
    for (int i = 0; i < array.count; i++) {        
        ImageTitleButton *button = [[ImageTitleButton alloc] initWithStyle:EImageTopTitleBottom maggin:UIEdgeInsetsMake(10, 0, 10, 0) padding:CGSizeMake(0, 0)];
        button.frame     = CGRectMake(SCREEN_WIDTH / array.count * i, 0, SCREEN_WIDTH / array.count, self.frame.size.height);
        button.tag       = i + 1;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:FONT_10];
        [button setTitleColor:UIColorHex(0xb8b9da) forState:UIControlStateNormal];
        [button setImage:IMAGE_NAME(iconArr[i]) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button setImageSize:CGSizeMake(15, 15)];
        [self addSubview:button];
    }
}

- (void)buttonAction:(ImageTitleButton *)button {
    //获取当前时间
    NSTimeInterval time = [[NSDate dateWithTimeIntervalSinceNow:0] timeIntervalSince1970];
    //判断当前点击时间与上次点击时间的时间间隔
    if(time - self.lastTapTime > 0.25f) {
        //推迟0.25秒执行单击方法
        [self performSelector:@selector(singleTapAction:) withObject:button afterDelay:0.25f];
    } else {
        //取消执行单击方法
        [NSObject cancelPreviousPerformRequestsWithTarget:self
                                                 selector:@selector(singleTapAction:)
                                                   object: button];
        //执行连击显示爱心的方法
    }
    self.lastTapTime = time;

}

- (void)singleTapAction:(UIButton *)button {
    if (self.subjectBlock) {
        self.subjectBlock(button.tag);
    }
}






@end
