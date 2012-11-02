//
//  TTAsset.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTAsset.h"

static NSInteger totalSelectedCount = 0;

@implementation TTAsset

- (void)dealloc
{
    [_asset release];
    [_maskImageView release];
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

- (id)initWithAsset:(ALAsset *)asset
{
    self = [super init];
    if (self) {
        self.asset = asset;
        
        CGRect rect = (CGRect){0, 0, PHOTO_THUMBNAIL_DEFAULT_SIZE};
        
        UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:rect];
		[assetImageView setContentMode:UIViewContentModeScaleToFill];
		[assetImageView setImage:[UIImage imageWithCGImage:[self.asset thumbnail]]];
		[self addSubview:assetImageView];
		[assetImageView release], assetImageView = nil;
        
        _maskImageView = [[UIImageView alloc] initWithFrame:rect];
		[_maskImageView setImage:[UIImage imageNamed:@"TTThumbnailCheckMask"]];
		[_maskImageView setHidden:YES];
		[self addSubview:_maskImageView];
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

- (void)thumbnailDidToggle
{
    if (totalSelectedCount >= 20 && !self.selected) {
        return ;
    }
    
    self.selected = !self.selected;
    _maskImageView.hidden = !self.selected;
    
    if (self.selected) {
        totalSelectedCount += 1;
    } else {
        totalSelectedCount -= 1;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(thumbnailDidClick:)]) {
        [self.delegate performSelector:@selector(thumbnailDidClick:) withObject:self];
    }
}

@end
