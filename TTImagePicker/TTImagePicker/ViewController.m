//
//  ViewController.m
//  TTImagePicker
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc
{
    [_imageView release];
    
    if ([_timer isValid]) {
        [_timer invalidate];
    }
    [_timer release];
    
    [_imageArray release];
    //
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *launchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    launchBtn.frame = (CGRect){60, 20, 200, 44};
    [launchBtn setTitle:@"Launch TTImagePicker" forState:UIControlStateNormal];
    [launchBtn addTarget:self action:@selector(launchTTImagePicker) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:launchBtn];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 100, 200, 200)];
    self.imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.imageView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)launchTTImagePicker
{
    TTAlbumTableController *albumTable = [[TTAlbumTableController alloc] init];
    TTImagePickerController *imagePicker = [[TTImagePickerController alloc] initWithRootViewController:albumTable];
    albumTable.delegate = imagePicker;
    [self presentModalViewController:imagePicker animated:YES];
    imagePicker.delegate = self;
    [albumTable release], albumTable = nil;
    [imagePicker release], imagePicker = nil;
}

- (void)ttImagePickerController:(TTImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:[info count]];
    for (NSDictionary *dict in info) {
        [mutableArray addObject:[dict objectForKey:@"UIImagePickerControllerOriginalImage"]];
    }
    self.imageArray = mutableArray;
    [mutableArray release], mutableArray = nil;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(flashImages) userInfo:nil repeats:YES];
}

- (void)ttImagePickerControllerDidCancel:(TTImagePickerController *)picker
{
    ;
}

- (void)flashImages
{
    if ([self.imageArray count] <= 0) {
        return ;
    }
    
    int i = arc4random() % [self.imageArray count];
    self.imageView.image = [self.imageArray objectAtIndex:i];
}

@end

