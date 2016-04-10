//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryCoordinateDetailsDataSourceDelegate.h"
#import "MGADataSource.h"
#import "MGACoordinateSelectionDelegate.h"
#import "MGACountryCoordinateDetailsCell.h"

@interface MGACountryCoordinateDetailsDataSourceDelegate ()

@property (nonatomic, readonly) NSString *sectionTitle;
@property (nonatomic, readonly) id <MGADataSource> dataSource;
@property (nonatomic, readonly) id <MGACoordinateSelectionDelegate> delegate;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinates;

@end

@implementation MGACountryCoordinateDetailsDataSourceDelegate

static NSString *CellReuseIdentifier = @"MGACountryCoordinateDetailsCell";

- (instancetype)initWithSectionTitle:(NSString *)title
                          dataSource:(id <MGADataSource>)dataSource
                            delegate:(id <MGACoordinateSelectionDelegate>)delegate
                         coordinates:(CLLocationCoordinate2D)coordinates
{
    self = [super init];
    if (self) {
        _sectionTitle = title;
        _dataSource = dataSource;
        _delegate = delegate;
        _coordinates = coordinates;
    }
    return self;
}

- (void)registerCellsForTableView:(UITableView *)tableView
{
    [tableView registerClass:[MGACountryCoordinateDetailsCell class] forCellReuseIdentifier:CellReuseIdentifier];
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
    MGACountryCoordinateDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellReuseIdentifier];
    [cell setLatitude:[NSString stringWithFormat:@"Latitude: %g", self.coordinates.latitude]];
    [cell setLongitude:[NSString stringWithFormat:@"Longitude: %g", self.coordinates.longitude]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
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
    [self.delegate didSelectCoordinates:self.coordinates];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end