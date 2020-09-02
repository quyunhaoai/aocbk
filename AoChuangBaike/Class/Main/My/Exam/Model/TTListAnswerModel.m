//
//  TTListAnswerModel.m
//  TTAnswer
//
//  Created by GOOUC on 2020/3/24.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "TTListAnswerModel.h"

@implementation TTListAnswerModel


//+ (NSDictionary *)mj_replacedKeyFromPropertyName{
//
//// ID和mytext对应的是我们头文件中的属性名称
//
//// id  和 text   对应的是我们数据中的key
//
//    return @{@"titleStr": @"title",
//             @"ccc":@"cname"};//categoryID
//
//}
///以字典的方式返回.key是咱们写的模型中的属性名,value是我们想要映射的后台给的字段名.
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"cdescription" : @"description",
        //             //一对多,顺序查找
        @"PID" : @[@"id",@"ID",@"userId"],
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"cdescription" : @"description",
//             //一对多,顺序查找
             @"PID" : @[@"id",@"ID",@"userId"],
             };
}

@end
