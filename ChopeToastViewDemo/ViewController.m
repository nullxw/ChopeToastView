//
//  ViewController.m
//  ChopeToastViewDemo
//
//  Created by Chope on 2014. 1. 17..
//  Copyright (c) 2014년 Chope. All rights reserved.
//

#import "ViewController.h"
#import "ChopeToastView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSString *_message;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _message = @"This is ChopeToastViewDemo!\n:)";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchShow:(id)sender
{
    [[ChopeToastView ToastViewWithMessage:_message] show];
}

- (IBAction)touchShowWithDuration:(id)sender
{
    [[ChopeToastView ToastViewWithMessage:_message] showWithDuration:0.5];
}

- (IBAction)touchShowWithAnimation:(id)sender
{
    [[ChopeToastView ToastViewWithMessage:_message] showWithAnimation:^(ChopeToastView *toastView) {
        CGFloat y = toastView.frame.origin.y;
    
        CGRect frame = toastView.frame;
        frame.origin.y = -1 * toastView.frame.size.height;
        toastView.frame = frame;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             CGRect frame = toastView.frame;
                             frame.origin.y = y;
                             toastView.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.5
                                                   delay:3.0
                                                 options:UIViewAnimationOptionTransitionNone
                                              animations:^{
                                                  CGRect frame = toastView.frame;
                                                  frame.origin.y +=  toastView.frame.size.height;
                                                  toastView.frame = frame;
                                              }
                                              completion:^(BOOL finished) {
                                                  [toastView hide];
                                              }];
                         }];
    }];
}

- (IBAction)touchCustom:(id)sender
{
    ChopeToastView *toastView = [ChopeToastView ToastViewWithMessage:_message];
    toastView.font = [UIFont systemFontOfSize:20.0];
    toastView.backgroundColor = [UIColor blueColor];
    toastView.textColor = [UIColor yellowColor];
    toastView.backgroundAlpha = 1.0;
    toastView.margin = UIEdgeInsetsMake(0, 0, 300, 0);
    toastView.padding = UIEdgeInsetsMake(20, 20, 20, 20);
    toastView.roundRadius = 40;
    [toastView show];
}

@end
