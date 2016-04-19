//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryAnnotation.h"

@implementation MGACountryAnnotation

@synthesize coordinate = _coordinate, title = _title, subtitle = _subtitle;

- (instancetype)initWithCoordinates:(CLLocationCoordinate2D)coordinates
                              title:(NSString *)title
                           subtitle:(NSString *)subtitle
{
    self = [super init];
    if (self) {
        _coordinate = coordinates;
        _title = title;
        _subtitle = subtitle;
    }
    return self;
}

@end