//
//  DemoViewController.h
//  MALoggingViewController
//
//  Created by Mike on 8/13/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MALoggingViewController.h"
#import "AppDelegate.h"

@interface DemoViewController : UIViewController {
    AppDelegate *_appDelegate;
}

@property (nonatomic, retain) MALoggingViewController *loggingVC;

@end
