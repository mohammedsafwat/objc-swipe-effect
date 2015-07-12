//
//  SwipeOptions.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "SwipeOptions.h"
#import "SwipeToChoose.h"
#import "Geometry.h"

@implementation SwipeOptions
#pragma mark - Object Lifecycle

- (instancetype)init {
    self = [super init];
    if (self) {
        self.swipeCancelledAnimationDuration = 0.2;
        self.swipeCancelledAnimationOptions = UIViewAnimationOptionCurveEaseOut;
        self.swipeAnimationDuration = 0.1;
        self.swipeAnimationOptions = UIViewAnimationOptionCurveEaseIn;
        self.rotationFactor = 3.f;
        
        self.onChosen = [[self class] exitScreenOnChosenWithDuration:0.1
                                                         options:UIViewAnimationOptionCurveLinear];
    }
    return self;
}

#pragma mark - Public Interface

+ (SwipeToChooseOnChosenBlock)exitScreenOnChosenWithDuration:(NSTimeInterval)duration
                                                        options:(UIViewAnimationOptions)options {
    return ^(SwipeResult *state) {
        CGRect destination = CGRectExtendedOutOfBounds(state.view.frame,
                                                          state.view.superview.bounds,
                                                          state.translation);
        [UIView animateWithDuration:duration
                              delay:0.0
                            options:options
                         animations:^{
                             state.view.frame = destination;
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 [state.view removeFromSuperview];
                                 state.onCompletion();
                             }
                         }];
    };
}

@end
