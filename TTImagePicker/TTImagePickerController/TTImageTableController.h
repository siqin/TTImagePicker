//
//  TTImageTableController.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TTImagePickerBar.h"

@interface TTImageTableController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) id delegate;

@property (strong, nonatomic) ALAssetsLibrary   *assetsLibrary;
@property (strong, nonatomic) ALAssetsGroup     *assetsGroup;
@property (strong, nonatomic) NSMutableArray    *assetsArray;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) TTImagePickerBar *bottomBar;

@property (assign, nonatomic) BOOL isUploading;

@end
