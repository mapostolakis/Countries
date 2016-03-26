//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionEventDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGASingleSectionEventDataSource ()

@property (nonatomic, readonly) RACSignal *signal;
@property (nonatomic, strong) NSArray *items;

@end

@implementation MGASingleSectionEventDataSource

- (instancetype)initWithSignal:(RACSignal *)signal
{
    self = [super init];
    if (self) {
        _signal = signal;
    }
    return self;
}

- (void)start
{
    @weakify(self);
    [self.signal subscribeNext:^(NSArray *value) {
        @strongify(self);
        self.items = [value copy];
    }];
}

- (NSArray *)items
{
    if (_items == nil) {
        _items = [NSArray array];
    }
    return _items;
}

#pragma mark - <MGADataSource>

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