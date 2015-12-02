//
//  NHTextEditorHeader.h
//  NHTextEditor-deom
//
//  Created by Wilson-Yuan on 15/12/1.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//



//typedef NS_ENUM(NSInteger, NHTextEditType) {
//    NHTextEditTypeFont = 0,     //改变字体大小
//    NHTextEditTypeOrder,        //前面加序列
//    NHTextEditTypeLink,         //超链接
//    NHTextEditTypeSeperate,     //分割线
//    NHTextEditTypeCall,         //@某人
//    NHTextEditTypeImage,        //插入图
//    NHTextEditTypeVideo,        //插入视频
//};
typedef NS_ENUM(NSInteger, NHTextEditType) {
    NHTextEditTypeEndEdit = 0,         //结束编辑
    NHTextEditTypeNormalFont,           //改变字体大小
    NHTextEditTypeBoldFont,             //粗体
    NHTextEditTypeImage,                //插入图
    NHTextEditTypeVideo,                //插入视频
};

static float kNHEditorToolBarHeight = 51;
