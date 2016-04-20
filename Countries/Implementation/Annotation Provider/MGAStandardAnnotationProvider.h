//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAAnnotationProvider.h"

@protocol MGADataSourceProvider;

@interface MGAStandardAnnotationProvider : NSObject <MGAAnnotationProvider>

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider;

@end