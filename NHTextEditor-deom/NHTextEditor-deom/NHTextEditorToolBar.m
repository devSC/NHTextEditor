//
//  NHTextEditorTool.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorToolBar.h"
#import "NHTextEditorToolBarCell.h"

//utils
#import <Masonry.h>
#import "NHTextEditorHeader.h"

@interface NHTextEditorToolBar ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) NSArray *dataSource;

@end

static NSString *kNHTextEditorToolBarCellIdenfitier = @"kNHTextEditorToolBarCell";

@implementation NHTextEditorToolBar
@synthesize delegate;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.dataSource = [NHTextEditorManager sharedInstance].tools;
        [self addSubview:self.collectionView];
        [self addSubview:self.lineView];
    }
    return self;
}

- (void)updateConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    [super updateConstraints];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NHTextEditorToolBarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kNHTextEditorToolBarCellIdenfitier forIndexPath:indexPath];
    __weak typeof(self) wself = self;
    [cell setData:self.dataSource[indexPath.item] itemTappedBlock:^(NHTextEditorEntity *entity) {
        [wself collectionViewDidSelectedItem:entity indexPath:indexPath];
    } selected:([NHTextEditorManager sharedInstance].defaultIndex == indexPath.item)];
    return cell;
    
}
- (void)collectionViewDidSelectedItem:(NHTextEditorEntity *)entity indexPath:(NSIndexPath *)indexPath {
    //这里, 还要判断是否需要显示颜色
    //判断是否为同一个
    if ([NHTextEditorManager sharedInstance].defaultIndex == indexPath.item) {
        return;
    }
    else {
        if (entity.type == NHTextEditTypeBoldFont ||
            entity.type == NHTextEditTypeNormalFont) {

            NHTextEditorToolBarCell *oldCell = (NHTextEditorToolBarCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:[NHTextEditorManager sharedInstance].defaultIndex inSection:indexPath.section]];
            [oldCell setItemSelected:NO];
            
            NHTextEditorToolBarCell *cell = (NHTextEditorToolBarCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            [cell setItemSelected:YES];
            [NHTextEditorManager sharedInstance].defaultIndex = indexPath.item;
        }
        if ([delegate respondsToSelector:@selector(textEditorToorBarDidSelectedItem:)]) {
            [delegate textEditorToorBarDidSelectedItem:entity];
        }
    }

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (CGRectGetWidth(self.frame) - kNHEditorToolBarHeight * 5 - 20) / 4 ;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(10, kNHEditorToolBarHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(10, kNHEditorToolBarHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kNHEditorToolBarHeight, kNHEditorToolBarHeight);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NHTextEditorToolBarCell class] forCellWithReuseIdentifier:kNHTextEditorToolBarCellIdenfitier];
    }
    return _collectionView;
}
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor lightGrayColor];
    }
    return _lineView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}


@end
