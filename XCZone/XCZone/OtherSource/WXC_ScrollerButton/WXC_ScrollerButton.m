//
//  WXC_ScrollerButton.m
//  lzxReader
//
//  Created by 王文科 on 2018/9/17.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "WXC_ScrollerButton.h"
#import "WXC_ScrollerButtonCell.h"

@interface WXC_ScrollerButton()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, assign, readwrite) NSInteger   currentIndex;


@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) UIView                    *bottomLineView;

@property (nonatomic, strong) NSMutableArray            *scrollerButtonTitles;

@end

@implementation WXC_ScrollerButton

- (NSMutableArray *)scrollerButtonTitles{
    if (!_scrollerButtonTitles) {
        self.scrollerButtonTitles = [NSMutableArray arrayWithCapacity:0];
    }
    return _scrollerButtonTitles;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _showTitleBottomLine = YES;
        
        self.backgroundColor = [UIColor whiteColor];
        
        _currentIndex = 0;
        
        _btnNormalCorlor = [UIColor blackColor];
        _btnSelectedColor = [UIColor colorWithRed:38 / 255.0 green:169 / 255.0 blue:225 / 255.0 alpha:1.0];
        
        _btnNormalFont = [UIFont systemFontOfSize:15.0];
        _btnSelectedFont = [UIFont systemFontOfSize:17.0];
        
        if (!_collectionView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
            _collectionView.bounces = NO;
            _collectionView.backgroundColor = [UIColor clearColor];
            _collectionView.showsVerticalScrollIndicator = NO;
            _collectionView.showsHorizontalScrollIndicator = NO;
            _collectionView.dataSource = self;
            _collectionView.delegate = self;
            [_collectionView registerNib:[UINib nibWithNibName:@"WXC_ScrollerButtonCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([WXC_ScrollerButtonCell class])];
            [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collect_header"];
            [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"collect_footer"];
            [self addSubview:_collectionView];
            [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
        
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.clipsToBounds = YES;
        _bottomLineView.backgroundColor = [UIColor colorWithRed:38 / 255.0 green:169 / 255.0 blue:225 / 255.0 alpha:1.0];
        _bottomLineView.layer.cornerRadius = 1.0;
        [_collectionView addSubview:_bottomLineView];
        
    }
    return self;
}


- (instancetype)initWithButtonTitles:(NSArray<NSString *> *)buttonTitles{
    self = [super init];
    if (self) {
        if (buttonTitles) {
            [self.scrollerButtonTitles addObjectsFromArray:buttonTitles];
        }
    }
    return self;
}

- (void)resumeButtonTitles:(NSArray<NSString *> *)buttonTitles{
    @try{
        [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }@catch(NSException *e){
        _collectionView.contentOffset = CGPointZero;
    }
    _currentIndex = 0;
    [self.scrollerButtonTitles removeAllObjects];
    if (buttonTitles) {
        [self.scrollerButtonTitles addObjectsFromArray:buttonTitles];
    }
    [_collectionView reloadData];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake([self getCellWidthAtIndex:indexPath.item], collectionView.bounds.size.height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0.1, collectionView.bounds.size.height);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0.1, collectionView.bounds.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.scrollerButtonTitles.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    NSString *reuseInde = @"collect_header";
    if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        reuseInde = @"collect_footer";
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseInde forIndexPath:indexPath];
    
    return view;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WXC_ScrollerButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([WXC_ScrollerButtonCell class]) forIndexPath:indexPath];
    if (indexPath.item < self.scrollerButtonTitles.count) {
        cell.wxcCellTitleLabel.text = [self.scrollerButtonTitles objectAtIndex:indexPath.item];
    }else{
        cell.wxcCellTitleLabel.text = nil;
    }
    if (_currentIndex == indexPath.item) {
        cell.wxcCellTitleLabel.font = _btnSelectedFont;
        cell.wxcCellTitleLabel.textColor = _btnSelectedColor;
        [self scrollerBottomLine:cell withAnimate:NO];
    }else{
        cell.wxcCellTitleLabel.font = _btnNormalFont;
        cell.wxcCellTitleLabel.textColor = _btnNormalCorlor;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentIndex != indexPath.item) {
        _currentIndex = indexPath.item;
        NSArray *cells = [collectionView visibleCells];
        for (WXC_ScrollerButtonCell *cell in cells) {
            NSIndexPath *cellIndexPath = [collectionView indexPathForCell:cell];
            if (cellIndexPath.item == indexPath.item) {
                cell.wxcCellTitleLabel.font = _btnSelectedFont;
                cell.wxcCellTitleLabel.textColor = _btnSelectedColor;
                [self scrollerBottomLine:cell withAnimate:YES];
            }else{
                cell.wxcCellTitleLabel.font = _btnNormalFont;
                cell.wxcCellTitleLabel.textColor = _btnNormalCorlor;
            }
        }
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        if (self.wxcScrollerButtonDelegate && [self.wxcScrollerButtonDelegate respondsToSelector:@selector(wxc_scrollerButton:didScrollerToIndex:)]) {
            [self.wxcScrollerButtonDelegate wxc_scrollerButton:self didScrollerToIndex:indexPath.item];
        }
    }
}

- (void)scrollerToIndex:(NSInteger)index{
    if (index != _currentIndex && index < self.scrollerButtonTitles.count) {
        _currentIndex = index;
        NSArray *cells = [_collectionView visibleCells];
        for (WXC_ScrollerButtonCell *cell in cells) {
            NSIndexPath *cellIndexPath = [_collectionView indexPathForCell:cell];
            if (cellIndexPath.item == index) {
                cell.wxcCellTitleLabel.font = _btnSelectedFont;
                cell.wxcCellTitleLabel.textColor = _btnSelectedColor;
                [self scrollerBottomLine:cell withAnimate:YES];
            }else{
                cell.wxcCellTitleLabel.font = _btnNormalFont;
                cell.wxcCellTitleLabel.textColor = _btnNormalCorlor;
            }
        }
        @try{
            [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }@catch(NSException *e){
            XC_LOG(@"WXC_ScrollerButton \"- (void)scrollerToIndex:(NSInteger)index\" errored");
        }
    }
}

- (void)scrollerBottomLine:(UICollectionViewCell *)cell withAnimate:(BOOL)animate{
    if (_showTitleBottomLine && animate) {
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.bottomLineView.frame = CGRectMake(cell.frame.origin.x + 10.0, self.bounds.size.height - 2.0, cell.bounds.size.width - 20.0, 2.0);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        _bottomLineView.frame = CGRectMake(cell.frame.origin.x + 10.0, self.bounds.size.height - 2.0, cell.bounds.size.width - 20.0, 2.0);
    }
}
- (CGFloat)getCellWidthAtIndex:(NSInteger)index{
    if (index < self.scrollerButtonTitles.count) {
        NSString *title = [self.scrollerButtonTitles objectAtIndex:index];
        CGRect bounds = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:((index == _currentIndex)?_btnSelectedFont:_btnNormalFont)} context:nil];
        return bounds.size.width + 30;
    }
    return 40.0;
}

- (void)setBtnNormalFont:(UIFont *)btnNormalFont{
    if (btnNormalFont) {
        _btnNormalFont = btnNormalFont;
        [self refreshBtnTitleColorAndFonts];
    }
}

- (void)setBtnSelectedFont:(UIFont *)btnSelectedFont{
    if (btnSelectedFont) {
        _btnSelectedFont = btnSelectedFont;
        [self refreshBtnTitleColorAndFonts];
    }
}

- (void)setBtnNormalCorlor:(UIColor *)btnNormalCorlor{
    if (btnNormalCorlor) {
        _btnNormalCorlor = btnNormalCorlor;
        [self refreshBtnTitleColorAndFonts];
    }
}

- (void)setBtnSelectedColor:(UIColor *)btnSelectedColor{
    if (btnSelectedColor) {
        _btnSelectedColor = btnSelectedColor;
        [self refreshBtnTitleColorAndFonts];
    }
}

- (void)setShowTitleBottomLine:(BOOL)showTitleBottomLine{
    _showTitleBottomLine = showTitleBottomLine;
    _bottomLineView.hidden = !_showTitleBottomLine;
}

- (void)refreshBtnTitleColorAndFonts{
    NSArray *cells = [_collectionView visibleCells];
    for (WXC_ScrollerButtonCell *cell in cells) {
        NSIndexPath *cellIndexPath = [_collectionView indexPathForCell:cell];
        if (cellIndexPath.item == _currentIndex) {
            cell.wxcCellTitleLabel.font = _btnSelectedFont;
            cell.wxcCellTitleLabel.textColor = _btnSelectedColor;
        }else{
            cell.wxcCellTitleLabel.font = _btnNormalFont;
            cell.wxcCellTitleLabel.textColor = _btnNormalCorlor;
        }
    }
}

@end
