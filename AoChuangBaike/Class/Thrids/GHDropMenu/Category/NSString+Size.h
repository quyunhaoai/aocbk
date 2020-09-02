//
//  NSString+Size.h
//  Field
//
//  Created by 赵治玮 on 2017/11/9.
//  Copyright © 2017年 赵治玮. All rights reserved.
//  gitHub:https://github.com/shabake/GHDropMenuDemo

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Size)
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

+ (NSString *)reverseString:(NSString *)strSrc;

+ (CGFloat)heightWithLabelSizeToFitContent:(NSString *)content numberOfLines:(NSInteger)line constrainedToWidth:(CGFloat)width;

+ (BOOL)content:(NSString *)content beyondMaxLine:(NSInteger)line constrainedToWidth:(CGFloat)width;
@end
