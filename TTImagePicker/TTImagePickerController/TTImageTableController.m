//
//  TTImageTableController.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTImageTableController.h"
#import "TTAsset.h"
#import "TTImageTableCell.h"

@interface TTImageTableController ()

@end

@implementation TTImageTableController

- (void)dealloc
{
    [_assetsLibrary release];
    [_assetsGroup release];
    [_assetsArray release];
    
    [_tableView release];
    [_bottomBar release];
    //
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Translate EnGroupName into CnGroupName
    NSString *groupName = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    if ([groupName isEqualToString:@"Camera Roll"]) {
        groupName = @"相机胶卷";
    } else if ([groupName isEqualToString:@"My Photo Stream"]) {
        groupName = @"我的照片流";
    }
    self.title = groupName;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonSystemItemDone target:self action:@selector(doneButtonDidClick:)] autorelease];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){0, 44, 320, 320} style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    _bottomBar = [[TTImagePickerBar alloc] initWithFrame:(CGRect){0, 364, 320, 96}];
    [self.view addSubview:self.bottomBar];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getImages];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)getImages
{
    if (!self.assetsArray) {
        _assetsArray = [[NSMutableArray alloc] init];
    }
    
    if (!self.assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    @autoreleasepool {
        [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                TTAsset *ttAsset = [[TTAsset alloc] initWithAsset:result];
                ttAsset.delegate = self;
                [self.assetsArray addObject:ttAsset];
                [ttAsset release], ttAsset = nil;
            }
        }];
    }
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ceil([self.assetsGroup numberOfAssets] / 4.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 79.0f;   // The size of the thumbnail in iPhoto is (75, 75), with 4-pix margin to each other.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TTImageTableCell";
    TTImageTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[[TTImageTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSInteger idx = indexPath.row * 4;
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:4];
    for (int i = idx; i < [self.assetsArray count] && i < idx + 4; ++i) {
        [array addObject:[self.assetsArray objectAtIndex:i]];
    }
    cell.assetsArray = array;
    cell.delegate = self;
    [array release], array = nil;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 

- (void)doneButtonDidClick:(id)sender
{
    if ([self.bottomBar.selectedAssets count] <= 0) {
        return ;
    }
    
    NSMutableArray *imageInfoArray = [[[NSMutableArray alloc] init] autorelease];
	
	for(TTAsset *ttAsset in self.bottomBar.selectedAssets) {
        ALAsset *asset = ttAsset.asset;
		NSMutableDictionary *workingDictionary = [[NSMutableDictionary alloc] init];
        
		[workingDictionary setObject:[asset valueForProperty:ALAssetPropertyType] forKey:@"UIImagePickerControllerMediaType"];
        [workingDictionary setObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] forKey:@"UIImagePickerControllerOriginalImage"];
		[workingDictionary setObject:[[asset valueForProperty:ALAssetPropertyURLs] valueForKey:[[[asset valueForProperty:ALAssetPropertyURLs] allKeys] objectAtIndex:0]] forKey:@"UIImagePickerControllerReferenceURL"];
		
		[imageInfoArray addObject:workingDictionary];
		[workingDictionary release], workingDictionary = nil;
	}
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(didFinishPickingImages:)])
    {
        [self.delegate performSelector:@selector(didFinishPickingImages:) withObject:imageInfoArray];
    }
}

- (void)thumbnailDidClick:(TTAsset *)ttAsset
{
    if (ttAsset.selected) {
        [self.bottomBar addAsset:ttAsset];
    } else {
        [self.bottomBar removeAsset:ttAsset];
    }
}

@end
