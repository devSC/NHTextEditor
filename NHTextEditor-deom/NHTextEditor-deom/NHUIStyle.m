//
//  NHUIStyle.m
//  Being
//
//  Created by YuanWilson on 15/10/27.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import "NHUIStyle.h"
#import "UIColor+Builder.h"
#import <objc/runtime.h>

@implementation NHUIStyle
+ (NHUIStyle *)style {
    static dispatch_once_t onceToken;
    static NHUIStyle *uiStyle;
    dispatch_once(&onceToken, ^{
        uiStyle = [[NHUIStyle alloc] init];
    });
    return uiStyle;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self _initial];
    }
    return self;
}

- (void)_initial {
    
    //get the propertys list
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i ++) {
        
        //get a property
        objc_property_t property = propertys[i];
        const char *propertyName = property_getName(property);
        //get property name
        NSString *propertyNameString = [NSString stringWithUTF8String:propertyName];
        
        //
        Class class;
        id value;
        
        //get the property attribuates list
        unsigned int attribuatedCount = 0;
        objc_property_attribute_t *attribuates = property_copyAttributeList(property, &attribuatedCount);
        for (int j = 0; j < attribuatedCount; j ++) {
            //get the attribuate
            objc_property_attribute_t attribuate = attribuates[j];
            
            //get attribuate name and value string
            NSString *attribuateNameString = [NSString stringWithUTF8String:attribuate.name];
            NSString *attribuateValueString = [NSString stringWithUTF8String:attribuate.value];
            
            //is class type
            if ([attribuateNameString isEqualToString:@"T"]) {
                //Get class type string
                NSString *classTypeString = [attribuateValueString substringWithRange:NSMakeRange(2, attribuateValueString.length - 3)];
                //Save the current class
                class = NSClassFromString(classTypeString);
            }
            // is the value attribuate
            else if ([attribuateNameString isEqualToString:@"V"]) {
                //class is UIColor
                if (class == [UIColor class]) {
                    //Save the color
                    value = [self colorWithAttribuateString:attribuateValueString];
                }
                //class is UIFont
                else if (class == [UIFont class]) {
                    //Save the font
                    value = [self fontWithAttribuateString:attribuateValueString];
                }
                else {
                    NSLog(@"#WARNING----- This property dont supported auto set value: %@ class type: %@",propertyNameString, NSStringFromClass(class));
                }
                
            }
        }
        //save the value
        [self setValue:value forKey:propertyNameString];
    }
}

/**
 *  Reture the color that be from attribuateString containts color info
 *
 *  @param attribuateString color info string eg: color_e399282
 *
 *  @return color
 */
- (UIColor *)colorWithAttribuateString:(NSString *)attribuateString {
    NSArray *strings = [attribuateString componentsSeparatedByString:@"_"];
    UIColor *color;
    if (strings.count == 3) {
        color = [self colorFromHexString:strings.lastObject alpha:1];
    }
    else {
        NSLog(@"WARNING--------- color attribuate string isn't comply with the name regular: %@", attribuateString);
        color = [UIColor blackColor];
    }
    return color;
}

/**
 *  Reture the font that be from attribuateString containts font info
 *
 *  @param attribuateString font regular string eg: font_19
 *
 *  @return font
 */
- (UIFont *)fontWithAttribuateString:(NSString *)attribuateString {
    
    NSArray *strings = [attribuateString componentsSeparatedByString:@"_"];
    NSUInteger fontSize = [strings.lastObject integerValue];
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    
    if (strings.count == 3) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    else if (strings.count == 4) { //maybe is the bold font
        if ([[strings[2] lowercaseString] isEqualToString:@"bold"]) {
            font =  [UIFont boldSystemFontOfSize:fontSize];
        }
        else {
            font = [UIFont fontWithName:strings[2] size:fontSize];
        }
    }
    else if (strings.count == 5){
        //IS Custome Bold
        font = [UIFont fontWithName:[NSString stringWithFormat:@"%@ %@", strings[2], strings[3]] size:fontSize];
    }
    else {
        NSLog(@"#WARNING-----font not supported : %@", attribuateString);
    }
    return font;
}

/**
 *  color convinence init method
 *
 *  @param hexString color hex string
 *  @param alpha     alpha
 *
 *  @return color
 */
- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    
    unsigned rgbValue = 0;
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:alpha];
}


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    return [UIColor colorFromHexString:hexString];
}
/*---------------------------------------
 * Font
 *---------------------------------------*/


+ (UIFont *)fontWithSize:(CGFloat)size {
    return [UIFont systemFontOfSize:size];
}

+ (UIFont *)boldFontWithSize:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:size];
}



@end
