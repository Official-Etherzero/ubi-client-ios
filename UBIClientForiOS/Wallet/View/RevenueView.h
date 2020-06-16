//
//  RevenueView.h
//  UBIClientForiOS
//
//  Created by yang on 2020/2/16.
//  Copyright © 2020 yang123. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RevenueView : UIView

@property (nonatomic,   copy) NSString *content;

- (instancetype)initRevenueViewWithIcon:(NSString *)iconString
                                  title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
