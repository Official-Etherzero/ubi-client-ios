//
//  YYButton.m
//  ETZClientForiOS
//
//  Created by yang on 2019/10/22.
//  Copyright © 2019 yang123. All rights reserved.
//

#import "YYButton.h"
#import "UIImage+Ext.h"

@implementation YYButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (_stretchLength > 0) {
        CGRect hiteArea = CGRectMake(self.bounds.origin.x - _stretchLength, self.bounds.origin.y - _stretchLength, self.bounds.size.width + _stretchLength * 2, self.bounds.size.height + _stretchLength * 2);
        return CGRectContainsPoint(hiteArea, point);
    }
    if (_hiteFrame.size.width > 0) {
        return CGRectContainsPoint(_hiteFrame, point);
    }
    CGRect hiteArea = CGRectMake(self.bounds.origin.x - _hiteFrame.origin.x, self.bounds.origin.y - _topArea, self.bounds.size.width + _leftArea + _rightArea, self.bounds.size.height + _bottomArea + _topArea);
    return CGRectContainsPoint(hiteArea, point);
}

- (instancetype)initWithFont:(UIFont *)font borderWidth:(float)width borderColoer:(CGColorRef)cgclolor masksToBounds:(BOOL)isBounds title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor cornerRadius:(float)cornerRadius {
    if (self = [super init]) {
        self.titleLabel.font = font;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.layer setBorderWidth:width];
        [self.layer setBorderColor:cgclolor];
        [self.layer setMasksToBounds:isBounds];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage yy_imageWithColor:backgroundColor] forState:UIControlStateNormal];
        [self setBackgroundColor:backgroundColor];
        self.layer.cornerRadius = cornerRadius;
    }
    return self;
}

- (instancetype)initWithFont:(UIFont *)font
                       title:(NSString *)title
                  titleColor:(UIColor *)titleColor {
    if (self = [super init]) {
        self.titleLabel.font = font;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
    }
    return self;
}

@end
