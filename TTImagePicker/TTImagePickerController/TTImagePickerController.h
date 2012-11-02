//
//  TTImagePickerController.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

/*
 * The prefix 'TT' stands for '32'.
 * http://weibo.com/jasonmblog
 */

#import <UIKit/UIKit.h>

@interface TTImagePickerController : UINavigationController

@property (assign, nonatomic) id delegate;

@end

@protocol TTImagePickerControllerDelegate

- (void)ttImagePickerController:(TTImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info;
- (void)ttImagePickerControllerDidCancel:(TTImagePickerController *)picker;

@end
