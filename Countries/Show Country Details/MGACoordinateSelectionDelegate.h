//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@protocol MGACoordinateSelectionDelegate <NSObject>

- (void)didSelectCoordinates:(CLLocationCoordinate2D)coordinates;

@end