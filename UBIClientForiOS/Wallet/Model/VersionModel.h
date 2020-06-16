//
//  VersionModel.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/14.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VersionModel : NSObject

@property (nonatomic,   copy) NSString  *IOSVer;
@property (nonatomic,   copy) NSString  *IOSURL;
@property (nonatomic,   copy) NSString  *Describe;

@end

NS_ASSUME_NONNULL_END
