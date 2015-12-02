//
//  NHEditorCell.h
//  NHTextEditor-deom
//
//  Created by Wilson-Yuan on 15/12/1.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHTextViewProtocol.h"

#import "NHTextEditorEntity.h"

@class NHTextEditorCell;
@protocol NHTextEditorCellDelegate <NSObject>

- (void)editorCellDidEndEdit;
- (void)editorCell:(NHTextEditorCell *)cell willChangeHeight:(CGFloat)height;
- (void)editorCellShouldDeleteCell:(NHTextEditorCell *)cell;
- (void)editorCell:(NHTextEditorCell *)cell didChangeText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@end


@interface NHTextEditorCell : UITableViewCell <NHTextViewProtocol>

@property (strong, nonatomic) NSIndexPath *indexPath;

@property (weak, nonatomic) id<NHTextEditorCellDelegate> delegate;

- (void)setTextStyle:(NHTextEditorEntity *)style;

- (void)setPlaceHolder:(NSString *)placeHolder;

- (void)textViewDidTappedDeleteBackwards;

//Responder
- (void)shouldBecomeFirstResponder;
- (void)shouldResignFirstResponder;


@end
