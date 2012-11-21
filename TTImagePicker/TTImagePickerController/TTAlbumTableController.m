//
//  TTAlbumTableController.m
//  MultiImagePickerDemo
//
//  Created by Jason Lee on 12-11-1.
//  Copyright (c) 2012年 Jason Lee. All rights reserved.
//

#import "TTAlbumTableController.h"
#import "TTImageTableController.h"

@interface TTAlbumTableController ()

@end

@implementation TTAlbumTableController

- (id)init
{
    self = [super init];
    if (self) {
        //
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [_groupArray release];
    [_assetsLibrary release];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    //
    [super dealloc];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"加载中";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonDidClick:)] autorelease];
    
    [self checkAlbumGroups];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (void)applicationWillEnterForeground
{
    // reload table if needed.
}

- (void)checkAlbumGroups
{
    if (!self.groupArray) {
        _groupArray = [[NSMutableArray alloc] init];
    }
    
    if (!self.assetsLibrary) {
        _assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        // !!! Notice : ALAssetsGroupAll doesn't include ALAssetsGroupLibrary.
        [_assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group) {
                [self.groupArray addObject:group];
                [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:YES];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"Group not found!\n");
            self.title = @"访问照片失败"; // Photo-access is disabled.
        }];
    });
}

- (void)reloadTableView
{
    [self.tableView reloadData];
    self.title = @"选择相册";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groupArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TTAlbumGroupCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Get count
    ALAssetsGroup *group = (ALAssetsGroup*)[self.groupArray objectAtIndex:indexPath.row];
    [group setAssetsFilter:[ALAssetsFilter allPhotos]];
    NSInteger groupCount = [group numberOfAssets];
    
    // Translate EnGroupName into CnGroupName
    NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
    if ([groupName isEqualToString:@"Camera Roll"]) {
        groupName = @"相机胶卷";
    } else if ([groupName isEqualToString:@"My Photo Stream"]) {
        groupName = @"我的照片流";
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%d)",groupName, groupCount];
    [cell.imageView setImage:[UIImage imageWithCGImage:[(ALAssetsGroup*)[self.groupArray objectAtIndex:indexPath.row] posterImage]]];
	[cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TTImageTableController *imageTable = [[TTImageTableController alloc] init];
    imageTable.assetsGroup = (ALAssetsGroup*)[self.groupArray objectAtIndex:indexPath.row];
    imageTable.delegate = self.delegate;
    [self.navigationController pushViewController:imageTable animated:YES];
    [imageTable release], imageTable = nil;
}

#pragma mark - 

- (void)cancelButtonDidClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonDidClick:)]) {
        [self.delegate performSelector:@selector(cancelButtonDidClick:) withObject:sender];
    }
}

@end
