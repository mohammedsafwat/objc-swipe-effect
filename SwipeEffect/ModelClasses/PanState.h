//
//  PanState.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SwipeDirection.h"

@interface PanState : NSObject
@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign) SwipeDirection direction;

// The ratio of the threshold that has been reached.
// Threshold is any value between 0 and 1. 1 means that the threshold has
// been reached.
@property (nonatomic, assign) CGFloat thresholdRatio;

@end
