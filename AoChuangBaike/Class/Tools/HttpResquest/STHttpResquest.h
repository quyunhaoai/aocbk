//
//  STHttpResquest.h
//  StudyOC
//
//  Created by   on 2019/9/9.
//  Copyright © 2019  . All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN
//请求成功回调block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

//请求失败回调block
typedef void (^requestFailureBlock)(NSError *error);

typedef void (^request400Block)(NSDictionary *dic);
//请求方法define
typedef enum {
    GET,
    POST,
    PUT,
    DELETE,
    HEAD
} HTTPMethod;
@interface STHttpResquest : AFHTTPSessionManager
@property (copy, nonatomic) request400Block request400block;
+ (instancetype)sharedManager;
+ (instancetype)sharedNetworkToolsWithoutBaseUrl;
- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure;

- (void)UPLOADIMAGE:(NSString *)URL
     params:(NSDictionary *)params
uploadImage:(UIImage *)image
    success:(void (^)(id response))success
    failure:(void (^)(NSError *error))Error;

/**
 *  base 请求 请求临时token
 *
 *  @param url url
 *  @param isToken 是否需要token
 *  @param params params
 *  @param juhua 等待
 *  @param callback 返回体
 */
- (void)requestUrl:(NSString *)url
           isToken:(BOOL)isToken
            params:(id)params
         showJuHua:(BOOL)juhua
          callback:(void(^)(NSDictionary *jsonDict, NSError *error))callbackBlock;
@end

NS_ASSUME_NONNULL_END
