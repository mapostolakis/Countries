//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewDataSourceDelegateCluster.h"

@interface MGATableViewDataSourceDelegateCluster ()

@property (nonatomic, readonly) NSArray *dataSourceDelegates;

@end

@implementation MGATableViewDataSourceDelegateCluster

- (instancetype)initWithDataSourceDelegates:(NSArray <id <UITableViewDataSource, UITableViewDelegate>> *)items
{
    self = [super init];
    if (self) {
        _dataSourceDelegates = items;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSourceDelegates.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <UITableViewDataSource, UITableViewDelegate> dataSourceDelegate = self.dataSourceDelegates[section];
    return [dataSourceDelegate tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <UITableViewDataSource, UITableViewDelegate> dataSourceDelegate = self.dataSourceDelegates[indexPath.section];
    NSIndexPath *localIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    return [dataSourceDelegate tableView:tableView cellForRowAtIndexPath:localIndexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <UITableViewDataSource, UITableViewDelegate> dataSourceDelegate = self.dataSourceDelegates[indexPath.section];
    NSIndexPath *localIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    return [dataSourceDelegate tableView:tableView heightForRowAtIndexPath:localIndexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id <UITableViewDataSource, UITableViewDelegate> dataSourceDelegate = self.dataSourceDelegates[section];
    return [dataSourceDelegate tableView:tableView titleForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    id <UITableViewDataSource, UITableViewDelegate> dataSourceDelegate = self.dataSourceDelegates[section];
    return [dataSourceDelegate tableView:tableView heightForHeaderInSection:section];
}

@end