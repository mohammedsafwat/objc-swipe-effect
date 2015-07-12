//
//  SwipeToChooseDelegate.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeDirection.h"

@protocol SwipeToChooseDelegate <NSObject>
@optional

// When the view was not swiped past the selection threshold.
- (void)viewDidCancelSwipe:(UIView *)view;

// Return NO to prevent choice, and YES to make a choice.
- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(SwipeDirection)direction;

// After a choice has been made, this method gets called and removes the view from
// the view hierarchy.
- (void)view:(UIView *)view wasChosenWithDirection:(SwipeDirection)direction;

@end

