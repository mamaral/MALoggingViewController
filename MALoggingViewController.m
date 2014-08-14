//
//  MALoggingViewController.m
//  MALoggingViewController
//
//  Created by Mike on 8/8/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import "MALoggingViewController.h"

static CGFloat const kMALoggingViewDefaultFontSize = 17;
static CGFloat const kMALoggingViewMinFontSize = 10;
static CGFloat const kMALoggingViewMaxFontSize = 25;

static NSString * const kMALoggingViewDefaultFont = @"Courier-Bold";

@interface MALoggingViewController ()

@end

@implementation MALoggingViewController

- (instancetype)init {
    self = [super init];
    
    // set the initial font size to the default
    _currentFontSize = kMALoggingViewDefaultFontSize;
    
    // generate the textView at init-time, rather than you normally may during
    // viewDidLoad, because if we were to wait until the view loaded nothing
    // prior to this view's tab being selected would be added to the view
    [self generateTextView];
    
    return self;
}


#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make it look cool like the console
    self.view.backgroundColor = [UIColor blackColor];
    
    // we don't want anything to be hidden under the tab bar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // set the left and right nav buttons to increase and decrease the font size for readability
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Shrink Font" style:UIBarButtonItemStylePlain target:self action:@selector(decreaseFontSize)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Grow Font" style:UIBarButtonItemStylePlain target:self action:@selector(increaseFontSize)];
}


#pragma mark - Navigation button actions

- (void)increaseFontSize {
    // increase the font size as long as we're not at the max
    if (_currentFontSize >= kMALoggingViewMaxFontSize) {
        return;
    }
    
    _currentFontSize++;
    _textView.font = [UIFont fontWithName:kMALoggingViewDefaultFont size:_currentFontSize];
}

- (void)decreaseFontSize {
    // decrease the font size as long as we're not at the min
    if (_currentFontSize <= kMALoggingViewMinFontSize) {
        return;
    }
    
    _currentFontSize--;
    _textView.font = [UIFont fontWithName:kMALoggingViewDefaultFont size:_currentFontSize];
}


#pragma mark - Text view stuff

- (void)generateTextView {
    // generate the view, add it to the frame, make it resize according
    // to rotation, disable editing, make it look pretty, and add it as a subview
    _textView = [[UITextView alloc] initWithFrame:self.view.frame];
    _textView.backgroundColor = [UIColor blackColor];
    _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth + UIViewAutoresizingFlexibleHeight;
    _textView.editable = NO;
    _textView.font = [UIFont fontWithName:kMALoggingViewDefaultFont size:_currentFontSize];
    _textView.textColor = [UIColor whiteColor];
    [self.view addSubview:_textView];
}

- (void)scrollToBottom {
    // TODO: find a less hacky way of scrolling to the bottom
    [_textView scrollRangeToVisible:NSMakeRange(_textView.text.length, 0)];
    [_textView setScrollEnabled:NO];
    [_textView setScrollEnabled:YES];
}


#pragma mark - Logging

- (void)logToView:(NSString *)format, ... {
    // if we weren't provided any data, bail
    if (!format) {
        return;
    }
    
    // get the format and the args
    va_list args, args_copy;
    va_start(args, format);
    va_copy(args_copy, args);
    va_end(args);
    
    // create the log text from the format and args
    NSString *logText = [[NSString alloc] initWithFormat:format arguments:args_copy];
    
    // get the timestamp
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSString *dateString = [formatter stringFromDate:now];
    
    // append the timestamp and log text just like NSLog would
    _textView.text = [_textView.text stringByAppendingFormat:@"%@ %@\n", dateString, logText];
    
    // scroll the view down
    [self scrollToBottom];
    
    // log the text to the console normally
    NSLog(@"%@", logText);
    
    va_end(args_copy);
}

@end
