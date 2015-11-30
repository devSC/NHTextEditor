//
//  NHTextEditorManager.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorManager.h"

@implementation NHTextEditorManager
SingletonImplementationWithClass

- (NSArray *)tools {
    return @[
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
                 },
             ];
}
@end
