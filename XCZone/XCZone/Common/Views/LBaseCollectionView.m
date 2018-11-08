//
//  LBaseCollectionView.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "LBaseCollectionView.h"

@implementation LBaseCollectionView

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

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
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
        if (weakSelf.lBaseCollectionViewDelegate && [weakSelf.lBaseCollectionViewDelegate respondsToSelector:@selector(lBaseTableViewHeaderStartRefreshing:)]) {
            [weakSelf.lBaseCollectionViewDelegate lBaseCollectionViewHeaderStartRefreshing:weakSelf];
        }else{
            [weakSelf.mj_header endRefreshing];
        }
    }];
    self.mj_header = header;
}

- (void)addNormalFooterRefreshing{
    XC_WEAK_SELF(self);
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (weakSelf.lBaseCollectionViewDelegate && [weakSelf.lBaseCollectionViewDelegate respondsToSelector:@selector(lBaseTableViewFooterStartRefreshing:)]) {
            [weakSelf.lBaseCollectionViewDelegate lBaseCollectionViewFooterStartRefreshing:weakSelf];
        }else{
            [weakSelf.mj_footer endRefreshing];
        }
    }];
    self.mj_footer = footer;
}

- (void)endHeaderRefreshing{
    [self.mj_header endRefreshing];
}

- (void)endFooterRefreshing{
    [self.mj_footer endRefreshing];
}

@end
