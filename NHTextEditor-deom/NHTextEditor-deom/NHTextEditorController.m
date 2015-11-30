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
#import "DAKeyboardControl.h"
#import "NHEditorHeader.h"

@interface NHTextEditorController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, NHEditorControllerCellDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NHTextEditorToolBar *editorToolBar;

@property (strong, nonatomic) MASConstraint *collectionViewBottomConstraint;

@property (strong, nonatomic) MASConstraint *toolBarBottomConstraint;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSIndexPath *firstResponderIndexPath; //记录那个Cell是第一响应者

@end

static CGFloat kNHEditorToolBarHeight = 49;
static NSString *NHEditorControllerCellIdenfitier = @"NHEditorControllerCell";

@implementation NHTextEditorController

- (void)dealloc
{
    [self.view removeKeyboardControl];
}
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
    
    
    kWeakSelf
    [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        
    } constraintBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        wself.toolBarBottomConstraint.offset = - CGRectGetHeight(keyboardFrameInView);
        [wself.view layoutIfNeeded];
    }];
}

#pragma mark - 

- (void)editorControllerCellDidEndEdit {
    /*
     插入一个新的Cell
     并且Cell的TextView为第一响应
     */
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataSource.count inSection:0];
    [self.dataSource addObject:@"1"];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
        
    } completion:^(BOOL finished) {
        NSLog(@"插入成功");
        if (finished) {
            self.firstResponderIndexPath = indexPath;
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
            //delay invoke, fix the reuse cell can't became first responder
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                NHEditorControllerCell *oldCell = (NHEditorControllerCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:(indexPath.item - 1) inSection:indexPath.section]];;
                [oldCell shouldResignFirstResponder];

                NHEditorControllerCell *cell = (NHEditorControllerCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
                [cell shouldBecomeFirstResponder];
            });
        }
    }];
    
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
    cell.delegate = self;
    cell.backgroundColor = [UIColor whiteColor];
//    if ([self _cellShouldBeginEditorAtIndexPath:indexPath]) {
//        [cell shouldBecomeFirstResponder];
//    }
    [cell setPlaceHolder:[NSString stringWithFormat:@"section: %ld, item: %ld", indexPath.section, indexPath.row]];
                                                                                                                                                 
    return cell;

}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.view.width, 100);
}



#pragma mark - Pravite method

- (BOOL)_cellShouldBeginEditorAtIndexPath:(NSIndexPath *)indexPath {
    if (self.firstResponderIndexPath.item == indexPath.item &&
        self.firstResponderIndexPath.section == indexPath.section) {
        return YES;
    }
    else {
        return NO;
    }
}


- (void)_initialDataSource {
    [self.dataSource addObject:@""];
    
    self.firstResponderIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
}

- (void)_configureSubview {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[NHEditorControllerCell class] forCellWithReuseIdentifier:NHEditorControllerCellIdenfitier];
    
    [self.view addSubview:self.editorToolBar];
}

- (void)_configureSubviewConstraint {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        self.collectionViewBottomConstraint = make.bottom.mas_equalTo(self.editorToolBar.mas_top);
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
        _editorToolBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
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
