//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStore.h"

@interface MGAInMemoryStore : NSObject <MGAStore>

@property (nonatomic, readonly) id cachedObject;

@end