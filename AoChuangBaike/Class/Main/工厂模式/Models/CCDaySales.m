//
//  CCDaySales.m
//  CunCunTong
//
//  Created by    on 2020/3/31.
//  Copyright © 2020   . All rights reserved.
//

#import "CCDaySales.h"

@implementation CCDaySales

+ (NSDictionary *)replacedKeyFromPropertyName{

// ID和mytext对应的是我们头文件中的属性名称

// id  和 text   对应的是我们数据中的key

    return @{@"mhid": @"id",
             @"mhshort":@"short"};//categoryID

}


+ (NSDictionary *)mj_replacedKeyFromPropertyName{

// ID和mytext对应的是我们头文件中的属性名称

// id  和 text   对应的是我们数据中的key

    return @{@"mhid": @"id",
             @"mhshort":@"short"};//categoryID

}
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    //解决关键字冲突
    if ([propertyName isEqualToString:@"mhid"]) return @"id";
    return [propertyName mj_underlineFromCamel];
}

@end
