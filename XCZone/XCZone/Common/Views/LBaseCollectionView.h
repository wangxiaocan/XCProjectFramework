//
//  LBaseCollectionView.h
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LBaseCollectionViewDelegate;

@interface LBaseCollectionView : UICollectionView

@property (nonatomic, assign) id<LBaseCollectionViewDelegate> lBaseCollectionViewDelegate;

- (void)addNormalHeaderRefreshing;

- (void)addNormalFooterRefreshing;

- (void)endHeaderRefreshing;

- (void)endFooterRefreshing;

@end


@protocol LBaseCollectionViewDelegate <NSObject>

@optional
- (void)lBaseCollectionViewHeaderStartRefreshing:(LBaseCollectionView *)tableView;
- (void)lBaseCollectionViewFooterStartRefreshing:(LBaseCollectionView *)tableView;

@end

NS_ASSUME_NONNULL_END
