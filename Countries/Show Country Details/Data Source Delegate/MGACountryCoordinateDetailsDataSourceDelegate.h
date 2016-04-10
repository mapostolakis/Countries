//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGATableViewCellRegister.h"
@import MapKit;

@protocol MGADataSource, MGACoordinateSelectionDelegate;

@interface MGACountryCoordinateDetailsDataSourceDelegate : NSObject <UITableViewDataSource, UITableViewDelegate, MGATableViewCellRegister>

- (instancetype)initWithSectionTitle:(NSString *)title
                          dataSource:(id <MGADataSource>)dataSource
                            delegate:(id <MGACoordinateSelectionDelegate>)delegate
                         coordinates:(CLLocationCoordinate2D)coordinates;

@end