//
//  TTAsset.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define PHOTO_THUMBNAIL_DEFAULT_WIDTH   75
#define PHOTO_THUMBNAIL_DEFAULT_HEIGHT  75
#define PHOTO_THUMBNAIL_DEFAULT_SIZE    {75, 75}
#define PHOTO_THUMBNAIL_DEFAULT_MARGIN  4

@interface TTAsset : UIView

@property (strong, nonatomic) ALAsset *asset;
@property (strong, nonatomic) UIImageView *maskImageView;

@property (assign, nonatomic) BOOL selected;
@property (assign, nonatomic) id delegate;

- (id)initWithAsset:(ALAsset *)asset;

@end
