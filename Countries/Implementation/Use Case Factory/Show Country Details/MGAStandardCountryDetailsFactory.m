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

@interface MGAStandardCountryDetailsFactory ()

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
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

- (UIViewController *)createCountryDetailsViewForCountry:(id <MGACountry>)country delegate:(id <MGACountrySelectionDelegate>)delegate
{
    NSArray *items = [self dataSourceDelegatesForCountry:country delegate:delegate];
    MGATableViewDataSourceDelegateCluster *cluster = [[MGATableViewDataSourceDelegateCluster alloc] initWithDataSourceDelegates:items];
    MGATableViewController *viewController = [[MGATableViewController alloc] initWithDataSource:cluster delegate:cluster style:UITableViewStylePlain];
    [viewController view];
    viewController.title = country.name;
    [cluster registerCellsForTableView:viewController.tableView];
    return viewController;
}

- (NSNumberFormatter *)numberFormatter
{
    if (_numberFormatter == nil) {
        _numberFormatter = [[NSNumberFormatter alloc] init];
        _numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return _numberFormatter;
}

- (NSArray *)dataSourceDelegatesForCountry:(id <MGACountry>)country delegate:(id <MGACountrySelectionDelegate>)delegate
{
    NSString *population = [self.numberFormatter stringFromNumber:country.population];
    NSString *area = [NSString stringWithFormat:@"%@ Km\u00b2", [self.numberFormatter stringFromNumber:country.area]];
    return @[
            [self createFlagHeaderForCountryCode:country.alpha2Code],
            [self createDataSourceDelegateWithTitle:@"Native Name" countryDetailsValue:country.nativeName],
            [self createDataSourceDelegateWithTitle:@"Capital" countryDetailsValue:country.capital],
            [self createDataSourceDelegateWithTitle:@"Region" countryDetailsValue:country.region],
            [self createDataSourceDelegateWithTitle:@"Subregion" countryDetailsValue:country.subregion],
            [self createDataSourceDelegateWithTitle:@"Population" countryDetailsValue:population],
            [self createDataSourceDelegateWithTitle:@"Area" countryDetailsValue:area],
            [self createDataSourceDelegateWithTitle:@"Borders" partialCountries:country.borderCountries delegate:delegate]
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