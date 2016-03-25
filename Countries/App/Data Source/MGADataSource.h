//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MGADataSource <NSObject>

- (NSUInteger)numberOfSections;
- (NSUInteger)numberOfObjectsInSection:(NSUInteger)section;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

@end