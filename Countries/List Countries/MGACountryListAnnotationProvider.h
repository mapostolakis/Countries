//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@protocol MGACountryListAnnotationProvider <NSObject>

- (NSArray <id <MKAnnotation>> *)createCountryListAnnotations;

@end