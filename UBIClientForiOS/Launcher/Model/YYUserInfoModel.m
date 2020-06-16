//
//  YYUserInfoModel.m
//  UBIClientForiOS
//
//  Created by yang on 2020/3/21.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYUserInfoModel.h"

@implementation YYUserInfoModel

- (void)setPic1:(NSString *)Pic1 {
    if (Pic1.length > 0) {
        _Pic1 = [NSString stringWithFormat:@"https://ubi.wanlege.com%@",Pic1];
    }
}

- (void)setPic2:(NSString *)Pic2 {
    if (Pic2.length > 0) {
        _Pic2 = [NSString stringWithFormat:@"https://ubi.wanlege.com%@",Pic2];
    }
}

@end
