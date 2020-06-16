//
//  CollectionView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/4/18.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapImageViewBlock)(void);

@interface CollectionView : UIView

@property (nonatomic,  copy) NSString *icon;
@property (nonatomic,  copy) NSString *url;
@property (nonatomic,  copy) TapImageViewBlock tapBlock;


@end

NS_ASSUME_NONNULL_END
