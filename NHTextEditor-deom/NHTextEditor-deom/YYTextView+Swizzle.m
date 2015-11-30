//
//  YYTextView+Swizz.m
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import "YYTextView+Swizzle.h"
#import <objc/runtime.h>


@implementation YYTextView (Swizzle)


+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(deleteBackward);
        SEL swizzledSelector = @selector(swizz_deleteBackWard);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


- (void)swizz_deleteBackWard {
    [self swizz_deleteBackWard];
    //
    NSLog(@"deleteBackWard");
}
@end
