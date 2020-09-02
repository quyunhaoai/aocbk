//
//  ZHFilterItemModel.m
//  ZHFilterMenuView
//
//  Created by 周亚楠 on 2019/12/6.
//  Copyright © 2019 Zhou. All rights reserved.
//

#import "ZHFilterItemModel.h"

@implementation ZHFilterItemModel

//归档
- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iva = ivar[i];
        const char *name = ivar_getName(iva);
        NSString *strName = [NSString stringWithUTF8String:name];
        //利用KVC取值
        id value = [self valueForKey:strName];
        [aCoder encodeObject:value forKey:strName];
    }
    free(ivar);
}

//解档
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *strName = [NSString stringWithUTF8String:name];
            //进行解档取值
            id value = [aDecoder decodeObjectForKey:strName];
            //利用KVC对属性赋值
            [self setValue:value forKey:strName];
        }
        free(ivar);
    }
    return self;
}
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
