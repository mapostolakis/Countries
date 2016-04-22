//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import MapKit;

@protocol MGAFlagURLProvider, MGACountrySelectionDelegate;

@interface MGACountryPinListMapViewDelegate : NSObject <MKMapViewDelegate>

- (instancetype)initWithFlagProvider:(id <MGAFlagURLProvider>)provider
                            delegate:(id <MGACountrySelectionDelegate>)delegate;

@end