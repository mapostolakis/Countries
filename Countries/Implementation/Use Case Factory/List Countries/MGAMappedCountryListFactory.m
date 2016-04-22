//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <ReactiveCocoa/RACSignal+Operations.h>
#import <ReactiveCocoa/RACCommand.h>
#import "MGAMappedCountryListFactory.h"
#import "MGACountryPinListMapViewDelegate.h"
#import "MGAMapViewController.h"
#import "MGACommandExecutionMapViewCountryAnnotationsPlacementBinder.h"
#import "MGAStandardCountryAnnotationsBuilder.h"
#import "MGAGeonamesFlagURLProvider.h"

@interface MGAMappedCountryListFactory ()

@property (nonatomic, readonly) RACCommand *command;
@end

@implementation MGAMappedCountryListFactory

- (instancetype)initWithServiceCommand:(RACCommand *)command
{
    self = [super init];
    if (self) {
        _command = command;
    }
    return self;
}

- (UIViewController *)createListCountriesWithDelegate:(id <MGACountrySelectionDelegate>)delegate
{
    id <MGAFlagURLProvider> flagProvider = [MGAGeonamesFlagURLProvider new];
    MGACountryPinListMapViewDelegate *mapViewDelegate = [[MGACountryPinListMapViewDelegate alloc] initWithFlagProvider:flagProvider delegate:nil];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36, 65);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 5000000, 5000000);
    MGAMapViewController *viewController = [[MGAMapViewController alloc] initWithRegion:region delegate:mapViewDelegate];
    [viewController view];
    MGAStandardCountryAnnotationsBuilder *annotationsBuilder = [[MGAStandardCountryAnnotationsBuilder alloc] init];
    [[[MGACommandExecutionMapViewCountryAnnotationsPlacementBinder alloc] initWithCommand:self.command
                                                                       annotationsBuilder:annotationsBuilder
                                                                                  mapView:viewController.mapView] bind];
    viewController.title = @"Countries";
    [self.command execute:nil];
    return viewController;
}

@end