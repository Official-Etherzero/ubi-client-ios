//
//  LocalServer.h
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LocalServer : NSObject

+ (void)syncPhotoAlbumForAuthorizationCompleteHandler:(void (^)(NSError *error))completeHandler;

+ (void)syncAVCaptureDeviceForAuthorizationCompleteHandler:(void (^)(NSError *error))completeHandler;

+ (void)syncExportLocalResourceWitImage:(UIImage *)image
                        completeHandler:(nullable void (^)(NSError *_Nullable error))completeHandler;


@end

NS_ASSUME_NONNULL_END
