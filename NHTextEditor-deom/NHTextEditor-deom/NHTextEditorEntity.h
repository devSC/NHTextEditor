//
//  NHTextEditorEntity.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/12/2.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <NSObject+YYModel.h>
#import "NHTextEditorHeader.h"

@interface NHTextEditorValueEntity : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *image;
@property (copy, nonatomic) NSString *value;
@property (copy, nonatomic) NSString *style;

@end

@interface NHTextEditorEntity : NSObject<YYModel>
/*
 @{@"name" : @"字体大小",
 @"image" : @"",
 @"type" : @"0",
 @"value" : @[
 @{@"name" : @"",
 @"value" : @"13"},
 @{@"name" : @"",
 @"value" : @"15"},
 @{@"name" : @"",
 @"size" : @"16"},
 @{@"name" : @"",
 @"size" : @"17",
 @"style" : @"bold"}
 ],
 }
 */

@property (copy, nonatomic) NSString *name;     //名
@property (copy, nonatomic) NSString *image;    //图
@property (copy, nonatomic) NSString *highlightedImage;    //图

@property (copy, nonatomic) NSArray *values;     //值
@property (nonatomic) NHTextEditType type;           //类型
@end
