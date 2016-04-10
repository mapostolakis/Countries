//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MGAStandardCountryDetailsFactory.h"
#import "MGATableViewController.h"
#import "MGATableViewDataSourceDelegateCluster.h"
#import "MGACountryDetailsDataSourceDelegate.h"
#import "MGAFlagURLProvider.h"
#import "MGACountry.h"
#import "MGASingleSectionDataSource.h"
#import "MGACountryGateway.h"
#import "MGAURLImageDataSourceDelegate.h"
#import "MGASingleObjectDataSource.h"
#import "MGAPartialToFullCountryListMapper.h"
#import "MGAMutableCountryDetails.h"
#import "MGACountryListTableViewDataSourceDelegate.h"
#import "MGACountryDetailsViewModel.h"
#import "MGACoordinateSelectionDelegate.h"
#import "MGACountryCoordinateDetailsDataSourceDelegate.h"

@interface MGAStandardCountryDetailsFactory ()

@property (nonatomic, readonly) id <MGAFlagURLProvider> flagURLProvider;
@property (nonatomic, readonly) id <MGACountryGateway> gateway;

@end

@implementation MGAStandardCountryDetailsFactory

- (instancetype)initWithFlagURLProvider:(id <MGAFlagURLProvider>)flagURLProvider gateway:(id <MGACountryGateway>)gateway
{
    self = [super init];
    if (self) {
        _flagURLProvider = flagURLProvider;
        _gateway = gateway;
    }
    return self;
}

- (UIViewController *)createCountryDetailsViewForCountry:(id <MGACountry>)country
                                                delegate:(id <MGACountrySelectionDelegate>)delegate
                             coordinateSelectionDelegate:(id <MGACoordinateSelectionDelegate>)coordinateSelectionDelegate
{
    NSArray *items = [self dataSourceDelegatesForCountry:country delegate:delegate coordinateSelectionDelegate:coordinateSelectionDelegate];
    MGATableViewDataSourceDelegateCluster *cluster = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];
    MGATableViewController *viewController = [[MGATableViewController alloc] initWithDataSource:cluster delegate:cluster style:UITableViewStylePlain];
    [viewController view];
    viewController.title = country.name;
    [cluster registerCellsForTableView:viewController.tableView];
    return viewController;
}


- (NSArray *)dataSourceDelegatesForCountry:(id <MGACountry>)country
                                  delegate:(id <MGACountrySelectionDelegate>)delegate
               coordinateSelectionDelegate:(id <MGACoordinateSelectionDelegate>)coordinateSelectionDelegate
{
    MGACountryDetailsViewModel *model = [[MGACountryDetailsViewModel alloc] initWithCountry:country];
    return @[
            [self createFlagHeaderForCountryCode:country.alpha2Code],
            [self createDataSourceDelegateWithTitle:[model nativeNameTitle] countryDetailsValue:country.nativeName],
            [self createDataSourceDelegateWithTitle:[model capitalTitle] countryDetailsValue:country.capital],
            [self createDataSourceDelegateWithTitle:[model regionTitle] countryDetailsValue:country.region],
            [self createDataSourceDelegateWithTitle:[model subregionTitle] countryDetailsValue:country.subregion],
            [self createDataSourceDelegateWithTitle:[model populationTitle] countryDetailsValue:[model population]],
            [self createDataSourceDelegateWithTitle:[model areaTitle] countryDetailsValue:[model area]],
            [self createDataSourceDelegateWithTitle:[model coordinatesTitle] coordinates:country.coordinates delegate:coordinateSelectionDelegate],
            [self createDataSourceDelegateWithTitle:[model bordersTitle] partialCountries:country.borderCountries delegate:delegate]
    ];
}

- (id <UITableViewDataSource, UITableViewDelegate>)createFlagHeaderForCountryCode:(NSString *)code
{
    NSURL *url = [self.flagURLProvider URLForCountryCode:code];
    MGASingleObjectDataSource *dataSource = [[MGASingleObjectDataSource alloc] init];
    dataSource.value = url;
    return [[MGAURLImageDataSourceDelegate alloc] initWithDataSource:dataSource];
}

- (id <UITableViewDataSource, UITableViewDelegate>)createDataSourceDelegateWithTitle:(NSString *)title countryDetailsValue:(NSString *)value
{
    MGAMutableCountryDetails *countryDetails = [[MGAMutableCountryDetails alloc] init];
    countryDetails.value = value;
    MGASingleSectionDataSource *dataSource = [[MGASingleSectionDataSource alloc] init];
    dataSource.items = @[countryDetails];
    return [[MGACountryDetailsDataSourceDelegate alloc] initWithSectionTitle:title dataSource:dataSource delegate:nil];
}

- (id <UITableViewDataSource, UITableViewDelegate>)createDataSourceDelegateWithTitle:(NSString *)title
                                                                         coordinates:(CLLocationCoordinate2D)coordinates
                                                                            delegate:(id <MGACoordinateSelectionDelegate>)delegate
{
    MGASingleObjectDataSource *dataSource = [[MGASingleObjectDataSource alloc] init];
    return [[MGACountryCoordinateDetailsDataSourceDelegate alloc] initWithSectionTitle:title
                                                                            dataSource:dataSource
                                                                              delegate:delegate
                                                                           coordinates:coordinates];
}

- (id <UITableViewDataSource, UITableViewDelegate>)createDataSourceDelegateWithTitle:(NSString *)title
                                                                    partialCountries:(NSArray *)partials
                                                                            delegate:(id <MGACountrySelectionDelegate>)delegate
{
    MGAPartialToFullCountryListMapper *mapper = [[MGAPartialToFullCountryListMapper alloc] initWithGateway:self.gateway];
    MGASingleSectionDataSource *dataSource = [[MGASingleSectionDataSource alloc] init];
    dataSource.items = [mapper mapResource:partials];
    MGACountryListTableViewDataSourceDelegate *dataSourceDelegate =
    [[MGACountryListTableViewDataSourceDelegate alloc] initWithDataSource:dataSource delegate:delegate flagURLProvider:self.flagURLProvider];
    dataSourceDelegate.sectionTitle = title;
    return dataSourceDelegate;
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end