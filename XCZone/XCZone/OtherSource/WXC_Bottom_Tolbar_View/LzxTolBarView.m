//
//  LzxTolBarView.m
//  LZX_Reader
//
//  Created by 王文科 on 2018/9/19.
//  Copyright © 2018年 xiaocan. All rights reserved.
//

#import "LzxTolBarView.h"



@interface LzxTolBarView()

@property (nonatomic, strong) UIView            *lTopLine;
@property (nonatomic, strong) NSMutableArray    *tolBarButtons;

@end

@implementation LzxTolBarView

- (NSMutableArray *)tolBarButtons{
    if (!_tolBarButtons) {
        self.tolBarButtons = [NSMutableArray arrayWithCapacity:0];
        [_tolBarButtons addObject:@{@"title":@"首页",@"image":@"D_Cn_Home_Gray",@"selected_image":@"D_Cn_Home_Blue",@"type":@"home"}];
        [_tolBarButtons addObject:@{@"title":@"圈子",@"image":@"D_Cn_Category_Gray",@"selected_image":@"D_Cn_Category_Blue",@"type":@"circle"}];
//        [_tolBarButtons addObject:@{@"title":@"书架",@"image":@"D_Cn_BookShelf_Gray",@"selected_image":@"D_Cn_BookShelf_Blue",@"type":@"book_shelf"}];
        [_tolBarButtons addObject:@{@"title":@"我的",@"image":@"D_Cn_Mine_Gray",@"selected_image":@"D_Cn_Mine_Blue",@"type":@"mine"}];
    }
    return _tolBarButtons;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _lTopLine = [[UIView alloc] init];
        _lTopLine.backgroundColor = XC_RGB_COLOR(195, 1.0);
        [self addSubview:_lTopLine];
        [_lTopLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.right.equalTo(self.mas_right);
            make.top.equalTo(self.mas_top);
            make.height.mas_equalTo(1.0);
        }];
        
        UIView              *lastView;
        LzxTolBarButton     *lastBtn;
        for (NSDictionary *tolData in self.tolBarButtons) {
            
            UIView *topView = [[UIView alloc] init];
            topView.hidden = YES;
            [self insertSubview:topView atIndex:0];
            [topView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                if (lastView) {
                    make.width.equalTo(lastView.mas_width);
                }
                if (lastBtn) {
                    make.left.equalTo(lastBtn.mas_right);
                }else{
                    make.left.equalTo(self.mas_left);
                }
            }];
            lastView = topView;
            NSString *title = [tolData objectForKey:@"title"];
            NSString *n_img = [tolData objectForKey:@"image"];
            NSString *s_img = [tolData objectForKey:@"selected_image"];
            NSString *type =  [tolData objectForKey:@"type"];
            LzxTolBarButton *btn = [LzxTolBarButton buttonWithType:UIButtonTypeCustom];
            btn.lzxNormalImage = [UIImage imageNamed:n_img];
            btn.lzxSelectedImage = [[UIImage imageNamed:s_img] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            btn.tag = [self.tolBarButtons indexOfObject:tolData];
            btn.lzxBtnTitleLabel.text = title;
            btn.lzxBtnType = type;
            [self addSubview:btn];
            if (btn.tag == 0) {
                btn.selected = YES;
            }
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top);
                make.height.mas_equalTo(XC_TOOL_CONTENT_HEIGHT);
                make.left.equalTo(lastView.mas_right).offset(5.0);
                if (lastBtn) {
                    make.width.equalTo(lastBtn.mas_width);
                }
            }];
            [btn addTarget:self action:@selector(tolBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            lastBtn = btn;
        }
        UIView *topView = [[UIView alloc] init];
        topView.hidden = YES;
        [self insertSubview:topView atIndex:0];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(lastBtn.mas_right);
            make.top.equalTo(self.mas_top);
            make.right.equalTo(self.mas_right).offset(5.0);
            make.width.equalTo(lastView.mas_width);
        }];
    }
    return self;
}


- (void)moveToTolButton:(nullable NSString *)type{
    if (type && [type isKindOfClass:[NSString class]]) {
        NSArray *allBtns = [self subviews];
        for (LzxTolBarButton *btn in allBtns) {
            if ([btn isKindOfClass:[LzxTolBarButton class]] && [btn.lzxBtnType isEqualToString:type]) {
                [self tolBtnClicked:btn];
            }
        }
    }
}


- (void)tolBtnClicked:(LzxTolBarButton *)sender{
    if (![sender isSelected] && sender.tag < self.tolBarButtons.count) {
        NSArray *allBtns = [self subviews];
        sender.selected = YES;
        for (LzxTolBarButton *btn in allBtns) {
            if ([btn isKindOfClass:[LzxTolBarButton class]]) {
                if (btn != sender) {
                    btn.selected = NO;
                }
            }
        }
        if (self.lzxDelegate && [self.lzxDelegate respondsToSelector:@selector(lzxTolBarView:clickButton:)]) {
            [self.lzxDelegate lzxTolBarView:self clickButton:sender];
        }
    }
}


@end
