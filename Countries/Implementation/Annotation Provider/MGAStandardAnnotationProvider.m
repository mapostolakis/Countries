//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "MGAStandardAnnotationProvider.h"
#import "MGADataSourceProvider.h"
#import "MGASingleSectionDataSource.h"
#import "MGACountry.h"
#import "MGACountryAnnotationBuilder.h"

@interface MGAStandardAnnotationProvider ()

@property (nonatomic, readonly) id <MGADataSourceProvider> dataSourceProvider;

@end

@implementation MGAStandardAnnotationProvider

- (instancetype)initWithDataSourceProvider:(id <MGADataSourceProvider>)dataSourceProvider
{
    self = [super init];
    if (self) {
        _dataSourceProvider = dataSourceProvider;
    }
    return self;
}

- (NSArray <id <MKAnnotation>> *)createCountryListAnnotations
{
    NSMutableArray *annotations = [NSMutableArray array];
    MGASingleSectionDataSource *dataSource = [self.dataSourceProvider createCountryListDataSource];
    for (id <MGACountry> country in dataSource.items) {
        MGACountryAnnotation *annotation = [[[MGACountryAnnotationBuilder alloc] initWithCountry:country] build];
        [annotations addObject:annotation];
    }
    return [annotations copy];
}

@end