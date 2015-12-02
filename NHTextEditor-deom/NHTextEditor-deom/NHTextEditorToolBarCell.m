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

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *itemButton;

@end

@implementation NHTextEditorToolBarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.contentView);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.titleLabel);
        }];
    }
    return self;
}

- (void)setCellData:(NHTextEditorEntity *)data {
    self.titleLabel.text = data.name;
    NSLog(@"%ld", data.type);
}


#pragma mark - Getter
- (UIImageView *)imageView {

    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UIButton *)itemButton {
    if (!_itemButton) {
        _itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _itemButton.imageView.contentMode = UIViewContentModeCenter;
    }
    return _itemButton;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = NHStyle.font_10;
        _titleLabel.textColor = NHStyle.blackColor_484848;
    }
    return _titleLabel;
}
@end
