//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAURLImageDataSourceDelegate.h"
#import "MGAImageCell.h"
#import "MGADataSource.h"

@interface MGAURLImageDataSourceDelegate ()

@property (nonatomic, readonly) id <MGADataSource> dataSource;

@end

@implementation MGAURLImageDataSourceDelegate

static NSString * MGAFullImageCellIdentifier = @"MGAImageCell";

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource
{
    self = [super init];
    if (self) {
        _dataSource = dataSource;
    }
    return self;
}

- (void)registerCellsForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MGAImageCell class] forCellReuseIdentifier:MGAFullImageCellIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataSource numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfObjectsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MGAImageCell *cell = [tableView dequeueReusableCellWithIdentifier:MGAFullImageCellIdentifier];
    NSURL *url = [self.dataSource objectAtIndexPath:indexPath];
    [cell setImageForURL:url];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end