//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryListTableViewAdapter.h"
#import "MGACountrySelectionDelegate.h"
#import "MGADataSource.h"
#import "MGACountry.h"

@interface MGACountryListTableViewAdapter ()

@property (nonatomic, readonly) id <MGADataSource> dataSource;
@property (nonatomic, readonly) id <MGACountrySelectionDelegate> delegate;

@end

@implementation MGACountryListTableViewAdapter

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource delegate:(id <MGACountrySelectionDelegate>)delegate
{
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        _delegate = delegate;
    }
    return self;
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
    static NSString *reuseIdentifier = @"MGACountryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    id <MGACountry> country = [self.dataSource objectAtIndexPath:indexPath];
    cell.textLabel.text = country.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <MGACountry> country = [self.dataSource objectAtIndexPath:indexPath];
    [self.delegate didSelectCountry:country];
}

@end