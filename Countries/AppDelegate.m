//
//  Copyright © 2016 Mike Apostolakis. All rights reserved.
//

#import "AppDelegate.h"
#import "MGADependencies.h"

@interface AppDelegate ()

@property (nonatomic, strong) MGADependencies *dependencies;

@end

@implementation AppDelegate

- (MGADependencies *)dependencies
{
    if (_dependencies == nil) {
        _dependencies = [MGADependencies new];
        [_dependencies start];
    }
    return _dependencies;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect frame = [UIScreen mainScreen].bounds;
    self.window = [[UIWindow alloc] initWithFrame:frame];
    self.window.rootViewController = [self.dependencies rootViewController];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
