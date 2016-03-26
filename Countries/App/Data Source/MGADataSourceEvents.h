//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@protocol MGADataSourceEvents <NSObject>

@property (nonatomic, readonly) RACSignal *contentWillChangeSignal;
@property (nonatomic, readonly) RACSignal *indexSetForInsertedSectionsSignal;
@property (nonatomic, readonly) RACSignal *indexSetForDeletedSectionsSignal;
@property (nonatomic, readonly) RACSignal *indexPathsForInsertedObjectsSignal;
@property (nonatomic, readonly) RACSignal *indexPathsForUpdatedObjectsSignal;
@property (nonatomic, readonly) RACSignal *indexPathsForDeletedObjectsSignal;
@property (nonatomic, readonly) RACSignal *contentDidChangeSignal;

@end