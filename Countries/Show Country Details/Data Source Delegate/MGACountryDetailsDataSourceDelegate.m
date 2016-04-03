//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryDetailsDataSourceDelegate.h"
#import "MGADataSource.h"
#import "MGACountryDetailsSelectionDelegate.h"
#import "MGACountryDetails.h"

@interface MGACountryDetailsDataSourceDelegate ()

@property (nonatomic, readonly) NSString *sectionTitle;
@property (nonatomic, readonly) id <MGADataSource> dataSource;
@property (nonatomic, readonly) id <MGACountryDetailsSelectionDelegate> delegate;

@end

@implementation MGACountryDetailsDataSourceDelegate

- (instancetype)initWithSectionTitle:(NSString *)title
                          dataSource:(id <MGADataSource>)dataSource
                            delegate:(id <MGACountryDetailsSelectionDelegate>)delegate
{
    self = [super init];
    if (self) {
        _sectionTitle = title;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    id <MGACountryDetails> countryDetails = [self.dataSource objectAtIndexPath:indexPath];
    cell.textLabel.text = countryDetails.value;
    cell.selectionStyle = self.delegate ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
    cell.accessoryType = self.delegate ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sectionTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <MGACountryDetails> countryDetails = [self.dataSource objectAtIndexPath:indexPath];
    [self.delegate didSelectCountryDetails:countryDetails];
}

@end