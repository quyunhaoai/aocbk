//
//  MHCommonModel.h
//  MentalHorizonProject
//
//  Created by    on 2020/4/16.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface Lecturer :NSObject
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * pic;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic,copy) NSString                 *mhshort;
@property (nonatomic,copy) NSString                 *short_title;
@property (nonatomic,copy) NSString                 *short_desc;


@end
@interface MHCommonModel : BaseModel
@property (nonatomic , copy) NSString              * add_time;
@property (nonatomic , copy) NSString              * del_price;
@property (nonatomic , assign) NSInteger              mhid;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , strong) Lecturer              * lecturer;
@property (nonatomic , assign) NSInteger              lecturer_id;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , assign) NSInteger              recommend;
@property (nonatomic , assign) NSInteger              reply_num;
@property (nonatomic , assign) NSInteger              share_num;
@property (nonatomic , copy) NSString              * short_title;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , assign) NSInteger              view;
@property (nonatomic , copy) NSString              * short_content;
@property (nonatomic,copy) NSString                 *main_image;
@property (nonatomic,copy) NSString                 *mhshort;  
@end

NS_ASSUME_NONNULL_END
