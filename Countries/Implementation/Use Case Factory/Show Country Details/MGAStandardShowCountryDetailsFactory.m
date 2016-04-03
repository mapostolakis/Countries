//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardShowCountryDetailsFactory.h"
#import "MGATableViewController.h"
#import "MGATableViewDataSourceDelegateCluster.h"
#import "MGACountryDetailsDataSourceDelegate.h"
#import "MGAFlagURLProvider.h"
#import "MGACountry.h"
#import "MGASingleSectionDataSource.h"
#import "MGASingleValueCountryDetails.h"
#import "MGAURLImageDataSourceDelegate.h"
#import "MGASingleObjectDataSource.h"

@interface MGAStandardShowCountryDetailsFactory ()

@property (nonatomic, strong) NSNumberFormatter *numberFormatter;
@property (nonatomic, strong) id <MGAFlagURLProvider> flagURLProvider;

@end

@implementation MGAStandardShowCountryDetailsFactory

- (instancetype)initWithFlagURLProvider:(id <MGAFlagURLProvider>)flagURLProvider
{
    self = [super init];
    if (self) {
        _flagURLProvider = flagURLProvider;
    }
    return self;
}

- (UIViewController *)createCountryDetailsViewForCountry:(id <MGACountry>)country
{
    NSArray *items = [self dataSourceDelegatesForCountry:country];
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

- (NSArray *)dataSourceDelegatesForCountry:(id <MGACountry>)country
{
    NSString *population = [self.numberFormatter stringFromNumber:country.population];
    NSString *area = [NSString stringWithFormat:@"%@ Km\u00b2", [self.numberFormatter stringFromNumber:country.area]];
    return @[
            [self createFlagHeaderForCountryCode:country.alpha2Code],
            [self createDataSourceDelegateForValue:country.nativeName title:@"Native Name"],
            [self createDataSourceDelegateForValue:country.capital title:@"Capital"],
            [self createDataSourceDelegateForValue:country.region title:@"Region"],
            [self createDataSourceDelegateForValue:country.subregion title:@"Subregion"],
            [self createDataSourceDelegateForValue:population title:@"Population"],
            [self createDataSourceDelegateForValue:area title:@"Area"]
    ];
}

- (id <UITableViewDataSource, UITableViewDelegate>)createFlagHeaderForCountryCode:(NSString *)code
{
    NSURL *url = [self.flagURLProvider URLForCountryCode:code];
    MGASingleObjectDataSource *dataSource = [[MGASingleObjectDataSource alloc] init];
    dataSource.value = url;
    return [[MGAURLImageDataSourceDelegate alloc] initWithDataSource:dataSource];
}

- (id <UITableViewDataSource, UITableViewDelegate>)createDataSourceDelegateForValue:(id)value title:(NSString *)title
{
    MGASingleValueCountryDetails *countryDetails = [[MGASingleValueCountryDetails alloc] initWithName:title value:value];
    MGASingleSectionDataSource *dataSource = [[MGASingleSectionDataSource alloc] init];
    dataSource.items = @[countryDetails];
    return [[MGACountryDetailsDataSourceDelegate alloc] initWithSectionTitle:title dataSource:dataSource delegate:nil];
}

@end