//
//  STHttpResquest.m
//  StudyOC
//
//  Created by   on 2019/9/9.
//  Copyright © 2019  . All rights reserved.
//

#import "STHttpResquest.h"
@implementation STHttpResquest

+ (instancetype)sharedManager {
    static STHttpResquest *manager = nil;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:kUrl]];
    });
    return manager;
}

+ (instancetype)sharedNetworkToolsWithoutBaseUrl
{
    static STHttpResquest *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSURL *url = [NSURL URLWithString:kUrl];
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        instance = [[self alloc]initWithBaseURL:url sessionConfiguration:config];
        
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                              @"application/json",
                                                              @"text/json",
                                                              @"text/javascript",
                                                              @"text/html", nil];
    });
    return instance;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        [self.requestSerializer setValue:[self currentToken] forHTTPHeaderField:@"Authori-zation"];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:
                                                          @"application/json",
                                                          @"text/plain",
                                                          @"text/javascript",
                                                          @"text/json",
                                                          @"text/html", nil];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestWithMethod:(HTTPMethod)method
                 WithPath:(NSString *)path
               WithParams:(NSDictionary*)params
         WithSuccessBlock:(requestSuccessBlock)success
          WithFailurBlock:(requestFailureBlock)failure
{
    
    XYLog(@"本地保存token--------%@",[self currentToken]);
    /*****本地有token******/
    [self.requestSerializer setValue:[self currentToken] forHTTPHeaderField:@"Authori-zation"];

    NSString *urlstr = [NSString stringWithFormat:@"%@/%@",KBaseLocation,path];
    NSLog(@"params:%@\n Url:%@",params,urlstr);
    [MBManager showLoading];
    switch (method) {
        case GET:{
            urlstr = [CCTools urlStringWithUrl:urlstr param:params];
            NSLog(@"params:%@\n Url:%@",params,urlstr);
            [self GET:urlstr
           parameters:params
             progress:nil
              success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
                [MBManager hideAlert];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
                [MBManager hideAlert];
            }];
            break;
        }
        case POST:{
            [self POST:urlstr
            parameters:params
              progress:nil
               success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
                NSLog(@"JSON: %@", responseObject);
                success(responseObject);
                [MBManager hideAlert];
            } failure:^(NSURLSessionTask *operation, NSError *error) {
                NSLog(@"Error: %@", error);
                failure(error);
                [MBManager hideAlert];
            }];
            break;
        }
        default:
            break;
    }
}
 
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
          callback:(void(^)(NSDictionary *jsonDict, NSError *error))callback {
    if (juhua) {
        [MBManager showLoading];
    } else {
        [MBManager hideAlert];
    }
    if (isToken == NO) {
        /** ******** 暂时这样区分 否则在封装层数过多 可另外商议 ******** */
        [self rootRequestUrl:url params:params showJuHua:juhua callback:^(NSDictionary *jsonDict, NSError *error) {
            callback(jsonDict,error);
        }];
    }else {
        if ([[self currentToken] isNotBlank]) {
            XYLog(@"本地保存token--------%@",[self currentToken]);
            /*****本地有token******/
            [self.requestSerializer setValue:[self currentToken] forHTTPHeaderField:@"Authori-zation"];
            [self rootRequestUrl:url params:params showJuHua:juhua callback:^(NSDictionary *jsonDict, NSError *error) {
                callback(jsonDict,error);
            }];
        }else{
            /******请求接口获得token*******/
        }
    }
}
/******根网络请求*******/
- (void)rootRequestUrl:(NSString *)url params:(id)params showJuHua:(BOOL)juhua callback:(void(^)(NSDictionary *jsonDict, NSError *error))callback {
    [self POST:url
    parameters:params
      progress:nil
       success:^(NSURLSessionTask *task, NSDictionary * responseObject) {
        NSLog(@"JSON: %@", responseObject);
        callback(responseObject,nil);
        [MBManager hideAlert];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        callback(nil,nil);
        [MBManager hideAlert];
    }];
}
/**
 *  获取当前的token
 *
 *  @return token
 */
- (NSString *)currentToken {
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([token isNotBlank]) {
        return [NSString stringWithFormat:@"Bearer %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
    } else {
        return @"";
    }
    
}
#pragma mark - token 处理
/**
 *  处理token
 *
 *  @param token 后台返回的token
 */
- (void)handleToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//- (void)UPLOADIMAGE:(NSString *)URL
//             params:(NSDictionary *)params
//        uploadImage:(UIImage *)image
//            success:(void (^)(id response))success
//            failure:(void (^)(NSError *error))Error
//{
//    NSMutableDictionary *dict = [params mutableCopy];
//    [self POST:URL parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        NSData *imageData = UIImageJPEGRepresentation(image, 0.1);
//        [formData appendPartWithFileData:imageData name:@"img" fileName:@"head.jpg" mimeType:@"image/jpeg"];
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        CGFloat progress = uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
//        [WSProgressHUD showProgress:progress];
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        success(responseObject);
//        [WSProgressHUD dismiss];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        Error(error);
//        [WSProgressHUD dismiss];
//    }];
//}

@end
