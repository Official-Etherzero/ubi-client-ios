//
//  TokenItem.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/23.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TokenItem : NSObject

@property (nonatomic,   copy) NSString *imageUrl;
@property (nonatomic,   copy) NSString *name;
@property (nonatomic,   copy) NSString *code;
//@property (nonatomic,   copy) NSString *price;
@property (nonatomic,   copy) NSString *num;

@end

NS_ASSUME_NONNULL_END
