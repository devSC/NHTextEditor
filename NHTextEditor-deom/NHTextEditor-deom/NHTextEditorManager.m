//
//  NHTextEditorManager.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "NHTextEditorManager.h"

@interface NHTextEditorManager ()

@property (nonatomic) NSInteger fontIndex;  //记录当前Font valus的index值 default = 0

@end

@implementation NHTextEditorManager
SingletonImplementationWithClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fontIndex = 0;
        _defaultIndex = 0;
    }
    return self;
}


- (UIFont *)fontForEditorEntity:(NHTextEditorEntity *)entity {
    //拿到当前Values
    //如果index == values.count 则取第一个
    
    NHTextEditorValueEntity *valueEntity = entity.value;
    //拼值
    if (!valueEntity.value) {
        valueEntity.value = @"15"; //默认值
    }
    
    if (valueEntity.style) {
//        if (valueEntity.name) {
//            return [UIFont fontWithName:[NSString stringWithFormat:@"%@ %@", valueEntity.name, valueEntity.style] size:[valueEntity.value floatValue]];
//        }
        //默认为系统字体
        return [UIFont boldSystemFontOfSize:[valueEntity.value floatValue]];
    }
    else {
        return [UIFont systemFontOfSize:[valueEntity.value floatValue]];
    }
}

/*
- (UIFont *)fontForEditorEntity:(NHTextEditorEntity *)entity {
    //拿到当前Values
    NSArray *values = entity.values;
    //如果index == values.count 则取第一个
    if (_fontIndex == values.count) {
        _fontIndex = 0;
        
    }
    else {
        _fontIndex +=1;
    }
    
    NHTextEditorValueEntity *valueEntity = values[_fontIndex];
    //拼值
    if (!valueEntity.value) {
        valueEntity.value = @"15"; //默认值
    }
    
    if (valueEntity.style) {
        if (valueEntity.name) {
            return [UIFont fontWithName:[NSString stringWithFormat:@"%@ %@", valueEntity.name, valueEntity.style] size:[valueEntity.value floatValue]];
        }
        //默认为系统字体
        return [UIFont boldSystemFontOfSize:[valueEntity.value floatValue]];
    }
    else {
        return [UIFont systemFontOfSize:[valueEntity.value floatValue]];
    }
}
*/

- (NSArray *)tools {
    /*
     NHTextEditTypeFont = 0,     //改变字体大小
     NHTextEditTypeOrder,        //前面加序列
     NHTextEditTypeLink,         //超链接
     NHTextEditTypeSeperate,     //分割线
     NHTextEditTypeCall,         //@某人
     NHTextEditTypeImage,        //插入图
     NHTextEditTypeVideo,        //插入视频
     */
    NSArray *entityArray = [NSArray modelArrayWithClass:[NHTextEditorEntity class] json:[self _initialTools]];
    return entityArray;
}

- (NSArray *)_initialTools {
    return @[
             @{@"name" : @"正常字体",
               @"image" : @"ic_editor_toolbar_normal",
               @"highlightedImage" : @"ic_editor_toolbar_normal_highlighted",
               @"type" : @"1",
               @"value" : @{@"name" : @"15",
                            @"value" : @"15"},
               },
             @{@"name" : @"加粗字体",
               @"image" : @"ic_editor_toolbar_bold",
               @"highlightedImage" : @"ic_editor_toolbar_bold_selected",
               @"type" : @"2",
               @"value" : @{@"name" : @"",
                            @"value" : @"15",
                            @"style" : @"bold"},
               },
             @{@"name" : @"结束编辑",
               @"image" : @"ic_editor_toolbar_endEditor",
               @"highlightedImage" : @"ic_editor_toolbar_endEditor_highlighted",
               @"type" : @"0",
               @"value" : @"",
               },
             @{@"name" : @"添加图片",
               @"image" : @"ic_editor_toolbar_image",
               @"highlightedImage" : @"ic_editor_toolbar_image_selectd",
               @"type" : @"3",
               @"value" : @"",
               },
             @{@"name" : @"添加视频",
               @"image" : @"ic_editor_toolbar_video",
               @"highlightedImage" : @"ic_editor_toolbar_video_highlighted",
               @"type" : @"4",
               @"value" : @"",
               },

             ];
}
/*
 @[
 //             @{@"name" : @"左对齐",
 //               @"image" : @"",
 //               @"type" : @"textAligment",
 //               @"value" : @"NSTextAlimentLeft",
 //               },
 @{@"name" : @"字体大小",
 @"image" : @"",
 @"type" : @"0",
 @"values" : @[
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
 },
 @{@"name" : @"序列",
 @"image" : @"",
 @"type" : @"1",
 @"values" : @[
 @{@"name" : @""}
 ],
 },
 @{@"name" : @"添加超链接",
 @"image" : @"",
 @"type" : @"2",
 @"values" : @[
 @{@"name" : @"alertView"}
 ],
 },
 @{@"name" : @"添加分割线",
 @"image" : @"",
 @"type" : @"3",
 @"values" : @[
 @{@"name" : @"alertView"}
 ],
 },
 @{@"name" : @"@某人",
 @"image" : @"",
 @"type" : @"4",
 @"values" : @[
 @{@"name" : @"alertView"}
 ],
 },
 @{@"name" : @"插入图片",
 @"image" : @"",
 @"type" : @"5",
 @"values" : @[
 @{@"name" : @"alertView"}
 ],
 },
 @{@"name" : @"插入视频",
 @"image" : @"",
 @"type" : @"6",
 @"values" : @[
 @{@"name" : @"alertView"}
 ],
 },
 ]
 */
@end
