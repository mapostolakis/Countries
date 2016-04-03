//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGADataSource.h"

@interface MGASingleObjectDataSource : NSObject <MGADataSource>

@property (nonatomic, strong) id value;

@end