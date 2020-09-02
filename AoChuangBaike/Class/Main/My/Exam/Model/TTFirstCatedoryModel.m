//
//  TTFirstCatedoryModel.m
//  TTAnswer
//
//  Created by GOOUC on 2020/3/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "TTFirstCatedoryModel.h"
#import "MJExtension.h"
@implementation TTFirstCatedoryModel

+ (NSDictionary *)replacedKeyFromPropertyName{

// ID和mytext对应的是我们头文件中的属性名称

// id  和 text   对应的是我们数据中的key

    return @{@"ID": @"id",
             @"ccc":@"cname"};//categoryID

}


+ (NSDictionary *)mj_replacedKeyFromPropertyName{

// ID和mytext对应的是我们头文件中的属性名称

// id  和 text   对应的是我们数据中的key

    return @{@"ID": @"id",
             @"ccc":@"cname"};//categoryID

}
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    //解决关键字冲突
    if ([propertyName isEqualToString:@"ID"]) return @"id";
    return [propertyName mj_underlineFromCamel];
}

@end
