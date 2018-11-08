//
//  LBaseTableView.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LBaseTableViewDelegate;

@interface LBaseTableView : UITableView

@property (nonatomic, assign) id<LBaseTableViewDelegate> lBaseTableViewDelegate;

- (void)addNormalHeaderRefreshing;

- (void)addNormalFooterRefreshing;

- (void)endHeaderRefreshing;

- (void)endFooterRefreshing;

- (void)haveNoMoreData;

@end


@protocol LBaseTableViewDelegate <NSObject>

@optional
- (void)lBaseTableViewHeaderStartRefreshing:(LBaseTableView *)tableView;
- (void)lBaseTableViewFooterStartRefreshing:(LBaseTableView *)tableView;

@end

NS_ASSUME_NONNULL_END
