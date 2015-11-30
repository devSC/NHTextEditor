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

#import <Masonry.h>
//utils


@interface NHEditorControllerCell ()<NHAwesomeTextViewDelegate, YYTextViewDelegate>

@property (strong, nonatomic) YYTextView *textView;

@end

@implementation NHEditorControllerCell {
    CGFloat _currentTextViewHeight;
}
@synthesize delegate;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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

- (void)prepareForReuse {
//    self.textView = nil;
    NSLog(@" %s ", __FUNCTION__);
}
- (void)shouldBeginEditor {
//    if (!self.textView.isFirstResponder) {
        [self.textView becomeFirstResponder];
//    }
    NSLog(@"becomeFirstResponder textView: %@", self.textView);
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    [self.textView setPlaceholderText:placeHolder];
    [self.textView becomeFirstResponder];
}

#pragma mark - YYTextViewDelegate
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (([@"\n" isEqualToString:text])) {
//        [self.textView resignFirstResponder];
        if ([delegate respondsToSelector:@selector(editorControllerCellDidEndEdit)]) {
            [delegate editorControllerCellDidEndEdit];
        }
        return NO;
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(YYTextView *)textView {
    return YES;
}
- (void)textViewDidEndEditing:(YYTextView *)textView {
}

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

- (YYTextView *)textView {
    if (!_textView) {
        _textView = [[YYTextView alloc] init];
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.font = [UIFont systemFontOfSize:15];
    }
    return _textView;
}

@end
