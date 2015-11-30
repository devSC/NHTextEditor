//
//  NHInternalTextView.m
//  NHInputView
//
//  Created by Wilson Yuan on 15/11/12.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHInternalTextView.h"

@implementation NHInternalTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer {
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        
    }
    return self;
}
- (void)scrollRangeToVisible:(NSRange)range {
    [super scrollRangeToVisible:range];
}

- (void)setText:(NSString *)text {
    BOOL origialValue = self.scrollEnabled;
    
    [self setScrollEnabled:YES];
    [super setText:text];
    [self setScrollEnabled:origialValue];
}

- (void)setContentOffset:(CGPoint)contentOffset animated:(BOOL)animated {
    //    NSLog(@"contentOffset: %@, self.bounds: %@", NSStringFromCGPoint(contentOffset), NSStringFromCGRect(self.bounds));
    if(self.tracking || self.decelerating){
        //initiated by user...
        
        UIEdgeInsets insets = self.contentInset;
        insets.bottom = 0;
        insets.top = 0;
        self.contentInset = insets;
        
    } else {
        
        float bottomOffset = (self.contentSize.height - self.frame.size.height + self.contentInset.bottom);
        if(contentOffset.y < bottomOffset && self.scrollEnabled){
            UIEdgeInsets insets = self.contentInset;
            insets.bottom = 8;
            insets.top = 0;
            self.contentInset = insets;
        }
    }
    
    // Fix "overscrolling" bug
    if (contentOffset.y > self.contentSize.height - self.frame.size.height && !self.decelerating && !self.tracking && !self.dragging)
        contentOffset = CGPointMake(contentOffset.x, self.contentSize.height - self.frame.size.height);
    
    [super setContentOffset:contentOffset animated:animated];
}


- (void)deleteBackward {
    
    [super deleteBackward];
}
@end
