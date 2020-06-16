//
//  YYUBIiCarouselView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/2/17.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "YYUBIiCarouselView.h"
#import "YYViewHeader.h"
#import "YYInterfaceMacro.h"
#import "NSString+Ext.h"
#import "iCarousel.h"
#import "YYUBICardView.h"
#import "YYTradingCardView.h"
#import "YYRobotBalanceCardView.h"

@interface YYUBIiCarouselView ()
<iCarouselDelegate,
iCarouselDataSource>

@property (nonatomic, strong) iCarousel *subCarousel;
@property (nonatomic, strong) NSMutableArray *subViews;
@property (nonatomic, strong) UIView *selectView;
@property (nonatomic, strong) YYRobotBalanceCardView *robotView;
@property (nonatomic, strong) YYUBICardView          *ubiView;
@property (nonatomic, strong) YYTradingCardView      *tradeView;

@end

@implementation YYUBIiCarouselView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = COLOR_151824;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    self.robotView = [[YYRobotBalanceCardView alloc] init];
    self.ubiView = [[YYUBICardView alloc] init];
    self.tradeView = [[YYTradingCardView alloc] init];
    [self.subViews addObject:self.robotView];
    [self.subViews addObject:self.ubiView];
    [self.subViews addObject:self.tradeView];
    [self addSubview:self.subCarousel];
    WDWeakify(self);
    self.ubiView.functionBlock = ^(NSInteger index) {
        WDStrongify(self);
        if (self.block) {
            self.block(index);
        }
    };
}

- (void)setBalance:(NSString *)balance {
    _balance = balance;
    self.ubiView.balance = balance;
}

- (void)setUsdtPrice:(NSString *)usdtPrice {
    _usdtPrice = usdtPrice;
    self.ubiView.usdtPrice = usdtPrice;
}

- (void)setModel:(BlanceModel *)model {
    _model = model;
    self.robotView.balance = [model.UBIOUT doubleValue];
    self.tradeView.model = model;
}

#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.subViews.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view{
    UIView *subView = [self.subViews objectAtIndex:index];
    if (view == nil) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, YYSIZE_284, YYSIZE_175)];
        view.backgroundColor = [UIColor clearColor];
        
        subView.frame = CGRectMake(-8, 0, YYSIZE_300, YYSIZE_175);
        subView.tag = 1000+index;
        [view addSubview:subView];
    }
    return view;
}

#pragma mark - iCarouselDelegate
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    UIView *view = carousel.currentItemView;
    view.backgroundColor = COLOR_151824;
    self.selectView = view;
}

- (void)carouselDidScroll:(iCarousel *)carousel{
    if (self.selectView != carousel.currentItemView) {
        self.selectView.backgroundColor = [UIColor clearColor];
        UIView *view = carousel.currentItemView;
        view.backgroundColor = COLOR_151824;
    }
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    self.selectView = carousel.currentItemView;
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.7f;
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    return CATransform3DTranslate(transform, offset * self.subCarousel.itemWidth * 1.4, 0.0, 0.0);
}

#pragma mark - LazyLoad
- (iCarousel *)subCarousel{
    if (_subCarousel == nil) {
        _subCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, YYSCREEN_WIDTH, YYSIZE_175)];
        _subCarousel.delegate = self;
        _subCarousel.dataSource = self;
        _subCarousel.backgroundColor = COLOR_151824;
        _subCarousel.bounces = NO;
        _subCarousel.pagingEnabled = YES;
        _subCarousel.type = iCarouselTypeCustom;
    }
    return _subCarousel;
}

- (NSMutableArray *)subViews {
    if (!_subViews) {
        _subViews = @[].mutableCopy;
    }
    return _subViews;
}

@end
