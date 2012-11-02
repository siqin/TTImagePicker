//
//  TTImageTableCell.h
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTImageTableCell : UITableViewCell

@property (strong, nonatomic) NSArray *assetsArray;

@property (assign, nonatomic) id delegate;

@end
