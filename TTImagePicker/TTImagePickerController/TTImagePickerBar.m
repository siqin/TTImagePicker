//
//  TTImagePickerBar.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-2.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTImagePickerBar.h"
#import "TTImagePickerItem.h"

@implementation TTImagePickerBar

- (void)dealloc
{
    [_tipLabel release];
    [_selectedAssets release];
    //
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selectedAssets = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"TTImagePickerBarBg"]];
        [self setShowsHorizontalScrollIndicator:NO];
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 11)];
        [self addSubview:self.tipLabel];
        self.tipLabel.font = [UIFont systemFontOfSize:10.0f];
        self.tipLabel.text = @"已选择";
        self.tipLabel.textColor = [UIColor colorWithRed:116.0f/255.0f green:116.0f/255.0f blue:116.0f/255.0f alpha:1.0f];
        self.tipLabel.backgroundColor = [UIColor clearColor];
        [self updateTipLabel];
        
        self.delegate = self;
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

- (void)updateTipLabel
{
    NSInteger count = [self.selectedAssets count];
    self.tipLabel.text = [NSString stringWithFormat:@"已选择 %d 张，还可以选择 %d 张", count, 20-count];
}

- (void)addAsset:(TTAsset *)ttAsset
{
    if ([self.selectedAssets count] >= 20) {
        return ;
    }
    
    [self.selectedAssets addObject:ttAsset];
    [self reloadData];
}

- (void)removeAsset:(TTAsset *)ttAsset
{
    if ([self.selectedAssets count] <= 0) {
        return ;
    }
    
    [self.selectedAssets removeObject:ttAsset];
    [self reloadData];
}

- (void)reloadData
{
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:[TTImagePickerItem class]]) {
            [subView removeFromSuperview];
        }
    }
    
    CGRect rect = (CGRect){10, 25, 65, 65};
    
    for (TTAsset *ttAsset in self.selectedAssets) {
        TTImagePickerItem *item = [[TTImagePickerItem alloc] initWithTTAsset:ttAsset frame:rect];
        [self addSubview:item];
        [item release], item = nil;
        
        rect.origin.x = rect.origin.x + rect.size.width + 7;
    }
    
    [self setContentSize:(CGSize){rect.origin.x, 96}];
    
    if (rect.origin.x > 320) {
        [self setContentOffset:(CGPoint){rect.origin.x-320, 0} animated:YES];
    }
    
    [self updateTipLabel];
}

#pragma mark - 

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect rect = self.tipLabel.frame;
    rect.origin.x = self.contentOffset.x + 10;
    self.tipLabel.frame = rect;
}

@end
