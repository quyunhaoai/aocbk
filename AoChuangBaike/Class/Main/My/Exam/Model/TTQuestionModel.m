//
//  TTQuestionModel.m
//  TTAnswer
//
//  Created by GOOUC on 2020/3/27.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "TTQuestionModel.h"

@implementation TTQuestionModel

//- (CGFloat)headViewHeight {
//    //计算html字符串高度
//    NSMutableAttributedString *htmlString =[[NSMutableAttributedString alloc] initWithData:[self.question dataUsingEncoding:NSUTF8StringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute:[NSNumber numberWithInt:NSUTF8StringEncoding]} documentAttributes:NULL error:nil];
//
//    [htmlString addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} range:NSMakeRange(0, htmlString.length)];
//
//    CGSize textSize = [htmlString boundingRectWithSize:(CGSize){Window_W-20-15, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
//
//    return textSize.height+34+20;
//}
- (void)setHeadViewHeight:(CGFloat)headViewHeight {
    _headViewHeight = headViewHeight;
}
///以字典的方式返回.key是咱们写的模型中的属性名,value是我们想要映射的后台给的字段名.
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
//        @"cdescription" : @"description",
        //             //一对多,顺序查找
        @"questID" : @[@"id",@"ID",@"userId"],
    };
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
//             @"cdescription" : @"description",
//             //一对多,顺序查找
             @"questID" : @[@"id",@"ID",@"userId"],
             };
}

@end
