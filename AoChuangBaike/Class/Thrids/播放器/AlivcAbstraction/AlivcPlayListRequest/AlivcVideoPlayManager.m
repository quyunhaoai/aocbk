//
//  AlivcVideoPlayManager.m
//  AliyunVideoClient_Entrance
//
//  Created by 王凯 on 2018/5/21.
//  Copyright © 2018年 Alibaba. All rights reserved.
//

#import "AlivcVideoPlayManager.h"
#import "AlivcAppServer.h"
#import "AlivcSplicingRequestParameter.h"
#import "AlivcVideoPlayListModel.h"
#import "AlivcDefine.h"

static const NSString *defaultUrlString = @"http://player.alicdn.com/video/aliyunmedia.mp4";

@interface AlivcVideoPlayManager()

@end

@implementation AlivcVideoPlayManager





+ (void)requestPlayListWithSucess:(void (^)(NSArray *ary, long total))sucess failure:(void (^)(NSString *))failure {
    
    [self requestPlayListVodPlayWithAccessKeyId:@"" accessSecret:@"" securityToken:@"" cateId:@"" pageNo:1 pageCount:10 sucess:sucess failure:failure];
}


+ (void)requestPlayListVodPlayWithAccessKeyId:(NSString *)accessKeyId accessSecret:(NSString *)accessSecret securityToken:(NSString *)securityToken sucess:(void (^)(NSArray *ary, long total))sucess failure:(void (^)(NSString *))failure{
    [self requestPlayListVodPlayWithAccessKeyId:accessKeyId accessSecret:accessSecret securityToken:securityToken cateId:@"" pageNo:1 pageCount:10 sucess:sucess failure:failure];
}
// 带缩略图的
+ (void)requestPlayListVodPlayWithCateId:(NSString *)cateId sucess:(void (^)(NSArray *, long))sucess failure:(void (^)(NSString *))failure{
    
    NSString * url = [NSString stringWithFormat:@"%@/demo/getVideoList?cateId=%@",kAlivcQuUrlString,cateId];
    
    [AlivcAppServer getWithUrlString:url completionHandler:^(NSString * _Nullable errString, NSDictionary * _Nullable resultDic) {
        
        if (resultDic.count<1) {
            failure(@"返回数据为空");
            return ;
        }
        
        //总视频列表条数
        long total = 0;
        NSMutableArray *tempAry = [NSMutableArray arrayWithCapacity:5];
        
        @autoreleasepool{
            if ([resultDic objectForKey:@"total"]) {
                id tempTotal = [resultDic objectForKey:@"total"];
                if ([tempTotal isKindOfClass:[NSNumber class]]) {
                    total = [tempTotal longValue];
                }else{
                    total = (long)tempTotal;
                }
            }
            
            NSArray *dataAry = [NSArray array];
            if ([[resultDic objectForKey:@"data"] objectForKey:@"videoList"]) {
                id tempAry = [[resultDic objectForKey:@"data"] objectForKey:@"videoList"];
                if ([tempAry isKindOfClass:[NSArray class]]) {
                    dataAry = (NSArray *)tempAry;
                }
            }
            for (int i = 0; i<dataAry.count; i++) {
                NSError *error;
                AlivcVideoPlayListModel *model = [[AlivcVideoPlayListModel alloc]initWithDictionary:dataAry[i] error:&error];
                
                if (!error) {
                    if (model.snapshots) {
                        //确保封面图示第一帧
                        NSArray *imageStrings = model.snapshots[@"Snapshot"];
                        if ([imageStrings isKindOfClass:[NSArray class]]) {
                            NSString *firstUrlString = imageStrings.firstObject;
                            if (firstUrlString) {
                                model.coverURL = firstUrlString;
                            }
                        }
                    }
                    
                    [tempAry addObject:model];
                }
            }
        }
        sucess([tempAry copy],total);
    }];
    
    
}

+ (void)requestPlayListVodPlayWithAccessKeyId:(NSString *)accessKeyId accessSecret:(NSString *)accessSecret securityToken:(NSString *)securityToken cateId:(NSString *)cateId pageNo:(NSInteger)pageNo pageCount:(NSInteger)pageCount sucess:(void (^)(NSArray *, long))sucess failure:(void (^)(NSString *))failure{
    
    AlivcSplicingRequestParameter *paramUrl = [[AlivcSplicingRequestParameter alloc] init];
    NSString *str = [paramUrl appendPlayListWithAccessKeyId:accessKeyId
                                            accessKeySecret:accessSecret
                                              securityToken:securityToken
                                                     cateId:cateId
                                                     pageNo:pageNo
                                                  pageCount:pageCount];
    
    [AlivcAppServer getWithUrlString:str completionHandler:^(NSString * _Nullable errString, NSDictionary * _Nullable resultDic) {
        
        if (resultDic.count<1) {
            failure(@"返回数据为空");
            return ;
        }
        
        //总视频列表条数
        long total = 0;
        NSMutableArray *tempAry = [NSMutableArray arrayWithCapacity:5];
        
        @autoreleasepool{
            if ([resultDic objectForKey:@"Total"]) {
                id tempTotal = [resultDic objectForKey:@"Total"];
                if ([tempTotal isKindOfClass:[NSNumber class]]) {
                    total = [tempTotal longValue];
                }else{
                    total = (long)tempTotal;
                }
            }
            
            NSArray *dataAry = [NSArray array];
            if ([[resultDic objectForKey:@"VideoList"] objectForKey:@"Video"]) {
                id tempAry = [[resultDic objectForKey:@"VideoList"] objectForKey:@"Video"];
                if ([tempAry isKindOfClass:[NSArray class]]) {
                    dataAry = (NSArray *)tempAry;
                }
            }
            for (int i = 0; i<dataAry.count; i++) {
                NSError *error;
                AlivcVideoPlayListModel *model = [[AlivcVideoPlayListModel alloc]initWithDictionary:dataAry[i] error:&error];
                if (!error) {
                    if (model.snapshots) {
                        //确保封面图示第一帧
                        NSArray *imageStrings = model.snapshots[@"Snapshot"];
                        if ([imageStrings isKindOfClass:[NSArray class]]) {
                            NSString *firstUrlString = imageStrings.firstObject;
                            if (firstUrlString) {
                                model.coverURL = firstUrlString;
                            }
                        }
                    }
                    
                    [tempAry addObject:model];
                }
            }
        }
        sucess([tempAry copy],total);
    }];
}


@end
