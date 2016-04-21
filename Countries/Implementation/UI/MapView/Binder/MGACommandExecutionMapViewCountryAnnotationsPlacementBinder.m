//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACommandExecutionMapViewCountryAnnotationsPlacementBinder.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MGACountryAnnotationsBuilder.h"

@interface MGACommandExecutionMapViewCountryAnnotationsPlacementBinder ()

@property (nonatomic, readonly) RACCommand *command;
@property (nonatomic, readonly) id <MGACountryAnnotationsBuilder> annotationsBuilder;
@property (nonatomic, readonly) MKMapView *mapView;

@end

@implementation MGACommandExecutionMapViewCountryAnnotationsPlacementBinder

- (instancetype)initWithCommand:(RACCommand *)command
             annotationsBuilder:(id <MGACountryAnnotationsBuilder>)annotationsBuilder
                        mapView:(MKMapView *)mapView
{
    self = [super init];
    if (self) {
        _command = command;
        _annotationsBuilder = annotationsBuilder;
        _mapView = mapView;
    }
    return self;
}

- (void)bind
{
    [[[self.command executionSignals] switchToLatest] subscribeNext:^(NSArray *countries) {
        NSArray *annotations = [self.annotationsBuilder createCountryAnnotationsFromCountries:countries];
        [self.mapView addAnnotations:annotations];
    }];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end