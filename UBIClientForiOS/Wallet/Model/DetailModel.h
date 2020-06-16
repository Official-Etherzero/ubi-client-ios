//
//  DetailModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/2.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailModel : NSObject

@property (nonatomic,   copy) NSString   *Amount;
@property (nonatomic, assign) NSInteger  Inout; // integer,1表示入，2表示出
@property (nonatomic,   copy) NSString   *WriteTime;
@property (nonatomic,   copy) NSString   *Remark;

@end

NS_ASSUME_NONNULL_END
