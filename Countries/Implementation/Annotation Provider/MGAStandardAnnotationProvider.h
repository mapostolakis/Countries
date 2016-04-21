//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAAnnotationProvider.h"

@protocol MGADataSource;

@interface MGAStandardAnnotationProvider : NSObject <MGAAnnotationProvider>

- (instancetype)initWithDataSource:(id <MGADataSource>)dataSource;

@end