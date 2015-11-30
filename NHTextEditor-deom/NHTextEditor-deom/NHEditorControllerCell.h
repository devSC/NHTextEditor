//
//  NHEditorCell.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NHEditorControllerCellDelegate <NSObject>

- (void)editorControllerCellDidEndEdit;

@end

@interface NHEditorControllerCell : UICollectionViewCell

@property (weak, nonatomic) id<NHEditorControllerCellDelegate> delegate;

- (void)setPlaceHolder:(NSString *)placeHolder;

- (void)shouldBecomeFirstResponder;
- (void)shouldResignFirstResponder;

@end
