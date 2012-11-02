//
//  TTImagePickerItem.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTAsset.h"

@interface TTImagePickerItem : UIView

@property (strong, nonatomic) UIButton *deleteBtn;
@property (strong, nonatomic) UIImageView *thumbnailImageView;
@property (strong, nonatomic) UIImageView *roundCornerMask;

@property (strong, nonatomic) TTAsset *ttAsset;

- (id)initWithTTAsset:(TTAsset *)ttAssset frame:(CGRect)frame;

@end
