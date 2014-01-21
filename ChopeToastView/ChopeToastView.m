//
//  ChopeToastView.m
//  ChopeLibrary
//
//  Created by Chope on 2014. 1. 16..
//  Copyright (c) 2014년 Chope. All rights reserved.
//

#import "ChopeToastView.h"

@implementation ChopeToastView

- (id)init
{
    self = [super init];
    if (self) {
        [self setupDefaultValue];
    }
    
    return self;
}

- (void)setupDefaultValue
{
    [self setFrame:[self window].bounds];
    [self setFont:[UIFont systemFontOfSize:14.0]];
    [self setBackgroundAlpha:0.7];
    [self setTextColor:[UIColor whiteColor]];
    [self setPadding:UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0)];
    [self setMargin:UIEdgeInsetsMake(10.0, 10.0, 80.0, 10.0)];
    [self setRoundRadius:10.0];
    
    [self setBackgroundColor:[UIColor blackColor]];
}

- (UIWindow*)window
{
    return [[UIApplication sharedApplication].windows lastObject];
}


#pragma mark - Draw
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize textSize = [self boundingSizeForMessage];
    CGRect frame = CGRectMake((self.window.frame.size.width - textSize.width - self.padding.left - self.padding.right) / 2.0,
                              self.window.frame.size.height - textSize.height - self.padding.top - self.padding.bottom - self.margin.bottom,
                              textSize.width + self.padding.left + self.padding.right,
                              textSize.height + self.padding.top + self.padding.bottom);
    [self setFrame:frame];
}

- (void)drawRect:(CGRect)rect
{
    CGSize textSize = [self boundingSizeForMessage];

    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:self.message
                                                                           attributes:@{
                                                                                        NSForegroundColorAttributeName: self.textColor,
                                                                                        NSFontAttributeName: self.font
                                                                                        }];
    [attributedString drawInRect:CGRectMake(self.padding.left, self.padding.top, textSize.width, textSize.height)];
    
    self.layer.cornerRadius = self.roundRadius;
    self.layer.masksToBounds = YES;
}

- (CGSize)boundingSizeForMessage
{
    CGSize size = CGSizeMake(self.window.frame.size.width - self.margin.left - self.margin.right - self.padding.left - self.padding.right,
                             CGFLOAT_MAX);
    
    CGSize resultSize;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#
#ifdef __IPHONE_7_0
    // for simulator
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:context:)]) {
        resultSize = [self.message boundingRectWithSize:size
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{ NSFontAttributeName:self.font }
                                                context:nil].size;
    }
    else {
        resultSize = [self.message sizeWithFont:self.font
                              constrainedToSize:size
                                  lineBreakMode:NSLineBreakByWordWrapping];
    }
#else
    resultSize = [self.message sizeWithFont:self.font
                          constrainedToSize:size
                              lineBreakMode:NSLineBreakByWordWrapping];
#endif
#
#pragma clang diagnostic pop
    
    resultSize.width = ceil(resultSize.width);
    resultSize.height = ceil(resultSize.height);
    
    return resultSize;
}


#pragma mark - Default cretate
+ (instancetype)ToastViewWithMessage:(NSString*)message
{
    ChopeToastView *toastView = [[ChopeToastView alloc] init];
    [toastView setMessage:message];
    return toastView;
}


#pragma mark - Show method
- (void)showWithAnimation:(void (^)(ChopeToastView *toastView))animation
{
    [self.window addSubview:self];
    
    if (animation) {
        animation(self);
    }
}

- (void)showWithDuration:(NSTimeInterval)time
{
    [self showWithAnimation:^(ChopeToastView *toastView){
        self.alpha = 0.0;
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             self.alpha = 1.0;
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:0.5
                                                   delay:time
                                                 options:UIViewAnimationOptionTransitionNone
                                              animations:^{
                                                  self.alpha = 0.0;
                                              }
                                              completion:^(BOOL finished) {
                                                  [self hide];
                                              }];
                         }];
    }];
}

- (void)show
{
    [self showWithDuration:3.0];
}

- (void)hide
{
    [self removeFromSuperview];
}


@end
