//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAListResourceMapper.h"

@interface MGAListResourceMapper ()

@property (nonatomic, readonly) id <MGAResourceMapper> resourceMapper;

@end

@implementation MGAListResourceMapper

- (instancetype)initWithResourceMapper:(id <MGAResourceMapper>)resourceMapper
{
    self = [super init];
    if (self) {
        _resourceMapper = resourceMapper;
    }
    return self;
}

- (NSArray *)mapResource:(NSArray *)resource
{
    NSMutableArray *mappedResources = [NSMutableArray array];
    for (NSDictionary *dictionary in resource) {
        id mappedResource = [self.resourceMapper mapResource:dictionary];
        [mappedResources addObject:mappedResource];
    }
    return [mappedResources copy];
}

@end