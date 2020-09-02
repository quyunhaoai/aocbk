//
//  AppDelegate.h
//  AoChuangBaike
//
//  Created by zhuxichang on 2020/9/1.
//  Copyright © 2020 zhuxichang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong) UIWindow *window; /**< 123 */
@property(nonatomic,assign)BOOL allowRotation;//是否允许转向
+ (AppDelegate *)sharedAppDelegate;
@end

