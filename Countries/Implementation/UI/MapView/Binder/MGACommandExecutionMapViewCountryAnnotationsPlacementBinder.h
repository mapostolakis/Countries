//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import MapKit;

@class RACCommand;
@protocol MGACountryAnnotationsBuilder;

@interface MGACommandExecutionMapViewCountryAnnotationsPlacementBinder : NSObject

- (instancetype)initWithCommand:(RACCommand *)command
             annotationsBuilder:(id <MGACountryAnnotationsBuilder>)annotationsBuilder
                        mapView:(MKMapView *)mapView;

- (void)bind;

@end