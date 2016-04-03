//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleObjectDataSource.h"

@implementation MGASingleObjectDataSource

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

@end