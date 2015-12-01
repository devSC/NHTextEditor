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
#import "NHTextEditorManager.h"

@interface NHTextEditorToolBar ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

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
    }
    return self;
}

- (void)updateConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
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
    cell.backgroundColor = [UIColor redColor];
    [cell setCellData:self.dataSource[indexPath.item]];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([delegate respondsToSelector:@selector(textEditorToorBarDidSelectedItem:)]) {
        [delegate textEditorToorBarDidSelectedItem:self.dataSource[indexPath.item]];
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
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
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[NHTextEditorToolBarCell class] forCellWithReuseIdentifier:kNHTextEditorToolBarCellIdenfitier];
    }
    return _collectionView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSArray array];
    }
    return _dataSource;
}


@end
