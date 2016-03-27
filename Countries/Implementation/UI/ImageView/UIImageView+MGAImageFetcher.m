//
// Copyright (c) 2016 Mike Apostolakis. All rights reserved.
//

#import "UIImageView+MGAImageFetcher.h"
#import "objc/runtime.h"

@interface UIImageView (_MGAImageFetcher)

@property (nonatomic, strong, setter=mga_setImageDownloadTask:) NSURLSessionDataTask *mga_imageDownloadTask;

@end

@implementation UIImageView (_MGAImageFetcher)

- (NSURLSessionDataTask *)mga_imageDownloadTask
{
    return (NSURLSessionDataTask *)objc_getAssociatedObject(self, @selector(mga_imageDownloadTask));
}

- (void)mga_setImageDownloadTask:(NSURLSessionDataTask *)mga_imageDownloadTask
{
    objc_setAssociatedObject(self, @selector(mga_imageDownloadTask), mga_imageDownloadTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UIImageView (MGAImageFetcher)

+ (NSCache *)mga_sharedCache
{
    static NSCache *__cache = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        __cache = [NSCache new];
    });
    return __cache;
}

- (void)setImageForURL:(NSURL *)url
{
    UIImage *cacheImage = [[[self class] mga_sharedCache] objectForKey:url.absoluteString];
    if (cacheImage) {
        self.image = cacheImage;
        self.mga_imageDownloadTask = nil;
        return;
    } else {
        self.image = nil;
    }

    [self.mga_imageDownloadTask cancel];

    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    if (!request.URL) { return; }
    self.mga_imageDownloadTask =
            [[NSURLSession sharedSession] dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (!data) { return; }
                                                UIImage *image = [UIImage imageWithData:data];
                                                if (!image) { return; }
                                                [[[self class] mga_sharedCache] setObject:image forKey:url.absoluteString];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    self.image = image;
                                                });
                                            }];

    [self.mga_imageDownloadTask resume];
}

@end