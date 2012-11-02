//
//  TTImagePickerBar.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTAsset.h"

@interface TTImagePickerBar : UIScrollView <UIScrollViewDelegate>

@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) NSMutableArray *selectedAssets;

- (void)addAsset:(TTAsset *)ttAsset;
- (void)removeAsset:(TTAsset *)ttAsset;

@end
