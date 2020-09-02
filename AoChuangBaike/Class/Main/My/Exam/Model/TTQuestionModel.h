//
//  TTQuestionModel.h
//  TTAnswer
//
//  Created by GOOUC on 2020/3/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//
/*answer: "1"
audio: ""
correctnum: "3"
displayorder: "0"
explain: ""
explain_video: null
fansnum: "4"
id: "210"
img_items: null
isVip: "0"
isimg: "0"
items: null
level: "10"
poolid: "2"
question: "车辆长时间停放时，应选择停车场停车。"
thumb: ""
title: ""
type: "1"
uanswer: "未填写答案"
video: ""
weid: "4"**/
#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTQuestionModel : BaseModel
@property (nonatomic,copy) NSString *answer;  //答案
@property (nonatomic,copy) NSString *type;  // 题目类型 1判断  2单选  3多选  4天空
@property (nonatomic,copy) NSString *question;//题目
@property (nonatomic,copy) NSString *thumb;  // 题目图片
@property (nonatomic,strong) NSArray *items;  // 题目选项
@property (nonatomic,copy) NSString *isimg;  // 是否是图片
@property (assign, nonatomic) CGFloat   headViewHeight;    
@property (nonatomic,copy) NSString *questID;  
@property (nonatomic,copy) NSString *uanswer;  //用户答案
@property (nonatomic,strong) NSMutableArray *myAnswers;
@end

NS_ASSUME_NONNULL_END
/*type  = 1判断  2单选  3多选  4天空

question  题目

thumb 题目图片

audio 题目音频

video   题目视频

answer  题目答案

items  选项

imgitems  图片选项

isimg  是否图片选项**/
