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

@property (nonatomic, strong) NSString *testMessage;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.testMessage = @"This is ChopeToastViewDemo!\n:)";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchShow:(id)sender
{
    [[ChopeToastView ToastViewWithMessage:self.testMessage] show];
}

- (IBAction)touchShowWithDuration:(id)sender
{
    [[ChopeToastView ToastViewWithMessage:self.testMessage] showWithDuration:0.5];
}

- (IBAction)touchShowWithAnimation:(id)sender
{
    [[ChopeToastView ToastViewWithMessage:self.testMessage] showWithAnimation:^(ChopeToastView *toastView) {
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
    ChopeToastView *toastView = [ChopeToastView ToastViewWithMessage:self.testMessage];
    toastView.font = [UIFont systemFontOfSize:20.0];
    toastView.backgroundColor = [UIColor blueColor];
    toastView.textColor = [UIColor yellowColor];
//    toastView.backgroundAlpha = 1.0;
    toastView.margin = UIEdgeInsetsMake(0, 0, 300, 0);
    toastView.padding = UIEdgeInsetsMake(20, 20, 20, 20);
    toastView.roundRadius = 40;
    [toastView show];
}

- (IBAction)touchAppearance:(id)sender
{
    [[ChopeToastView appearance] setFont:[UIFont systemFontOfSize:10.0]];
    [[ChopeToastView appearance] setBackgroundColor:[UIColor colorWithRed:0 green:1 blue:0 alpha:0.5]];
    [[ChopeToastView appearance] setTextColor:[UIColor redColor]];
    [[ChopeToastView appearance] setPadding:UIEdgeInsetsMake(20, 20, 20, 20)];
    [[ChopeToastView appearance] setMargin:UIEdgeInsetsMake(1, 1, 1, 1)];
    [[ChopeToastView appearance] setRoundRadius:30.0];
}

@end
