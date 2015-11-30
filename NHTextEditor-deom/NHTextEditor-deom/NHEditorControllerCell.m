//
//  NHEditorCell.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHEditorControllerCell.h"
#import "NHAwesomeTextView.h"

#import <Masonry.h>
//utils


@interface NHEditorControllerCell ()<NHAwesomeTextViewDelegate>

@property (strong, nonatomic) NHAwesomeTextView *textView;

@end

@implementation NHEditorControllerCell {
    CGFloat _currentTextViewHeight;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _configureSubview];
        [self _configureSubviewConstraint];

    }
    return self;
}

#pragma mark - NHAwesomeTextViewDelegate
- (BOOL)awesomeTextViewShouldBeginEditing:(NHAwesomeTextView *)textView {
    return YES;
}


- (void)awesomeTextViewDidChange:(NHAwesomeTextView *)textView {
    NSLog(@"%@", textView.text);
}
- (void)awesomeTextView:(NHAwesomeTextView *)textView willChangeHeight:(CGFloat)height {
    if (_currentTextViewHeight != height) {
//        if ([self.delegate respondsToSelector:@selector(inputBarDidChangeTheHeight:)]) {
//            [self.delegate inputBarDidChangeTheHeight:height + NHInputBarEdge * 2];
//        }
        _currentTextViewHeight = height;
        NSLog(@"height: %f", height);
    }
}


#pragma mark - Pravite method

- (void)_configureSubview {
    [self.contentView addSubview:self.textView];
    
}

- (void)_configureSubviewConstraint {
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
}



- (NHAwesomeTextView *)textView {
    if (!_textView) {
        _textView = [[NHAwesomeTextView alloc] init];
        _textView.delegate = self;
        _textView.maxNumberOfLine = 4;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.placeHolder = @"start to chat";
    }
    return _textView;
}

@end
