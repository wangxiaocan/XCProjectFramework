//
//  LBaseTableView.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "LBaseTableView.h"

@implementation LBaseTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        if (@available(iOS 11.0, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return self;
}

- (void)addNormalHeaderRefreshing{
    XC_WEAK_SELF(self);
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (weakSelf.lBaseTableViewDelegate && [weakSelf.lBaseTableViewDelegate respondsToSelector:@selector(lBaseTableViewHeaderStartRefreshing:)]) {
            [weakSelf.lBaseTableViewDelegate lBaseTableViewHeaderStartRefreshing:weakSelf];
        }else{
            [weakSelf.mj_header endRefreshing];
        }
    }];
    self.mj_header = header;
}

- (void)addNormalFooterRefreshing{
    XC_WEAK_SELF(self);
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.lBaseTableViewDelegate && [weakSelf.lBaseTableViewDelegate respondsToSelector:@selector(lBaseTableViewFooterStartRefreshing:)]) {
            [weakSelf.lBaseTableViewDelegate lBaseTableViewFooterStartRefreshing:weakSelf];
        }else{
            [weakSelf.lBaseTableViewDelegate lBaseTableViewFooterStartRefreshing:weakSelf];
        }
    }];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"" forState:MJRefreshStatePulling];
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    [footer setTitle:@"" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"" forState:MJRefreshStateWillRefresh];
    self.mj_footer = footer;
}

- (void)endHeaderRefreshing{
    [self.mj_header endRefreshing];
}

- (void)endFooterRefreshing{
    [self.mj_footer endRefreshing];
}

- (void)haveNoMoreData{
    [self.mj_footer endRefreshingWithNoMoreData];
}

@end
