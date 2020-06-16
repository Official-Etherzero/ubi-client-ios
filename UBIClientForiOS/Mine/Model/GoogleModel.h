//
//  GoogleModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/27.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoogleModel : NSObject

@property (nonatomic,   copy) NSString *QRUrl;
@property (nonatomic,   copy) NSString *QRStr;
@property (nonatomic,   copy) NSString *SecretKey;

@end

NS_ASSUME_NONNULL_END
