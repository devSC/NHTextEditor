//
//  NHSwissingUtils.h
//  Being
//
//  Created by xiaofeng on 15/10/14.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


#define objc_runOldMethod(curClass,oldMethod,theSelf,theSEL,...)                                                    \
(oldMethod || (oldMethod=(void*)class_getMethodImplementation(class_getSuperclass(curClass),theSEL)))                \
? oldMethod(theSelf, theSEL, ##__VA_ARGS__)                 \
: oldMethod(theSelf, theSEL,##__VA_ARGS__);                 \
if (oldMethod == (void*)class_getMethodImplementation(class_getSuperclass(curClass),theSEL)) {oldMethod = nil;};


void* objc_changeMethod(Class clazz,SEL sel,void*newFunction);


void* objc_changeClassMethod(Class clazz,SEL sel,void*newFunction);

