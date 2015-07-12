//
//  Geometry.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern CGPoint CGPointAdd(const CGPoint a, const CGPoint b);
extern CGPoint CGPointSubtract(const CGPoint minuend, const CGPoint subtrahend);
extern CGFloat DegreesToRadians(const CGFloat degrees);
extern CGRect CGRectExtendedOutOfBounds(const CGRect rect, const CGRect bounds, const CGPoint translation);
