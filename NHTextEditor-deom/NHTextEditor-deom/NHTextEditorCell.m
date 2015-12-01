//
//  NHEditorCell.m
//  NHTextEditor-deom
//
//  Created by Wilson-Yuan on 15/12/1.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorCell.h"
#import "YYTextView+Swizzle.h"
#import <YYKit.h>

#import "NHUIStyle.h"
#import <Masonry.h>

@interface NHTextEditorCell ()<YYTextViewDelegate>

@property (strong, nonatomic) YYTextView *textView;


@end
#define kPadding 5

@implementation NHTextEditorCell {
    CGFloat _currentTextViewHeight;
}

@synthesize delegate;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [[UIColor cyanColor] colorWithAlphaComponent:0.6];
        [self _configureSubview];
        [self _configureSubviewConstraint];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidTappedDeleteBackwards {
    if (self.textView.text.length == 0) {
        if ([delegate respondsToSelector:@selector(editorCellShouldDeleteCell:)]) {
            [delegate editorCellShouldDeleteCell:self];
        }
    }
    
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
    }
}

- (void)setTextStyle:(NSDictionary *)style {
    /*
     @{@"name" : @"左对齐",
     @"image" : @"",
     @"type" : @"textAligment",
     @"value" : @"NSTextAlimentLeft",
     },
     @{@"name" : @"字体大小",
     @"image" : @"",
     @"type" : @"font",
     @"value" : @[@"font_13",
     @"font_15",
     @"font_bold_17"]
     },
     @{@"name" : @"加引号",
     @"image" : @"",
     @"type" : @"",
     @"value" : @"",
     },
     @{@"name" : @"添加超链接",
     @"image" : @"",
     @"type" : @"link",
     @"value" : @"alertView",
     },
     @{@"name" : @"添加图片",
     @"image" : @"",
     @"type" : @"Action",
     @"value" : @"AddImage",
     */
    
    if ([style[@"name"] isEqualToString:@"左对齐"]) {
        self.textView.textAlignment = NSTextAlignmentRight;
    }
    else if ([style[@"name"] isEqualToString:@"字体大小"]) {
        self.textView.font = NHStyle.font_30;
        //字体调节后,需要调整大小
        [self adaptTextViewHeightIfNeed];
    }
    else if ([style[@"name"] isEqualToString:@"添加图片"]) {
        NSLog(@"添加图片");
    }
}

#pragma mark - YYTextViewDelegate
- (BOOL)textView:(YYTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (([@"\n" isEqualToString:text])) {
        if ([delegate respondsToSelector:@selector(editorCellDidEndEdit)]) {
            [delegate editorCellDidEndEdit];
        }
        return NO;
    }
    return YES;
}
- (void)adaptTextViewHeightIfNeed {
    //计算高度
    CGSize textSize = [self.textView sizeThatFits:self.textView.bounds.size];
    if (_currentTextViewHeight != textSize.height) {
        if ([delegate respondsToSelector:@selector(editorCell:willChangeHeight:)] ) {
            [delegate editorCell:self willChangeHeight:(textSize.height + kPadding * 2)];
        }
        _currentTextViewHeight = textSize.height;
    }
}
- (void)textViewDidChange:(YYTextView *)textView {
    if ([delegate respondsToSelector:@selector(editorCell:didChangeText:atIndexPath:)]) {
        [delegate editorCell:self didChangeText:textView.text atIndexPath:self.indexPath];
    }
    [self adaptTextViewHeightIfNeed];
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
        make.edges.mas_equalTo(UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding));
    }];
}


- (YYTextView *)textView {
    if (!_textView) {
//        CGRect cellFrame = self.contentView.bounds;
//        cellFrame.origin.y += kPadding;
//        cellFrame.size.height -= kPadding * 2;
        _textView = [[YYTextView alloc] init];
//        _textView.frame = cellFrame;
        _textView.delegate = self;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.font = NHStyle.font_20;
        _textView.editorCell = self;
        _textView.scrollEnabled = NO;
//        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _textView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
    }
    return _textView;
}


@end
