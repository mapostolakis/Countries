//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGACountryGateway.h"

@class MGAInMemoryStore;

@interface MGAInMemoryStoreGateway : NSObject <MGACountryGateway>

- (instancetype)initWithStore:(MGAInMemoryStore *)store;

@end