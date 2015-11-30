//
//  NHTextEditorController.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorController.h"
#import <YYKit.h>
//view
#import "NHTextEditorToolBar.h"
#import "NHEditorControllerCell.h"

//utils
#import <Masonry.h>

@interface NHTextEditorController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NHTextEditorToolBar *editorToolBar;

@property (strong, nonatomic) MASConstraint *collectionViewBottomConstraint;

@property (strong, nonatomic) MASConstraint *toolBarBottomConstraint;

@property (strong, nonatomic) NSMutableArray *dataSource;
@end

static CGFloat kNHEditorToolBarHeight = 49;
static NSString *NHEditorControllerCellIdenfitier = @"NHEditorControllerCell";

@implementation NHTextEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* 开始编辑时, 只有一个Cell, 按下换行键,则相当于换行,->重新插入一个新的Cell,
     * 插入图片相当于插入了一个Cell
     *
     * 在Cell上操作富文本相当于记录某一个Range下的TextAttribuated
     
     */
    
    [self _initialDataSource];
    [self _configureSubview];
    [self _configureSubviewConstraint];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NHEditorControllerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NHEditorControllerCellIdenfitier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.width, 100);
}



#pragma mark - Pravite method
- (void)_initialDataSource {
    [self.dataSource addObject:@""];
}

- (void)_configureSubview {
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[NHEditorControllerCell class] forCellWithReuseIdentifier:NHEditorControllerCellIdenfitier];
    
    [self.view addSubview:self.editorToolBar];
}

- (void)_configureSubviewConstraint {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        self.collectionViewBottomConstraint = make.bottom.mas_equalTo(-kNHEditorToolBarHeight);
    }];
    [self.editorToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kNHEditorToolBarHeight);
        self.toolBarBottomConstraint = make.bottom.mas_equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NHTextEditorToolBar *)editorToolBar {
    if (!_editorToolBar) {
        _editorToolBar = [[NHTextEditorToolBar alloc] init];
    }
    return _editorToolBar;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
