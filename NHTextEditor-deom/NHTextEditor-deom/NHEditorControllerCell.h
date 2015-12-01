//
//  NHEditorCell.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHTextViewProtocol.h"
@class NHEditorControllerCell;
@protocol NHEditorControllerCellDelegate <NSObject>

- (void)editorControllerCellDidEndEdit;
- (void)editorControllerCell:(NHEditorControllerCell *)cell WillChangeHeight:(CGFloat)height;
- (void)editorControllerCellShouldDeleteCell:(NHEditorControllerCell *)cell;

@end



@interface NHEditorControllerCell : UICollectionViewCell<NHTextViewProtocol>

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) id<NHEditorControllerCellDelegate> delegate;


- (void)textViewDidTappedDeleteBackwards;

- (void)setPlaceHolder:(NSString *)placeHolder;

- (void)shouldBecomeFirstResponder;
- (void)shouldResignFirstResponder;

@end
