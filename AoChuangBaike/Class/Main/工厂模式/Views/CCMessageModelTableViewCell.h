//
//  CCMessageModelTableViewCell.h
//  CunCunTong
//
//  Created by    on 2020/4/9.
//  Copyright © 2020   . All rights reserved.
//

#import "BaseTableViewCell.h"
#import "KKButton.h"
#import "CCMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CCMessageModelTableViewCell : BaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *subLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet KKButton *lookDetailBtn;
@property (weak, nonatomic) IBOutlet UIImageView *ICONIMageView;
@property (weak, nonatomic) IBOutlet UILabel *namelab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,strong) CCMessageModel *cellmodel;  

+ (CGFloat )height;
@end

NS_ASSUME_NONNULL_END
