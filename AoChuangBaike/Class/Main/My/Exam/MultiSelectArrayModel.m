//
//  MultiSelectArrayModel.m
//  Exam
//
//  Created by 郑敏捷 on 17/2/10.
//  Copyright © 2017年 郑敏捷. All rights reserved.
//

#import "MultiSelectArrayModel.h"

/**
 *  答案:
 *  A = 1 B = 2 AB = 3 C = 4 AC = 5 BC = 6 ABC = 7 D = 8
 *  AD = 9 BD = 10 ABD = 11 CD = 12 ACD = 13 BCD = 14 ABCD = 15
 */

@implementation MultiSelectArrayModel

+ (NSArray *)MultiSelectArray:(NSInteger)AnswerSum {
    
    NSArray *array;
    
    switch (AnswerSum) {
            
        case 0:
            array = @[@"0",@"0",@"0",@"0"];
            break;
        case 1:
            array = @[@"1",@"0",@"0",@"0"];
            break;
        case 2:
            array = @[@"0",@"1",@"0",@"0"];
            break;
        case 3:
            array = @[@"1",@"1",@"0",@"0"];
            break;
        case 4:
            array = @[@"0",@"0",@"1",@"0"];
            break;
        case 5:
            array = @[@"1",@"0",@"1",@"0"];
            break;
        case 6:
            array = @[@"0",@"1",@"1",@"0"];
            break;
        case 7:
            array = @[@"1",@"1",@"1",@"0"];
            break;
        case 8:
            array = @[@"0",@"0",@"0",@"1"];
            break;
        case 9:
            array = @[@"1",@"0",@"0",@"1"];
            break;
        case 10:
            array = @[@"0",@"1",@"0",@"1"];
            break;
        case 11:
            array = @[@"1",@"1",@"0",@"1"];
            break;
        case 12:
            array = @[@"0",@"0",@"1",@"1"];
            break;
        case 13:
            array = @[@"1",@"0",@"1",@"1"];
            break;
        case 14:
            array = @[@"0",@"1",@"1",@"1"];
            break;
        case 15:
            array = @[@"1",@"1",@"1",@"1"];
            break;
            
        default:
            break;
    }
    return array;
}

@end
