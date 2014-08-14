//
//  MALoggingViewController.h
//  MALoggingViewController
//
//  Created by Mike on 8/8/14.
//  Copyright (c) 2014 Mike Amaral. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MALoggingViewController : UIViewController {
    UITextView *_textView;
    CGFloat _currentFontSize;
}

- (void)logToView:(NSString *)format, ...;

@end
