//
//  NHEditorTextView.h
//  NHTextEditor-deom
//
//  Created by Wilson-Yuan on 15/12/1.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHEditorControllerCell.h"

@interface NHEditorTextView : UITextView

@property (weak, nonatomic) NHEditorControllerCell *cell;

@end
