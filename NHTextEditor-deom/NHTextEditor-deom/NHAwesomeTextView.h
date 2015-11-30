//
//  NHAwesomeTextView.h
//  NHInputView
//
//  Created by Wilson Yuan on 15/11/12.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NHAwesomeTextView;

@protocol NHAwesomeTextViewDelegate <NSObject>

@optional;
- (BOOL)awesomeTextViewShouldBeginEditing:(NHAwesomeTextView *)textView;

- (BOOL)awesomeTextViewShouldEndEditing:(NHAwesomeTextView *)textView;

- (void)awesomeTextViewDidBeginEditing:(NHAwesomeTextView *)textView;

- (void)awesomeTextViewDidEndEditing:(NHAwesomeTextView *)textView;

- (BOOL)awesomeTextView:(NHAwesomeTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

- (void)awesomeTextViewDidChange:(NHAwesomeTextView *)textView;

- (void)awesomeTextViewDidChangeSelection:(NHAwesomeTextView *)textView;

- (BOOL)awesomeTextView:(NHAwesomeTextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange;

- (BOOL)awesomeTextView:(NHAwesomeTextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange;

- (void)awesomeTextView:(NHAwesomeTextView *)textView willChangeHeight:(CGFloat)height;


@end

@interface NHAwesomeTextView : UIView

@property (weak, nonatomic) id<NHAwesomeTextViewDelegate> delegate;

@property (nonatomic) NSInteger maxNumberOfLine;
@property (nonatomic) NSInteger minNumberOfLine;

/**
 *  change Height AnimationDuration; d
 *  default = 0.2
 */
@property (nonatomic) NSTimeInterval animationDuration;

//

@property(nonatomic,copy) NSString *text;

@property(nonatomic,strong) UIFont *font;

@property(nonatomic,strong) UIColor *textColor;

@property(nonatomic) NSTextAlignment textAlignment;    // default is NSLeftTextAlignment

@property (nonatomic) UIKeyboardType keyboardType;

@property (nonatomic) UIReturnKeyType returnKeyType;

@property (copy, nonatomic) NSString *placeHolder;

@property (strong, nonatomic) UIColor *placeHolderTextColor;

- (BOOL)hasText;
- (void)insertText:(NSString *)text;
- (void)deleteBackward;

- (BOOL)becomeFirstResponder;
- (BOOL)resignFirstResponder;
- (BOOL)isFirstResponder;


@end
