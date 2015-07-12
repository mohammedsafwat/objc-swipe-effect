//
//  UIView+SwipeToChoose.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeDirection.h"

@class SwipeOptions;

@interface UIView (SwipeToChoose)
- (void)swipeToChooseSetup:(SwipeOptions*)options;
- (void)swipe:(SwipeDirection)direction;

@end
