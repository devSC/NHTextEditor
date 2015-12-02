//
//  NHTextEditorManager.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHTextEditorEntity.h"
#define SingletonDeclarationWithClass +(instancetype)sharedInstance;
#define SingletonImplementationWithClass \
+ (instancetype)sharedInstance {\
static id instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
}


@interface NHTextEditorManager : NSObject
SingletonDeclarationWithClass


@property (strong, nonatomic) NSArray *tools;

- (UIFont *)fontForEditorEntity:(NHTextEditorEntity *)entity;

@end
