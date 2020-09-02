//
//  MHMHNewsListModel.h
//  MentalHorizonProject
//
//  Created by    on 2020/4/29.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MHNewsListModel : BaseModel
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * author;
@property (nonatomic , copy) NSString              * author_pic;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * synopsis;
@property (nonatomic , copy) NSString              * share_title;
@property (nonatomic , copy) NSString              * share_synopsis;
@property (nonatomic , assign) NSInteger              view;
@property (nonatomic , assign) NSInteger              sort;
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , assign) NSInteger              is_best;
@property (nonatomic , assign) NSInteger              is_hot;
@property (nonatomic , assign) NSInteger              reply;
@property (nonatomic , assign) NSInteger              share_num;
@end

NS_ASSUME_NONNULL_END
