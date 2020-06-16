//
//  YYOrderViewModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/23.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYOrderViewModel.h"
#import "APIMacro.h"
#import "YYModel.h"
#import "RequestModel.h"
#import "SellerModel.h"
#import "StatisticsModel.h"
#import "PurchaseOrderModel.h"
#import "MyOrderModel.h"

@interface YYOrderViewModel ()

@property (nonatomic, strong) YYServerRequest *apiRequest;

@end

@implementation YYOrderViewModel

// 求购
- (NSURLSessionTask *)yy_viewModelCreateBuyOrderWithToken:(NSString *)token
                                                 password:(NSString *)password
                                                    count:(float)count
                                                    price:(float)price
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:@(count) forKey:@"Count"];
    [dic setValue:@(price) forKey:@"Price"];
    return [self.apiRequest yy_postRequsetWithUrlString:kCreateBuy parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.msg && success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 取消求购
- (NSURLSessionTask *)yy_viewModelCancelBuyOrderWithToken:(NSString *)token
                                                  orderId:(NSString *)orderId
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:kCancelCreate parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.msg && success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 锁定订单
- (NSURLSessionTask *)yy_viewModelLockOrderWithToken:(NSString *)token
                                             orderId:(NSString *)orderId
                                             success:(successBlock _Nullable)success
                                             failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:kOrderLock parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model && success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 确认出售
- (NSURLSessionTask *)yy_viewModelConfirmSaleWithToken:(NSString *)token
                                               orderId:(NSString *)orderId
                                              password:(NSString *)password
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:kConfirmSale parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.msg && success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 放弃出售
- (NSURLSessionTask *)yy_viewModelGiveUpSaleWithToken:(NSString *)token
                                              orderId:(NSString *)orderId
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:kUnConfirmSale parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.msg && success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 查看卖家二维码
- (NSURLSessionTask *)yy_viewModelSeeSalesQRWithToken:(NSString *)token
                                              orderId:(NSString *)orderId
                                              success:(successBlock _Nullable)success
                                              failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:orderId forKey:@"OrderID"];
    return [self.apiRequest yy_postRequsetWithUrlString:kSellQR parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]]) {
            SellerModel *seller = [SellerModel yy_modelWithJSON:model.data];
            if (success) {
                success(seller);
            }
        } else {
            if (model.msg && success) {
                success(model.msg);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 通知卖家，我已完成支付 payType 1 微信，2 支付宝
- (NSURLSessionTask *)yy_viewModelCompleteNoticeWithToken:(NSString *)token
                                                  orderId:(NSString *)orderId
                                                  payType:(NSInteger)payType
                                                  success:(successBlock _Nullable)success
                                                  failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:orderId forKey:@"OrderID"];
    [dic setValue:@(payType) forKey:@"PayType"];
    return [self.apiRequest yy_postRequsetWithUrlString:kCompleteNotice parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.msg && success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 卖家最终确认  status 1 成功，2 不成功
- (NSURLSessionTask *)yy_viewModelSalesLastConfirmWithToken:(NSString *)token
                                                    orderId:(NSString *)orderId
                                                     status:(NSInteger)status
                                                   password:(NSString *)password
                                                    success:(successBlock _Nullable)success
                                                    failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:password forKey:@"Passwd"];
    [dic setValue:orderId forKey:@"OrderID"];
    [dic setValue:@(status) forKey:@"Status"];
    return [self.apiRequest yy_postRequsetWithUrlString:kCompleteSucess parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if (model.msg && success) {
            success(model.msg);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 统计信息
- (NSURLSessionTask *)yy_viewModelGetOrdersInfoWithToken:(NSString *)token
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    return [self.apiRequest yy_postRequsetWithUrlString:kOrderListInfo parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSDictionary class]] && success) {
            StatisticsModel *statistics = [StatisticsModel yy_modelWithJSON:model.data];
            success(statistics);
        } else {
            if (model.msg && success) {
                success(model.msg);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 列出求购信息
- (NSURLSessionTask *)yy_viewModelGetListOrdersWithToken:(NSString *)token
                                                    page:(NSInteger)page
                                                pageSize:(NSInteger)pageSize
                                                 success:(successBlock _Nullable)success
                                                 failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(pageSize) forKey:@"pagesize"];
    return [self.apiRequest yy_postRequsetWithUrlString:kListOrders parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]] && success) {
            NSMutableArray *list = @[].mutableCopy;
            for (id obj in model.data) {
                PurchaseOrderModel *order = [PurchaseOrderModel yy_modelWithJSON:obj];
                [list addObject:order];
            }
            success(list);
        } else {
            if (model.msg && success) {
                success(model.msg);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 列出与我相关的订单 1、进行中 2、已完成 3、已取消
- (NSURLSessionTask *)yy_viewModelGetMyOrdersWithToken:(NSString *)token
                                                  type:(NSInteger)type
                                                  page:(NSInteger)page
                                              pageSize:(NSInteger)pageSize
                                               success:(successBlock _Nullable)success
                                               failure:(failureBlock _Nullable)failure {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:token forKey:@"Access_Token"];
    [dic setValue:@(type) forKey:@"Type"];
    [dic setValue:@(page) forKey:@"page"];
    [dic setValue:@(pageSize) forKey:@"pagesize"];
    return [self.apiRequest yy_postRequsetWithUrlString:kMyOrders parm:dic success:^(id responseObject) {
        NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        RequestModel *model = [RequestModel yy_modelWithJSON:jsonString];
        if ([model.data isKindOfClass:[NSArray class]]) {
            NSMutableArray *list = @[].mutableCopy;
            for (id obj in model.data) {
                MyOrderModel *order = [MyOrderModel yy_modelWithJSON:obj];
                [list addObject:order];
            }
            success(list);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

#pragma mark - lazy

- (YYServerRequest *)apiRequest {
    if (!_apiRequest) {
        _apiRequest = [[YYServerRequest alloc] init];
    }
    return _apiRequest;
}

@end
