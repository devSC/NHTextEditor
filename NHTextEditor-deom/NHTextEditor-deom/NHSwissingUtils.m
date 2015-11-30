//
//  NHSwissingUtils.m
//  Being
//
//  Created by xiaofeng on 15/10/14.
//  Copyright © 2015年 Being Inc. All rights reserved.
//

#import "NHSwissingUtils.h"
#import <objc/runtime.h>

void* objc_changeMethod(Class class,SEL sel,void*newFunction) {
    Method oldMethod = class_getInstanceMethod(class, sel);
    void* oldFuction = (void*)method_getImplementation(oldMethod);
    BOOL succeed = class_addMethod(class,
                                   sel,
                                   (IMP)newFunction,
                                   method_getTypeEncoding(oldMethod));
    if (!succeed)
    {
        method_setImplementation(oldMethod, (IMP)newFunction);
    }
    return oldFuction;
}

void* objc_changeClassMethod(Class class,SEL sel,void*newFunction) {
    Method oldMethod = class_getClassMethod(class, sel);
    void* oldFuction = (void*)method_getImplementation(oldMethod);
    class = object_getClass((id)class);
    
    BOOL succeed = class_addMethod(class,
                                   sel,
                                   (IMP)newFunction,
                                   method_getTypeEncoding(oldMethod));
    if (!succeed)
    {
        method_setImplementation(oldMethod, (IMP)newFunction);
    }
    return oldFuction;
}

