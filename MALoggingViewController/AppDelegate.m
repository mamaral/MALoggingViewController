//
//  AppDelegate.m
//  MALoggingViewController
//
//  Created by Mike on 8/8/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"
#import "MALoggingViewController.h"

@implementation AppDelegate

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // create the logging view controller and wrap it in its own navigation controller
    MALoggingViewController *loggingVC = [MALoggingViewController new];
    UINavigationController *loggingNC = [[UINavigationController alloc] initWithRootViewController:loggingVC];
    loggingVC.title = @"Logger";
    
    // create the main demo view controller and wrap it in its own navigation controller
    DemoViewController *demoVC = [DemoViewController new];
    UINavigationController *demoNC = [[UINavigationController alloc] initWithRootViewController:demoVC];
    demoVC.title = @"Demo";
    
    // create our tab bar controller
    UITabBarController *tabBarController = [UITabBarController new];
    [tabBarController setViewControllers:@[loggingNC, demoNC]];
    self.window.rootViewController = tabBarController;
    
    // set the logging view controller as our app delegate's
    self.logger = loggingVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self.logger logToView:@"Application: %@", @"became active."];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self.logger logToView:@"Application: %@", @"entered background."];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    [self.logger logToView:@"Application: %@", @"finished launching."];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self.logger logToView:@"Application: %@", @"entered foreground."];
}

@end