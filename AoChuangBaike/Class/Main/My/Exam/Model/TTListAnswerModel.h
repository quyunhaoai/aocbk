//
//  TTListAnswerModel.h
//  TTAnswer
//
//  Created by GOOUC on 2020/3/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//
/*classifyid  三级分类ID
cname  二级分类名字
description
did  是否已做

fansnum 参与人数

is_can 是否收费

pass_franction

price  价格

ptotal  试卷题数
score  试卷总分

share 试卷分享次数

 title  试卷名字

vip price  会员价格

types   **/

#import "BaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TTListAnswerModel : BaseModel
@property (assign, nonatomic) int fansnum;
@property (nonatomic,copy) NSString *cname;//
@property (nonatomic,copy) NSString *title;
@property (assign, nonatomic) int total;//总题数
@property (nonatomic,assign) double price;
@property (assign, nonatomic) int is_can; //是否收费
@property (assign, nonatomic) int classifyId;    //3级id
@property (assign, nonatomic) double vip_price;
@property (assign, nonatomic) int score;
@property (assign, nonatomic) int did;
@property (assign, nonatomic) double times;
@property (nonatomic,strong) NSString *cdescription;//description
@property (assign, nonatomic) NSInteger PID;    
@end

NS_ASSUME_NONNULL_END
/*
 {
            avscore = "0.00";
            avtimes = 0;
            classifyId = 4;
            cname = "\U516b\U73ed";
            createtime = 1583888942;
            description = "";
            did = 0;
            displayorder = 155;
            fansnum = 4;
            id = 11;
            "is_can" = 1;
            isfull = 0;
            isrepeat = 1;
            level = 1;
            "pass_franction" = "a:9:{s:7:\"start_1\";s:0:\"\";s:5:\"end_1\";s:0:\"\";s:11:\"recommend_1\";s:0:\"\";s:7:\"start_2\";s:0:\"\";s:5:\"end_2\";s:0:\"\";s:11:\"recommend_2\";s:0:\"\";s:7:\"start_3\";s:0:\"\";s:5:\"end_3\";s:0:\"\";s:11:\"recommend_3\";s:0:\"\";}";
            pcate = 6;
            price = "0.00";
            ptotal = 4;
            score = 4;
            share = 0;
            status = 1;
            thumb = "";
            tid = 11;
            times = 0;
            title = "\U6d4b\U8bd588888 ";
            total = 6;
            types =             {
                1 =                 {
                    has = 1;
                    num = 1;
                    "one_score" = 1;
                    "sum_score" = 1;
                };
                2 =                 {
                    has = 1;
                    num = 1;
                    "one_score" = 1;
                    "sum_score" = 1;
                };
                3 =                 {
                    has = 1;
                    num = 1;
                    "one_score" = 1;
                    "sum_score" = 1;
                };
                4 =                 {
                    has = 1;
                    num = 1;
                    "one_score" = 1;
                    "sum_score" = 1;
                };
            };
            viewnum = 4;
            "vip_price" = "0.00";
            weid = 4;
            year = 0;
        },
 **/
