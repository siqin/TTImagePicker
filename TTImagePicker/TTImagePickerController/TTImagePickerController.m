//
//  TTImagePickerController.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTImagePickerController.h"

@interface TTImagePickerController ()

@end

@implementation TTImagePickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)cancelButtonDidClick:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ttImagePickerControllerDidCancel:)]) {
        [self.delegate ttImagePickerControllerDidCancel:self];
    }
}

- (void)didFinishPickingImages:(NSArray *)info
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(ttImagePickerController:didFinishPickingMediaWithInfo:)])
    {
        [self.delegate ttImagePickerController:self didFinishPickingMediaWithInfo:info];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
