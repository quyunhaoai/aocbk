//
//  MHPactioceModel.m
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "MHPactioceModel.h"
@implementation Answer_all

@end
@implementation MHPactioceModel
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
- (CGFloat)headViewHeight {
    //计算html字符串高度
    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[self.question dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];

    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];

    CGSize textSize = [htmlString boundingRectWithSize:(CGSize){Window_W-20-15, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;

    return textSize.height+20;
}
@end
