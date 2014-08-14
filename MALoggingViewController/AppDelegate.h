//
//  AppDelegate.h
//  MALoggingViewController
//
//  Created by Mike on 8/8/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MALoggingViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MALoggingViewController *logger;

+ (AppDelegate *)sharedAppDelegate;

@end
