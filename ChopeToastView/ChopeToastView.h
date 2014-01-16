//
//  ChopeToastView.h
//  ChopeLibrary
//
//  Created by Chope on 2014. 1. 16..
//  Copyright (c) 2014년 Chope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChopeToastView : UIView

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, retain) UIColor *textColor;
@property (nonatomic) CGFloat backgroundAlpha;
@property (nonatomic) UIEdgeInsets padding;
@property (nonatomic) UIEdgeInsets margin;
@property (nonatomic) CGFloat roundRadius;

@property (nonatomic, retain) NSString *message;

+ (instancetype)ToastViewWithMessage:(NSString*)message;

- (void)showWithAnimation:(void (^)(ChopeToastView *toastView))animation;
- (void)showWithDuration:(NSTimeInterval)time;
- (void)show;

- (void)hide;

@end
