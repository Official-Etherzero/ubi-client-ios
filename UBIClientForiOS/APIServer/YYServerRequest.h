//
//  YYServerRequest.h
//  ExchangeClientForIOS
//
//  Created by yang on 2019/11/20.
//  Copyright © 2019 alibaba. All rights reserved.
//

#import "YYBaseApiRequest.h"
#import "AFNetworking.h"

// mvvm 动态增加一个 id 属性，实现请求头动态添加

NS_ASSUME_NONNULL_BEGIN

/**
 *  成功的回调
 */
typedef void (^successBlock)(id responseObject);

/**
 *  失败的回调
 */
typedef void (^failureBlock) (NSError *error);

/**
 *  请求响应block
 */
typedef void (^responseBlock)(id dataObj, NSError *error);

/**
 *  监听进度响应block
 */
typedef void (^progressBlock)(NSProgress * progress);


@interface YYServerRequest : YYBaseApiRequest

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

#pragma

/**
 @parm
 */

- (NSURLSessionTask *)yy_getRequsetWithUrlString:(NSString * _Nonnull)path
                                            parm:(NSDictionary * _Nullable)parm
                                         success:(successBlock _Nullable)success
                                         failure:(failureBlock _Nullable)failure;

- (NSURLSessionTask *)yy_postRequsetWithUrlString:(NSString * _Nonnull)path
                                             parm:(NSDictionary * _Nullable)parm
                                          success:(successBlock _Nullable)success
                                          failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
