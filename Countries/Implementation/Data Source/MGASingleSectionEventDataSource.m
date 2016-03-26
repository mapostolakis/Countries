//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGASingleSectionEventDataSource.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MGASingleSectionEventDataSource ()

@property (nonatomic, readonly) RACSignal *event;
@property (nonatomic, strong) NSArray *items;

@property (nonatomic, strong) RACSubject *contentWillChangeSignal;
@property (nonatomic, strong) RACSubject *indexSetForInsertedSectionsSignal;
@property (nonatomic, strong) RACSubject *indexSetForDeletedSectionsSignal;
@property (nonatomic, strong) RACSubject *indexPathsForInsertedObjectsSignal;
@property (nonatomic, strong) RACSubject *indexPathsForUpdatedObjectsSignal;
@property (nonatomic, strong) RACSubject *indexPathsForDeletedObjectsSignal;
@property (nonatomic, strong) RACSubject *contentDidChangeSignal;

@end

@implementation MGASingleSectionEventDataSource

- (instancetype)initWithEvent:(RACSignal *)signal
{
    self = [super init];
    if (self) {
        _event = signal;
    }
    return self;
}

- (void)start
{
    @weakify(self);
    [self.event subscribeNext:^(NSArray *value) {
        @strongify(self);
        self.items = [value copy];
        [self.contentDidChangeSignal sendNext:value];
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

#pragma mark - <MGADataSourceEvents>

- (RACSubject *)contentWillChangeSignal
{
    if (_contentWillChangeSignal == nil) {
        _contentWillChangeSignal = [RACSubject subject];
    }
    return _contentWillChangeSignal;
}

- (RACSubject *)contentDidChangeSignal
{
    if (_contentDidChangeSignal == nil) {
        _contentDidChangeSignal = [RACSubject subject];
    }
    return _contentDidChangeSignal;
}

- (RACSubject *)indexPathsForInsertedObjectsSignal
{
    if (_indexPathsForInsertedObjectsSignal == nil) {
        _indexPathsForInsertedObjectsSignal = [RACSubject subject];
    }
    return _indexPathsForInsertedObjectsSignal;
}

- (RACSubject *)indexPathsForUpdatedObjectsSignal
{
    if (_indexPathsForUpdatedObjectsSignal == nil) {
        _indexPathsForUpdatedObjectsSignal = [RACSubject subject];
    }
    return _indexPathsForUpdatedObjectsSignal;
}

- (RACSubject *)indexPathsForDeletedObjectsSignal
{
    if (_indexPathsForDeletedObjectsSignal == nil) {
        _indexPathsForDeletedObjectsSignal = [RACSubject subject];
    }
    return _indexPathsForDeletedObjectsSignal;
}

- (RACSubject *)indexSetForInsertedSectionsSignal
{
    if (_indexSetForInsertedSectionsSignal == nil) {
        _indexSetForInsertedSectionsSignal = [RACSubject subject];
    }
    return _indexSetForInsertedSectionsSignal;
}

- (RACSubject *)indexSetForDeletedSectionsSignal
{
    if (_indexSetForDeletedSectionsSignal == nil) {
        _indexSetForDeletedSectionsSignal = [RACSubject subject];
    }
    return _indexSetForDeletedSectionsSignal;
}

@end