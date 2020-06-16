//
//  MyOrderListView.m
//  UBIClientForiOS
//
//  Created by yang on 2020/4/25.
//  Copyright © 2020 yang123. All rights reserved.
//

#import "MyOrderListView.h"
#import "YYViewHeader.h"
#import "MyOrderDetailCell.h"

@interface MyOrderListView ()
<UITableViewDelegate,
UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyOrderListView

- (instancetype)init {
    if (self = [super init]) {
        self.tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = COLOR_151824;
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.rowHeight = YYSIZE_106;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.bottom.top.mas_equalTo(self);
        }];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.tableView registerClass:[MyOrderDetailCell class]
               forCellReuseIdentifier:[MyOrderDetailCell identifier]];
    }
    return self;
}

- (void)setModels:(NSArray<MyOrderModel *> *)models {
    _models = models;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderDetailCell *cell = [self.tableView dequeueReusableCellWithIdentifier:[MyOrderDetailCell identifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.models[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyOrderModel *model = self.models[indexPath.row];
    if (self.selectedBlock) {
        self.selectedBlock(model);
    }
}


@end
