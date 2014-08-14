//
//  DemoViewController.m
//  MALoggingViewController
//
//  Created by Mike on 8/13/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import "DemoViewController.h"
#import "AppDelegate.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (id)init {
    self = [super init];
    
    // get a reference to the share app delegate object
    _appDelegate = [AppDelegate sharedAppDelegate];
    
    [_appDelegate.logger logToView:@"Demo view controller initialized."];
    
    return self;
}


#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Send Request" style:UIBarButtonItemStylePlain target:self action:@selector(sendRequest)];
    
    [_appDelegate.logger logToView:@"View did load."];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_appDelegate.logger logToView:@"View will appear."];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [_appDelegate.logger logToView:@"View did appear."];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [_appDelegate.logger logToView:@"View will disappear."];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [_appDelegate.logger logToView:@"View did disappear."];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [_appDelegate.logger logToView:@"View did layout subviews."];
}


#pragma mark - Navigation button actions

- (void)add {
    [_appDelegate.logger logToView:@"The user has just pressed the 'add' button."];
}

- (void)sendRequest {
    NSString *urlString = @"http://httpbin.org/get";
    NSString *method = @"GET";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:method];
    
    [_appDelegate.logger logToView:@"Sending request to: %@ with method: %@", urlString, method];
    
    NSError *error;
    NSHTTPURLResponse *response = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    if (error) {
        [_appDelegate.logger logToView:@"An error occurred with the request: %@", error.localizedDescription];
    }
    
    else {
        [_appDelegate.logger logToView:@"Got response code: %@ with result: %@", @(response.statusCode), responseDictionary.description];
    }
}

@end
