//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionDataSource.h"
@import UIKit;

@interface MGASingleSectionDataSource ()

@property (nonatomic, readonly) NSArray *items;

@end

@implementation MGASingleSectionDataSource

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        _items = items;
    }
    return self;
}

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

@end