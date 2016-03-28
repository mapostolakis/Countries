//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAServiceProvider.h"

@protocol MGAStore;

@interface MGAStandardServiceProvider : NSObject <MGAServiceProvider>

- (instancetype)initWithStore:(id <MGAStore>)store;

@end