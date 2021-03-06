//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleObjectDataSource.h"

@implementation MGASingleObjectDataSource

- (NSUInteger)numberOfAllObjects
{
    return 1;
}

- (NSUInteger)numberOfSections
{
    return 1;
}

- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section
{
    return 1;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return self.value;
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end