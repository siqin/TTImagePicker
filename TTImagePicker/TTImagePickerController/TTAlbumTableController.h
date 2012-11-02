//
//  TTAlbumTableController.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface TTAlbumTableController : UITableViewController

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) NSMutableArray *groupArray;

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;

@end
