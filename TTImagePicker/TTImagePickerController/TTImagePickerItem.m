//
//  TTImagePickerItem.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTImagePickerItem.h"

@implementation TTImagePickerItem

- (void)dealloc
{
    [_deleteBtn release];
    [_thumbnailImageView release];
    [_roundCornerMask release];
    //
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithTTAsset:(TTAsset *)ttAssset frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [self addSubview:_thumbnailImageView];
        [_thumbnailImageView setContentMode:UIViewContentModeScaleToFill];
        [_thumbnailImageView setImage:[UIImage imageWithCGImage:[ttAssset.asset thumbnail]]];
        
        _roundCornerMask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 65, 65)];
        [self addSubview:_roundCornerMask];
        [_roundCornerMask setContentMode:UIViewContentModeScaleToFill];
        [_roundCornerMask setImage:[UIImage imageNamed:@"TTImagePickerBar_RoundCornerMask"]];
        
        UIImage *deleteBtnBgImage = [UIImage imageNamed:@"TTImagePickerBar_DeleteBtnBg"];
        self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.deleteBtn.frame = (CGRect){-5, -5, deleteBtnBgImage.size};
        [self.deleteBtn setImage:deleteBtnBgImage forState:UIControlStateNormal];
        [self addSubview:self.deleteBtn];
        [self.deleteBtn addTarget:self action:@selector(deleteBtnDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.ttAsset = ttAssset;
        
        [self addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnDidClick:)] autorelease]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - 

- (void)deleteBtnDidClick:(id)sender
{
    [self.ttAsset performSelector:@selector(thumbnailDidToggle)];
}

@end
