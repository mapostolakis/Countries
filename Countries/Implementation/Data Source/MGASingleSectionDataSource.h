//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataSource.h"

@interface MGASingleSectionDataSource : NSObject <MGADataSource>

- (instancetype)initWithItems:(NSArray *)items;

@end