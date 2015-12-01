//
//  NHEditorCell.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHEditorControllerCell.h"
#import "NHAwesomeTextView.h"

#import <YYTextView.h>
#import "NHEditorTextView.h"

#import <Masonry.h>

#import "YYTextView+Swizzle.h"

//utils

#define key 1

@interface NHEditorControllerCell ()<NHAwesomeTextViewDelegate, YYTextViewDelegate>

#if key
@property (strong, nonatomic) YYTextView *textView;

#else
//@property (strong, nonatomic) NHAwesomeTextView *textView;
@property (strong, nonatomic) NHEditorTextView *textView;
//@property (strong, nonatomic) NHEditorTextView *textView;
#endif
@end


@implementation NHEditorControllerCell {
    CGFloat _currentTextViewHeight;
}
@synthesize delegate;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self _configureSubview];
        [self _configureSubviewConstraint];

    }
    return self;
}
- (void)shouldBecomeFirstResponder {
        if ([self.textView becomeFirstResponder]) {
            NSLog(@"begin editor");
        }
        else {
            NSLog(@"can't editor");
        }
}
- (void)shouldResignFirstResponder {
    if ([self.textView resignFirstResponder]) {
        NSLog(@"end editor");
    }
    else {
        NSLog(@"can't end editor");
    }}

- (void)shouldBeginEditor {
//    if (!self.textView.isFirstResponder) {
        [self.textView becomeFirstResponder];
//    }
    NSLog(@"becomeFirstResponder textView: %@", self.textView);
}


- (void)textViewDidTappedDeleteBackwards {
    if (self.textView.text.length == 0) {
        if ([delegate respondsToSelector:@selector(editorControllerCellShouldDeleteCell:)]) {
            [delegate editorControllerCellShouldDeleteCell:self];
        }
    }
    
}

- (void)setPlaceHolder:(NSString *)placeHolder {
//    [self.textView setPlaceholderText:placeHolder];
    [self.textView becomeFirstResponder];
}

#pragma mark - YYTextViewDelegate
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (([@"\n" isEqualToString:text])) {
        if ([delegate respondsToSelector:@selector(editorControllerCellDidEndEdit)]) {
            [delegate editorControllerCellDidEndEdit];
        }
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(YYTextView *)textView {
    //计算高度
    CGSize textSize = [textView sizeThatFits:self.textView.bounds.size];
    if (_currentTextViewHeight != textSize.height) {
        NSLog(@"%@", NSStringFromCGSize(textSize));
        if ([delegate respondsToSelector:@selector(editorControllerCell:WillChangeHeight:)] ) {
            [delegate editorControllerCell:self WillChangeHeight:textSize.height];
        }
        _currentTextViewHeight = textSize.height;
    }
}
- (BOOL)textViewShouldEndEditing:(YYTextView *)textView {
    return YES;
}
- (void)textViewDidEndEditing:(YYTextView *)textView {
    
}


- (void)layoutSubviews {
    NSLog(@"%@", NSStringFromCGRect(self.frame));
    
}
#pragma mark - 
- (void)awesomeTextView:(NHAwesomeTextView *)textView willChangeHeight:(CGFloat)height {
    if ([delegate respondsToSelector:@selector(editorControllerCell:WillChangeHeight:)] ) {
        [delegate editorControllerCell:self WillChangeHeight:height];
    }
}
- (BOOL)awesomeTextView:(NHAwesomeTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (([@"\n" isEqualToString:text])) {
        if ([delegate respondsToSelector:@selector(editorControllerCellDidEndEdit)]) {
            [delegate editorControllerCellDidEndEdit];
        }
        return NO;
    }
    return YES;
}

- (BOOL)awesomeTextViewShouldEndEditing:(NHAwesomeTextView *)textView {
    return YES;
}

#pragma mark -

#pragma mark - Pravite method

- (void)_configureSubview {
    [self.contentView addSubview:self.textView];
    [self.textView becomeFirstResponder];
    
}

- (void)_configureSubviewConstraint {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}
#if key
- (YYTextView *)textView {
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.editorCell = self;
    }
    return _textView;
}
#else
//- (NHAwesomeTextView *)textView {
//    if (!_textView) {
//        _textView = [[NHAwesomeTextView alloc] init];
//        _textView.returnKeyType = UIReturnKeyDefault;
//        _textView.font = [UIFont systemFontOfSize:15];
////        _textView.maxNumberOfLine = 10;
//        _textView.delegate = self;
//    }
//    return _textView;
//}
- (NHEditorTextView *)textView {
    if (!_textView) {
        _textView = [[NHEditorTextView alloc] init];
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.delegate = self;
    }
    return _textView;
}

//- (UITextView *)textView {
//    if (!_textView) {
//        _textView = [[UITextView alloc] init];
//        _textView.returnKeyType = UIReturnKeyDefault;
//        _textView.font = [UIFont systemFontOfSize:15];
////        _textView.delegate = self;
//    }
//    return _textView;
//}

#endif

@end
