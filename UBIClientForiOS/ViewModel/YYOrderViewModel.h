//
//  YYOrderViewModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYServerRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYOrderViewModel : NSObject

// 求购
- (NSURLSessionTask *)yy_viewModelCreateBuyOrderWithToken:(NSString *)token
                                                 password:(NSString *)password
                                                    count:(float)count
                                                    price:(float)price
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;


// 取消求购
- (NSURLSessionTask *)yy_viewModelCancelBuyOrderWithToken:(NSString *)token
                                                  orderId:(NSString *)orderId
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 锁定订单
- (NSURLSessionTask *)yy_viewModelLockOrderWithToken:(NSString *)token
                                             orderId:(NSString *)orderId
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure;

// 确认出售
- (NSURLSessionTask *)yy_viewModelConfirmSaleWithToken:(NSString *)token
                                               orderId:(NSString *)orderId
                                              password:(NSString *)password
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

// 放弃出售
- (NSURLSessionTask *)yy_viewModelGiveUpSaleWithToken:(NSString *)token
                                              orderId:(NSString *)orderId
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure;

// 查看卖家二维码
- (NSURLSessionTask *)yy_viewModelSeeSalesQRWithToken:(NSString *)token
                                              orderId:(NSString *)orderId
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure;

// 通知卖家，我已完成支付 payType 1 微信，2 支付宝
- (NSURLSessionTask *)yy_viewModelCompleteNoticeWithToken:(NSString *)token
                                                  orderId:(NSString *)orderId
                                                  payType:(NSInteger)payType
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure;

// 卖家最终确认  status 1 成功，2 不成功
- (NSURLSessionTask *)yy_viewModelSalesLastConfirmWithToken:(NSString *)token
                                                    orderId:(NSString *)orderId
                                                     status:(NSInteger)status
                                                   password:(NSString *)password
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure;

// 统计信息
- (NSURLSessionTask *)yy_viewModelGetOrdersInfoWithToken:(NSString *)token
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure;
// 列出求购信息
- (NSURLSessionTask *)yy_viewModelGetListOrdersWithToken:(NSString *)token
                                                    page:(NSInteger)page
                                                pageSize:(NSInteger)pageSize
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure;

// 列出与我相关的订单 1、进行中 2、已完成 3、已取消
- (NSURLSessionTask *)yy_viewModelGetMyOrdersWithToken:(NSString *)token
                                                  type:(NSInteger)type
                                                  page:(NSInteger)page
                                              pageSize:(NSInteger)pageSize
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure;

@end

NS_ASSUME_NONNULL_END
