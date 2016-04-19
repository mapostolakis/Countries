//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

@import MapKit;

@interface MGACountryAnnotation : NSObject <MKAnnotation>

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates
                              title:(NSString *)title
                           subtitle:(NSString *)subtitle;

@end