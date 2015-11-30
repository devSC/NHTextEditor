//
//  NHTextEditorController.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorController.h"

//
#import "NHTextEditorToolBar.h"

//utils
#import <Masonry.h>

@interface NHTextEditorController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NHTextEditorToolBar *editorToolBar;

@property (strong, nonatomic) MASConstraint *collectionViewBottomConstraint;
@property (strong, nonatomic) MASConstraint *toolBarBottomConstraint;

@end

static CGFloat kNHEditorToolBarHeight = 49;

@implementation NHTextEditorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self _configureSubview];
    [self _configureSubviewConstraint];
}

- (void)_configureSubview {
    [self.view addSubview:self.collectionView];
    
    [self.view addSubview:self.editorToolBar];
}

- (void)_configureSubviewConstraint {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        self.collectionViewBottomConstraint = make.bottom.mas_equalTo(kNHEditorToolBarHeight);
    }];
    [self.editorToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        self.toolBarBottomConstraint = make.bottom.mas_equalTo(self.view);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (NHTextEditorToolBar *)editorToolBar {
    if (!_editorToolBar) {
        _editorToolBar = [[NHTextEditorToolBar alloc] init];
    }
    return _editorToolBar;
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
