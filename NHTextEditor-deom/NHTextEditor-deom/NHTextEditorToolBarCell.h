//
//  NHTextEditorToolBarCell.h
//  NHTextEditor-deom
//
//  Created by Wilson Yuan on 15/11/30.
//  Copyright © 2015年 Wilson-Yuan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NHTextEditorEntity.h"

typedef void(^ItemTappedBlock)(NHTextEditorEntity *entity);

@interface NHTextEditorToolBarCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;

- (void)setData:(NHTextEditorEntity *)data itemTappedBlock:(ItemTappedBlock)tappedBlock selected:(BOOL)select;

- (void)setItemSelected:(BOOL)selected;

@end
