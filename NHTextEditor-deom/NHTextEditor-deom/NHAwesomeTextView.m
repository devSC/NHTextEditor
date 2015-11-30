//
//  NHAwesomeTextView.m
//  NHInputView
//
//  Created by Wilson Yuan on 15/11/12.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHAwesomeTextView.h"
#import "NHInternalTextView.h"

@interface NHAwesomeTextView ()<UITextViewDelegate>

@property (strong, nonatomic) UILabel *placeHolderLable;

@property (strong, nonatomic) NHInternalTextView *textView;

@property (nonatomic) UIEdgeInsets placeHolderLabelEdgeInsets;

@end

@implementation NHAwesomeTextView {
    CGFloat _max_height;
    CGFloat _min_height;
    
}
@synthesize placeHolder = _placeHolder;
@synthesize placeHolderTextColor = _placeHolderTextColor;
@synthesize delegate;
//@synthesize keyboardType;
//@synthesize returnKeyType;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self _initial];
        [self _configureSubviews];
        
//        [self test];
    }
    return self;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([delegate respondsToSelector:@selector(awesomeTextViewShouldBeginEditing:)]) {
        return [delegate awesomeTextViewShouldBeginEditing:self];
    }
    else {
        return YES;
    }
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([delegate respondsToSelector:@selector(awesomeTextViewShouldEndEditing:)]) {
        return [delegate awesomeTextViewShouldEndEditing:self];
    }
    else {
        return YES;
    }
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([delegate respondsToSelector:@selector(awesomeTextViewDidBeginEditing:)]) {
        [delegate awesomeTextViewDidBeginEditing:self];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([delegate respondsToSelector:@selector(awesomeTextViewDidEndEditing:)]) {
        [delegate awesomeTextViewDidEndEditing:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([delegate respondsToSelector:@selector(awesomeTextView:shouldChangeTextInRange:replacementText:)]) {
        return [delegate awesomeTextView:self shouldChangeTextInRange:range replacementText:text];
    }
    else {
        return YES;
    }
}
- (void)textViewDidChange:(UITextView *)textView {
    //在这里计算高度
    if ([delegate respondsToSelector:@selector(textViewDidChange:)]) {
        [delegate awesomeTextViewDidChange:self];
    }
    [self _showPlaceHolderTextIfNeed];
    
    //计算高度
    CGSize textSize = [textView sizeThatFits:self.textView.bounds.size];
    
    //比较高度是否到Max height
    if (textSize.height > _max_height) {
        textSize.height = _max_height;
        
        if (!self.textView.scrollEnabled) {
            self.textView.scrollEnabled = YES;
            [self.textView flashScrollIndicators];
        }
        
        [textView scrollRangeToVisible:NSMakeRange(textView.text.length, 1)];
    }
    else {
        [self.textView setScrollEnabled:NO];
    }
    
    if ([delegate respondsToSelector:@selector(awesomeTextView:willChangeHeight:)]) {
        [delegate awesomeTextView:self willChangeHeight:textSize.height];
    }
    
    //这里, 更新INterna text view 的高度
    CGRect rect = self.textView.frame;
    rect.size.height = textSize.height;
    NSLog(@"%@, rect: %@", NSStringFromCGRect(self.textView.frame), NSStringFromCGRect(rect));
    
    if (CGRectGetHeight(self.textView.frame) == CGRectGetHeight(rect)) {
        return;
    }
    [UIView animateWithDuration:self.animationDuration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.textView.frame = rect;
                     } completion:^(BOOL finished) {
                         
                     }];
    
    [self _setTextViewContentOffsetIfNeeds];
    
}


- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([delegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [delegate awesomeTextViewDidChangeSelection:self];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([delegate respondsToSelector:@selector(awesomeTextView:shouldInteractWithURL:inRange:)]) {
        return [delegate awesomeTextView:self shouldInteractWithURL:URL inRange:characterRange];
    }
    else {
        return YES;
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if ([delegate respondsToSelector:@selector(awesomeTextView:shouldInteractWithTextAttachment:inRange:)]) {
        return [delegate awesomeTextView:self shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    else {
        return YES;
    }
    
}
- (void)test {
        self.textView.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.3];
        self.placeHolderLable.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.4];
}

#pragma mark - Override
-(void)layoutSubviews {
    [self _resetSubviewFrameIfNeed];
}

- (void)_resetSubviewFrameIfNeed {
    
    if (CGRectGetMinX(self.placeHolderLable.frame) <= 0) {
        CGRect rect = self.bounds;
        rect.origin.x = self.placeHolderLabelEdgeInsets.left;
        rect.origin.y = self.placeHolderLabelEdgeInsets.top;
        rect.size.width = CGRectGetWidth(rect) - self.placeHolderLabelEdgeInsets.left * 2;
        rect.size.height = CGRectGetHeight(rect) - self.placeHolderLabelEdgeInsets.top * 2;
        
        self.placeHolderLable.frame = rect;
    }
    
    self.textView.frame = self.bounds;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    
}

#pragma mark - Setter

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-property-ivar"
- (void)setMaxNumberOfLine:(NSInteger)maxNumberOfLine {
    //计算
    
    NSString *placeHolderString = @"X"; // for place holder
    for (int i = 0; i < maxNumberOfLine; i ++) {
        placeHolderString = [placeHolderString stringByAppendingString:@"\n |W|"];
    }
    self.textView.hidden = YES;
    self.textView.text = placeHolderString;
    
    CGSize textSize = [self.textView sizeThatFits:self.textView.bounds.size];
    
    _max_height = textSize.height;
    
    self.textView.text = nil;
    self.textView.hidden = NO;
}


- (void)setMinNumberOfLine:(NSInteger)minNumberOfLine {
    NSString *placeHolderString = @"X"; // for place holder
    for (int i = 0; i < minNumberOfLine; i ++) {
        placeHolderString = [placeHolderString stringByAppendingString:placeHolderString];
    }
    self.textView.hidden = YES;
    self.textView.text = placeHolderString;
    
    CGSize textSize = [self.textView sizeThatFits:self.textView.bounds.size];
    
    _min_height = textSize.height;
    
    self.textView.text = nil;
    self.textView.hidden = NO;
    
}

- (void)setKeyboardType:(UIKeyboardType)keyboardType {
    self.textView.keyboardType = keyboardType;
}
- (void)setReturnKeyType:(UIReturnKeyType)returnKeyType {
    self.textView.returnKeyType = returnKeyType;
}
- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    self.textView.textAlignment = textAlignment;
    self.placeHolderLable.textAlignment = textAlignment;
}

- (void)setFont:(UIFont *)font {
    self.textView.font = font;
    self.placeHolderLable.font = font;
}
#pragma clang diagnostic pop


- (void)setText:(NSString *)text {
    self.textView.text = text;
    [self performSelector:@selector(textViewDidChange:) withObject:self.textView];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    if (![_placeHolder isEqualToString:placeHolder]) {
        self.placeHolderLable.text = placeHolder;
        _placeHolder = placeHolder;
    }
}

- (void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor {
    _placeHolderTextColor = placeHolderTextColor;
    
    self.placeHolderLable.textColor = placeHolderTextColor;
}

- (NSString *)text {
    return self.textView.text;
}


- (NSString *)placeHolder {
    return _placeHolder;
}

- (UIColor *)placeHolderTextColor {
    return _placeHolderTextColor;
}

#pragma mark - Public method
- (BOOL)becomeFirstResponder {
    [super becomeFirstResponder];
    return [self.textView becomeFirstResponder];
}
- (BOOL)resignFirstResponder {
    [super resignFirstResponder];
    return [self.textView resignFirstResponder];
}

- (BOOL)isFirstResponder {
    return [self.textView isFirstResponder];
}

- (void)deleteBackward {
    [self.textView deleteBackward];
}
- (BOOL)hasText {
    return [self.textView hasText];
}
- (void)insertText:(NSString *)text {
    [self.textView insertText:text];
}
- (void)scrollRangeToVisible:(NSRange)range {
    [self.textView scrollRangeToVisible:range];
}



#pragma mark - Pravite method
- (void)_setTextViewContentOffsetIfNeeds
{
    CGRect caretRect = [self.textView caretRectForPosition:self.textView.selectedTextRange.end];
//    NSLog(@"%@", NSStringFromCGRect(caretRect));
    CGFloat caretY =  MAX(caretRect.origin.y - self.textView.frame.size.height + caretRect.size.height + self.placeHolderLabelEdgeInsets.top, 0);
//    if (self.textView.contentOffset.y < caretY && caretRect.origin.y != INFINITY)
        [self.textView setContentOffset:CGPointMake(0, caretY) animated:YES];
}

- (void)_showPlaceHolderTextIfNeed {
    if (self.textView.text.length == 0 || [self.textView.text isEqual:[NSNull class]]) {
        self.placeHolderLable.hidden = NO;
    }
    else {
        self.placeHolderLable.hidden = YES;
    }
}
- (void)_initial {
    self.placeHolderLabelEdgeInsets = UIEdgeInsetsMake(8, 5, 0, 0);
    self.animationDuration = 0.2;
}

- (void)_configureSubviews {
    [self addSubview:self.placeHolderLable];
    [self addSubview:self.textView];
}


#pragma mark - Getter
- (NHInternalTextView *)textView {
    if (!_textView) {
        _textView = [[NHInternalTextView alloc] initWithFrame:CGRectZero textContainer:nil];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.delegate = self;
        _textView.autocorrectionType = UITextAutocorrectionTypeNo;
        _textView.backgroundColor = [UIColor clearColor];
        _textView.scrollsToTop = NO;
    }
    return _textView;
}

- (UILabel *)placeHolderLable {
    if (!_placeHolderLable) {
        _placeHolderLable = [[UILabel alloc] initWithFrame:CGRectZero];
        _placeHolderLable.textColor = [UIColor lightGrayColor];
    }
    return _placeHolderLable;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


@end
