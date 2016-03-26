//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAInMemoryStore.h"

@interface MGAInMemoryStore ()

@property (nonatomic, strong) id cachedObject;

@end

@implementation MGAInMemoryStore

- (void)save:(id)object
{
    self.cachedObject = object;
}

@end