//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryListTableViewDataSourceDelegate.h"
#import "MGACountrySelectionDelegate.h"
#import "MGADataSource.h"
#import "MGACountry.h"
#import "MGAFlagURLProvider.h"
#import "MGACountryAndFlagCell.h"

@interface MGACountryListTableViewDataSourceDelegate ()

@property (nonatomic, readonly) id <MGADataSource> dataSource;
@property (nonatomic, readonly) id <MGACountrySelectionDelegate> delegate;
@property (nonatomic, readonly) id <MGAFlagURLProvider> flagURLProvider;

@end

@implementation MGACountryListTableViewDataSourceDelegate

static NSString *reuseIdentifier = @"MGACountryAndFlagCell";

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource
                          delegate:(id <MGACountrySelectionDelegate>)delegate
                   flagURLProvider:(id <MGAFlagURLProvider>)provider
{
    self = [super init];
    if (self) {
        _dataSource = dataSource;
        _delegate = delegate;
        _flagURLProvider = provider;
    }
    return self;
}

- (void)registerCellsForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MGACountryAndFlagCell class] forCellReuseIdentifier:reuseIdentifier];
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
    MGACountryAndFlagCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    id <MGACountry> country = [self.dataSource objectAtIndexPath:indexPath];
    [cell setName:country.name];
    [cell setFlagURL:[self.flagURLProvider URLForCountryCode:country.alpha2Code]];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.dataSource numberOfObjectsInSection:section] > 0 ? self.sectionTitle : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return UITableViewAutomaticDimension;
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end