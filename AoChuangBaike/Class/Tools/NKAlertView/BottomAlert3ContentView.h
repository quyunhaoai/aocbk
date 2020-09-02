//
//  BottomAlert3ContentView.h
//  CunCunTong
//
//  Created by    on 2020/4/3.
//  Copyright © 2020   . All rights reserved.
//

#import "CCBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BottomAlert3ContentView : CCBaseView
/*
 *  <#blockNema#> block
 */
@property (copy, nonatomic) void(^btnClick)(NSString *str);
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (nonatomic,copy) NSString *selectStr;  

@end

NS_ASSUME_NONNULL_END
