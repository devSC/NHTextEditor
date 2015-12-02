//
//  NHTextEditorToolBarCell.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorToolBarCell.h"
#import "NHUIStyle.h"
#import <Masonry.h>

@interface NHTextEditorToolBarCell ()

@property (strong, nonatomic) UIButton *itemButton;

@property (copy, nonatomic) ItemTappedBlock tappedBlock;

@property (strong, nonatomic) NHTextEditorEntity *entity;

@end

@implementation NHTextEditorToolBarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.itemButton];
        [self.itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];

    }
    return self;
}

- (void)setData:(NHTextEditorEntity *)data itemTappedBlock:(ItemTappedBlock)tappedBlock selected:(BOOL)select {
    [self.itemButton setImage:[UIImage imageNamed:data.image] forState:UIControlStateNormal];
    [self.itemButton setImage:[UIImage imageNamed:data.highlightedImage] forState:UIControlStateHighlighted];
    [self.itemButton setImage:[UIImage imageNamed:data.highlightedImage] forState:UIControlStateSelected];

    if (select) {
        self.itemButton.selected = YES;
    }
    self.entity = data;
    self.tappedBlock = tappedBlock;
}

- (void)setItemSelected:(BOOL)selected {
    self.itemButton.selected = selected;
}

- (void)setCellData:(NHTextEditorEntity *)data itemTappedBlock:(ItemTappedBlock)tappedBlock {

}

- (void)itemButtonAction {
    if (self.tappedBlock) {
        self.tappedBlock(self.entity);
    }
}

#pragma mark - Getter

- (UIButton *)itemButton {
    if (!_itemButton) {
        _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_itemButton addTarget:self action:@selector(itemButtonAction) forControlEvents:UIControlEventTouchUpInside];
//        _itemButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _itemButton;
}
@end
