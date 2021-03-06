//
//  NHTextEditor.m
//  NHTextEditor-deom
//
//  Created by Wilson-Yuan on 15/12/1.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditor.h"
#import "NHTextEditorCell.h"

#import <Masonry.h>
#import "NHTextEditorToolBar.h"
#import "DAKeyboardControl.h"
#import "NHTextEditorHeader.h"

@interface NHTextEditor ()<UITableViewDataSource, UITableViewDelegate, NHTextEditorCellDelegate, NHTextEditorToolBarDelegate>

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) NHTextEditorToolBar *editorToolBar;

@property (strong, nonatomic) MASConstraint *collectionViewBottomConstraint;

@property (strong, nonatomic) MASConstraint *toolBarBottomConstraint;

@property (strong, nonatomic) NSMutableArray *dataSource;

@property (strong, nonatomic) NSMutableArray *cellHeightSource;

@property (strong, nonatomic) NSIndexPath *firstResponderIndexPath; //记录那个Cell是第一响应者

@end

static NSString *kNHTextEditorCellIdeitifier = @"NHTextEditorCell";

@implementation NHTextEditor

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
    
    
    __weak typeof(self) wself = self;
    [self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
    
    } constraintBasedActionHandler:^(CGRect keyboardFrameInView, BOOL opening, BOOL closing) {
        NSLog(@"%@", NSStringFromCGRect(keyboardFrameInView));
//        if (CGRectGetMaxY(keyboardFrameInView) != (CGRectGetHeight(wself.view.frame) - 64)) {
//            wself.toolBarBottomConstraint.offset = - CGRectGetHeight(keyboardFrameInView);
            wself.toolBarBottomConstraint.offset = - (CGRectGetHeight(self.view.frame) - CGRectGetMinY(keyboardFrameInView));
            [wself.view layoutIfNeeded];
//        }
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NHTextEditorCell *cell = [tableView dequeueReusableCellWithIdentifier:kNHTextEditorCellIdeitifier];
    if (!cell) {
        cell = [[NHTextEditorCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kNHTextEditorCellIdeitifier];
    }
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellHeightSource[indexPath.row] floatValue];
}

#pragma mark - NHTextEditorCellDelegate
- (void)editorCell:(NHTextEditorCell *)cell didChangeText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath {
    self.firstResponderIndexPath = indexPath;
}

- (void)editorCell:(NHTextEditorCell *)cell willChangeHeight:(CGFloat)height {
    
    //找到.
    CGFloat cellHeight = [self.cellHeightSource[cell.indexPath.item] floatValue];
    
    if (cellHeight != height) {
        cellHeight = height;
        [self.cellHeightSource replaceObjectAtIndex:cell.indexPath.item withObject:@(cellHeight)];
    }
    else {
        
    }
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    
    //
    [self.tableView scrollToRowAtIndexPath:self.firstResponderIndexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)editorCellDidEndEdit {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.dataSource.count inSection:0];
    [self.dataSource addObject:@"1"];
    [self.cellHeightSource addObject:@(44)];
    
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    self.firstResponderIndexPath = indexPath;
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    //delay invoke, fix the reuse cell can't became first responder
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NHTextEditorCell *oldCell = (NHTextEditorCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:(indexPath.item - 1) inSection:indexPath.section]];;
        [oldCell shouldResignFirstResponder];
        
        NHTextEditorCell *cell = (NHTextEditorCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell shouldBecomeFirstResponder];
    });
}

- (void)editorCellShouldDeleteCell:(NHTextEditorCell *)cell {
    
    //如果是第一行, 则不能删除
    if (cell.indexPath.item == 0) {
        return;
    }
    NSIndexPath *currentIndexPath = cell.indexPath;
    NSIndexPath *preIndexPath = [NSIndexPath indexPathForItem:(cell.indexPath.item - 1) inSection:0];
    NHTextEditorCell *preCell = (NHTextEditorCell *)[self.tableView cellForRowAtIndexPath:preIndexPath];
    [preCell shouldBecomeFirstResponder];
    
    [self.tableView beginUpdates];
    
    [self.dataSource removeObjectAtIndex:currentIndexPath.item];
    [self.cellHeightSource removeObjectAtIndex:currentIndexPath.item];
    [self.tableView deleteRowsAtIndexPaths:@[currentIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];

}

#pragma mark - NHTextEditorToolBarDelegate
- (void)textEditorToorBarDidSelectedItem:(NHTextEditorEntity *)item {
    if (item.type == NHTextEditTypeEndEdit) {
        [self.view endEditing:YES];
    }
    else if (item.type == NHTextEditTypeImage) {
    
    }
    else if (item.type == NHTextEditTypeVideo) {
    
    }
    else {
        NHTextEditorCell *cell = (NHTextEditorCell *)[self.tableView cellForRowAtIndexPath:self.firstResponderIndexPath];
        //设置样式
        [cell setTextStyle:item];
   
    }
}


#pragma mark - Pravite method
- (void)_initialDataSource {
    [self.dataSource addObject:@""];
    [self.cellHeightSource addObject:@(44)];
    self.firstResponderIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
}

- (void)_configureSubview {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[NHTextEditorCell class] forCellReuseIdentifier:kNHTextEditorCellIdeitifier];
    
    [self.view addSubview:self.editorToolBar];
}

- (void)_configureSubviewConstraint {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        self.collectionViewBottomConstraint = make.bottom.mas_equalTo(self.editorToolBar.mas_top);
    }];
    [self.editorToolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kNHEditorToolBarHeight);
        self.toolBarBottomConstraint = make.bottom.mas_equalTo(self.view);
    }];
    
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


- (NHTextEditorToolBar *)editorToolBar {
    if (!_editorToolBar) {
        _editorToolBar = [[NHTextEditorToolBar alloc] init];
        _editorToolBar.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.2];
        _editorToolBar.delegate = self;
    }
    return _editorToolBar;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)cellHeightSource {
    if (!_cellHeightSource) {
        _cellHeightSource = [NSMutableArray array];
    }
    return _cellHeightSource;
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
