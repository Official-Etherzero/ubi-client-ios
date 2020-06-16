//
//  LocalServer.m
//  ETZClientForiOS
//
//  Created by yang on 2019/9/24.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "LocalServer.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import "YYInterfaceMacro.h"

@implementation LocalServer

+ (void)syncPhotoAlbumForAuthorizationCompleteHandler:(void (^)(NSError *error))completeHandler; {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            if (completeHandler) {
                dispatch_async_main_safe(^{
                    completeHandler([NSError errorWithDomain:@"用户拒绝" code:PHAuthorizationStatusDenied userInfo:nil]);
                });
                return;
            }
        } else {
            dispatch_async_main_safe(^{
                if (completeHandler) {
                    completeHandler(nil);
                }
            });
        }
    }];
}


+ (void)syncAVCaptureDeviceForAuthorizationCompleteHandler:(void (^)(NSError *error))completeHandler {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusDenied) {
            dispatch_async_main_safe(^{
                completeHandler([NSError errorWithDomain:@"用户拒绝" code:PHAuthorizationStatusDenied userInfo:nil]);
            });
        } else {
            dispatch_async_main_safe(^{
                if (completeHandler) {
                    completeHandler(nil);
                }
            });
        }
       
    }
}

+ (void)syncExportLocalResourceWitImage:(UIImage *_Nonnull)image
                        completeHandler:(nullable void (^)(NSError *_Nullable error))completeHandler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusDenied) {
            if (completeHandler) {
                dispatch_async_main_safe(^{
                    completeHandler([NSError errorWithDomain:@"用户拒绝" code:PHAuthorizationStatusDenied userInfo:nil]);
                });
                return;
            }
        }

        NSError *getExportAlumnError;
        PHAssetCollection *evoAlbum = [self getExportAlbum:&getExportAlumnError];
        if (getExportAlumnError) {
            if (completeHandler) {
                dispatch_async_main_safe(^{
                    completeHandler(getExportAlumnError);
                });
            }
        }
        NSError *error;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            PHAssetChangeRequest *request = nil;
            request = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            // Request editing the album.
            PHAssetCollectionChangeRequest *albumChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:evoAlbum];
            // Get a placeholder for the new asset and add it to the album editing request.
            PHObjectPlaceholder *assetPlaceholder = [request placeholderForCreatedAsset];
            [albumChangeRequest addAssets:@[assetPlaceholder]];
        }                                                    error:&error];
        if (error) {
            NSLog(@"export error %@", error);
            if (completeHandler) {
                dispatch_async_main_safe(^{
                    completeHandler(error);
                });
            }
            return;
        }

        if (completeHandler) {
            dispatch_async_main_safe(^{
                completeHandler(nil);
            });
        }
    }];
}

+ (PHAssetCollection *)getExportAlbum:(NSError **)error {


    PHFetchResult *phFetchResult = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    PHAssetCollection *evoAlbum = nil;
    for (PHAssetCollection *_ph in phFetchResult) {
        if ([_ph.localizedTitle isEqualToString:EXPORT_ABLUMN]) {
            evoAlbum = _ph;
            break;
        }
    }

    if (!evoAlbum) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            //添加HUD文件夹
            [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:EXPORT_ABLUMN];
        }                                                    error:error];

        if (*error) {
            return nil;
        }
        phFetchResult = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
        for (PHAssetCollection *_ph in phFetchResult) {
            if ([_ph.localizedTitle isEqualToString:EXPORT_ABLUMN]) {
                evoAlbum = _ph;
                break;
            }
        }
    }
    return evoAlbum;
}



@end
