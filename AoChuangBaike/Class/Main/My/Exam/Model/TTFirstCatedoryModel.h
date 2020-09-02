//
//  TTFirstCatedoryModel.h
//  TTAnswer
//
//  Created by GOOUC on 2020/3/23.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import "STBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTFirstCatedoryModel : STBaseModel

@property (nonatomic,copy) NSString *cname;
@property (assign, nonatomic) NSInteger ID;
@property (assign, nonatomic) NSInteger parentid;
@property (nonatomic,copy) NSString *ccc;  // <#name#>
@property (strong, nonatomic) NSMutableArray *secondArray;





@end

NS_ASSUME_NONNULL_END
