//
//  CollectionView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/18.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "CollectionView.h"
#import "YYViewHeader.h"

@interface CollectionView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CollectionView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_1a203a;
        self.imageView = [[UIImageView alloc] init];
        [self addSubview:self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(YYSIZE_30);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.size.mas_offset(CGSizeMake(YYSIZE_170, YYSIZE_170));
        }];
        
        YYLabel *contentView = [[YYLabel alloc] initWithFont:FONT_DESIGN_30 textColor:COLOR_3a57d0 text:YYStringWithKey(@"(单张照片支持1M以内)")];
        contentView.textAlignment = NSTextAlignmentCenter;
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.imageView.mas_bottom).offset(YYSIZE_25);
        }];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                          action:@selector(tapImageAction)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)setIcon:(NSString *)icon {
    self.imageView.image = [UIImage imageNamed:icon];
}

- (void)setUrl:(NSString *)url {
    [self.imageView yy_setImageWithURL:[NSURL URLWithString:url] options:YYWebImageOptionUseNSURLCache];
}

- (void)tapImageAction {
    if (self.tapBlock) {
        self.tapBlock();
    }
}


@end
