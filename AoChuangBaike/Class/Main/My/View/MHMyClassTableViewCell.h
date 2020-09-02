//
//  MHMyClassTableViewCell.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHMyClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHMyClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet KKButton *startBtn;
@property (weak, nonatomic) IBOutlet KKButton *lianXiBtn;
@property (weak, nonatomic) IBOutlet KKButton *moniBtn;
@property (weak, nonatomic) IBOutlet KKButton *testBtn;
@property (strong,nonatomic) MHMyClassModel *Model;
/*
 *  b block
 */
@property (copy, nonatomic) void(^zhangJieTip)(NSString *title);

@end

NS_ASSUME_NONNULL_END
