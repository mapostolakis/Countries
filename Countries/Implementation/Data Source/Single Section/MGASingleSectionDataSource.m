//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionDataSource.h"
@import UIKit;

@implementation MGASingleSectionDataSource

- (NSUInteger)numberOfSections
{
    return 1;
}

- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section
{
    return self.items.count;
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    return self.items[indexPath.row];
}

- (void)dealloc
{
    NSLog(@"[%@: dealloc]", NSStringFromClass([self class]));
}

@end