//
//  YYTextView+Swizz.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <YYTextView.h>
#import "NHTextViewProtocol.h"

@interface YYTextView (Swizzle)

@property (weak, nonatomic) id<NHTextViewProtocol> editorCell;

@end
