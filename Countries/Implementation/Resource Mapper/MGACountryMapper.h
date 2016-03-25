//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAResourceMapper.h"

@protocol MGAGateway;

@interface MGACountryMapper : NSObject <MGAResourceMapper>

- (instancetype)initWithGateway:(id <MGAGateway>)gateway listMapper:(id <MGAResourceMapper>)mapper;

@end