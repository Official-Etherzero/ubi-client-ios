//
//  YYMyQRCodeController.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/18.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYMyQRCodeController.h"
#import "YYViewHeader.h"
#import "CollectionView.h"
#import "YYInterfaceMacro.h"
#import "YYUserInfoViewModel.h"
#import "YYUserDefaluts.h"
#import "HttpFileConfig.h"
#import "TZImagePickerController.h"
#import "YYUserInfoModel.h"

@interface YYMyQRCodeController ()
<TZImagePickerControllerDelegate>

@property (nonatomic, strong) CollectionView  *wcView;
@property (nonatomic, strong) CollectionView  *alView;
@property (nonatomic, strong) YYUserInfoViewModel  *viewModel;
@property (nonatomic, strong) HttpFileConfig  *config;
@property (nonatomic, strong) YYUserInfoModel *model;

@end

@implementation YYMyQRCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = YYStringWithKey(@"绑定收款账户");
    self.view.backgroundColor = COLOR_151824;
    [self initSubViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initViewModel];
}

- (void)initSubViews {
     WDWeakify(self);
    self.alView = [[CollectionView alloc] init];
    self.alView.icon = @"al_icon";
    [self.view addSubview:self.alView];
    [self.alView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (iOS11) {
            make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(YYSIZE_10);
        } else {
            make.top.mas_equalTo(self.mas_topLayoutGuideBottom).offset(YYSIZE_10);
        }
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_270));
    }];
    self.alView.tapBlock = ^{
        WDStrongify(self);
        if (self.model.Pic2 && self.model.Pic2.length > 0) {
            return ;
        }
         [self pickImageViewName:@"pic2"];
    };
    
    self.wcView = [[CollectionView alloc] init];
    [self.view addSubview:self.wcView];
    self.wcView.icon = @"wc_icon";
    [self.wcView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alView.mas_bottom).offset(YYSIZE_20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_offset(CGSizeMake(YYSIZE_350, YYSIZE_270));
    }];
    self.wcView.tapBlock = ^{
        if (self.model.Pic1 && self.model.Pic1.length > 0) {
            return ;
        }
        WDStrongify(self);
        [self pickImageViewName:@"pic1"];
    };
}

- (void)initViewModel {
    WDWeakify(self);
    [self.viewModel yy_viewModelGetUserInfoWithToken:[YYUserDefaluts yy_getAccessTokeCache] success:^(id  _Nonnull responseObject) {
        if ([responseObject isKindOfClass:[YYUserInfoModel class]]) {
            YYUserInfoModel *info = responseObject;
            self.model = responseObject;
            WDStrongify(self);
            if (info.Pic1 && info.Pic1.length > 0) {
                self.wcView.url = info.Pic1;
            }
            if (info.Pic2 && info.Pic2.length > 0) {
                self.alView.url = info.Pic2;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [YYToastView showCenterWithTitle:error.localizedDescription attachedView:[UIApplication sharedApplication].keyWindow];
    }];
}

- (void)pickImageViewName:(NSString *)name {
    WDWeakify(self);
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    imagePickerVc.sortAscendingByModificationDate = NO;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets,BOOL isSelectOriginalPhoto){
        WDStrongify(self);
        UIImage *image = photos.lastObject;
        HttpFileConfig *config = [[HttpFileConfig alloc] init];
        NSData *imageData = UIImagePNGRepresentation(image);
        config.fileData = imageData;
        config.fileName = @"ubi.png";
        config.name = name;
        config.mimeType = @"image/png";
        [self uploadImageWithConfig:config];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

- (void)uploadImageWithConfig:(HttpFileConfig *)config {
    WDWeakify(self);
    [self.viewModel yy_viewModelUploadFileWithToken:[YYUserDefaluts yy_getAccessTokeCache] fileConfig:config successAndProgress:^(NSProgress * _Nonnull progress) {
    } complete:^(id  _Nonnull dataObj, NSError * _Nonnull error) {
        if (!error) {
            WDStrongify(self);
            [self initViewModel];
        }
    }];
}

#pragma mark - lazy

- (YYUserInfoViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YYUserInfoViewModel alloc] init];
    }
    return _viewModel;
}

@end
