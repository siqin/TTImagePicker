//
//  ViewController.h
//  TTImagePicker
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTImagePickerController.h"
#import "TTAlbumTableController.h"

@interface ViewController : UIViewController <TTImagePickerControllerDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSArray *imageArray;

@end
