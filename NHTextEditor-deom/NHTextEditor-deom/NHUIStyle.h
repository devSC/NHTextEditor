//
//  NHUIStyle.H
//  Being
//
//  Created by YuanWilson on 15/10/27.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NHStyle [NHUIStyle style]

@interface NHUIStyle : NSObject
/*------------------------- new ---------------------------*/
/**
*  主色
*/
@property (strong, readonly, nonatomic) UIColor *blueColor_32a6ff;

@property (strong, readonly, nonatomic) UIColor *blackColor_000407;
@property (strong, readonly, nonatomic) UIColor *blackColor_484848;


@property (strong, readonly, nonatomic) UIColor *grayColor_999999;
@property (strong, readonly, nonatomic) UIColor *grayColor_9a9a9a;
@property (strong, readonly, nonatomic) UIColor *grayColor_bfbfbf;
@property (strong, readonly, nonatomic) UIColor *grayColor_fafafa;
@property (strong, readonly, nonatomic) UIColor *grayColor_878787;
@property (strong, readonly, nonatomic) UIColor *grayColor_f0f1f3;
@property (strong, readonly, nonatomic) UIColor *grayColor_bebebe;

@property (strong, readonly, nonatomic) UIColor *redColor_ff493e;


/*------------------------- old ---------------------------*/
@property (strong, readonly, nonatomic) UIColor *blueColor_06141e;
@property (strong, readonly, nonatomic) UIColor *blueColor_0a3759;
@property (strong, readonly, nonatomic) UIColor *blueColor_125688;
@property (strong, readonly, nonatomic) UIColor *blueColor_9bb1c8;
@property (strong, readonly, nonatomic) UIColor *blueColor_1b548a;

//Black
@property (strong, readonly, nonatomic) UIColor *blackColor_404040;
//Green
@property (strong, readonly, nonatomic) UIColor *greenColor_3ab714;
//Red
@property (strong, readonly, nonatomic) UIColor *redColor_f12e2e;
@property (strong, readonly, nonatomic) UIColor *redColor_f54b4e;
//Gray
@property (strong, readonly, nonatomic) UIColor *grayColor_e5e5e5;
//white
@property (strong, readonly, nonatomic) UIColor *whiteColor_ffffff;

//new
@property (strong, readonly, nonatomic) UIColor *grayColor_f9f9f9;
@property (strong, readonly, nonatomic) UIColor *grayColor_c8c8c8;
@property (strong, readonly, nonatomic) UIColor *grayColor_000407;
@property (strong, readonly, nonatomic) UIColor *grayColor_e0e0e0;
@property (strong, readonly, nonatomic) UIColor *grayColor_f3f3f5;
@property (strong, readonly, nonatomic) UIColor *grayColor_dadada;
@property (strong, readonly, nonatomic) UIColor *grayColor_d7d7d7;

#pragma mark - Font
@property (strong, readonly, nonatomic) UIFont *font_30; //for emoji
@property (strong, readonly, nonatomic) UIFont *font_26; //for emoji

@property (strong, readonly, nonatomic) UIFont *font_20;
@property (strong, readonly, nonatomic) UIFont *font_bold_20;

@property (strong, readonly, nonatomic) UIFont *font_18;
@property (strong, readonly, nonatomic) UIFont *font_bold_18;

@property (strong, readonly, nonatomic) UIFont *font_17;
@property (strong, readonly, nonatomic) UIFont *font_bold_17;

@property (strong, readonly, nonatomic) UIFont *font_16;

@property (strong, readonly, nonatomic) UIFont *font_15;
@property (strong, readonly, nonatomic) UIFont *font_bold_15;

@property (strong, readonly, nonatomic) UIFont *font_14;
@property (strong, readonly, nonatomic) UIFont *font_bold_14;

@property (strong, readonly, nonatomic) UIFont *font_13;
@property (strong, readonly, nonatomic) UIFont *font_bold_13;

@property (strong, readonly, nonatomic) UIFont *font_12;
@property (strong, readonly, nonatomic) UIFont *font_bold_12;

@property (strong, readonly, nonatomic) UIFont *font_11;
@property (strong, readonly, nonatomic) UIFont *font_bold_11;

@property (strong, readonly, nonatomic) UIFont *font_10;
@property (strong, readonly, nonatomic) UIFont *font_bold_10;

#pragma mark - Referenced
@property (readonly, getter=grayColor_e5e5e5) UIColor *colorSepLine;// 分割线

+ (NHUIStyle *)style;

/**
 *  For you can quickly view a color
 *
 *  @param hexString color for hex string
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (UIFont *)fontWithSize:(CGFloat)size;
+ (UIFont *)boldFontWithSize:(CGFloat)size;
@end
