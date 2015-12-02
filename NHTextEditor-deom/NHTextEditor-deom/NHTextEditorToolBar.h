//
//  NHTextEditorTool.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHTextEditorManager.h"

@protocol NHTextEditorToolBarDelegate <NSObject>

- (void)textEditorToorBarDidSelectedItem:(NHTextEditorEntity *)item;

@end

@interface NHTextEditorToolBar : UIView

@property (weak, nonatomic) id<NHTextEditorToolBarDelegate> delegate;


@end
