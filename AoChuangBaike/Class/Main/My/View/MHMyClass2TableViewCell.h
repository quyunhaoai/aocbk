//
//  MHMyClass2TableViewCell.h
//  MentalHorizonProject
//
//  Created by GOOUC on 2020/4/30.
//  Copyright © 2020 GOOUC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MHMyClassModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface MHMyClass2TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet KKButton *tightBtn;
@property (weak, nonatomic) IBOutlet UILabel *titlelab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (strong,nonatomic) MHMyClassModel *Model;
@end

NS_ASSUME_NONNULL_END
