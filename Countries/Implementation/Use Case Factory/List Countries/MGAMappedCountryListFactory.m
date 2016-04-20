//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAMappedCountryListFactory.h"
#import "MGAAnnotationProvider.h"
#import "MGACountryPinListMapViewDelegate.h"
#import "MGAMapViewController.h"

@interface MGAMappedCountryListFactory ()

@property (nonatomic, readonly) id <MGAAnnotationProvider> annotationBuilder;

@end

@implementation MGAMappedCountryListFactory

- (instancetype)initWithAnnotationProvider:(id <MGAAnnotationProvider>)builder
{
    self = [super init];
    if (self) {
        _annotationBuilder = builder;
    }
    return self;
}

- (UIViewController *)createListCountriesWithDelegate:(id <MGACountrySelectionDelegate>)delegate
{
    NSArray *annotations = [self.annotationBuilder createCountryListAnnotations];
    MGACountryPinListMapViewDelegate *mapViewDelegate = [[MGACountryPinListMapViewDelegate alloc] init];
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(36, 65);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 5000000, 5000000);
    return [[MGAMapViewController alloc] initWithRegion:region annotations:annotations delegate:mapViewDelegate];
}

@end