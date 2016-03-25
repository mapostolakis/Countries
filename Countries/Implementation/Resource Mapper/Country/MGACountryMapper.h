//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAResourceMapper.h"

@protocol MGACountryGateway;

@interface MGACountryMapper : NSObject <MGAResourceMapper>

- (instancetype)initWithGateway:(id <MGACountryGateway>)gateway listMapper:(id <MGAResourceMapper>)mapper;

@end