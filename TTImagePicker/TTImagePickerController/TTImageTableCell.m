//
//  TTImageTableCell.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTImageTableCell.h"
#import "TTAsset.h"

@implementation TTImageTableCell

- (void)dealloc
{
    [_assetsArray release];
    //
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAssetsArray:(NSArray *)assetsArray
{
    [_assetsArray release], _assetsArray = nil;
    _assetsArray = [assetsArray retain];
    
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:[TTAsset class]]) {
            [subView removeFromSuperview];
        }
    }
    
    [self layoutAssets];
}

- (void)layoutAssets
{
    CGRect rect = (CGRect){
        PHOTO_THUMBNAIL_DEFAULT_MARGIN, PHOTO_THUMBNAIL_DEFAULT_MARGIN, PHOTO_THUMBNAIL_DEFAULT_SIZE
    };
    
    for (TTAsset *ttAsset in self.assetsArray) {
        ttAsset.frame = rect;
        [self addSubview:ttAsset];
        
        [ttAsset addGestureRecognizer:[[[UITapGestureRecognizer alloc] initWithTarget:ttAsset action:@selector(thumbnailDidToggle)] autorelease]];
        
        rect.origin.x = rect.origin.x + rect.size.width + PHOTO_THUMBNAIL_DEFAULT_MARGIN;
    }
}

@end
