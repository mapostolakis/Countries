//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAResourceMapper.h"

@interface MGAListResourceMapper : NSObject <MGAResourceMapper>

- (instancetype)initWithResourceMapper:(id <MGAResourceMapper>)resourceMapper;

@end