//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataSource.h"

@interface MGASingleSectionDataSource : NSObject <MGADataSource>

@property (nonatomic, strong) NSArray *items;

@end