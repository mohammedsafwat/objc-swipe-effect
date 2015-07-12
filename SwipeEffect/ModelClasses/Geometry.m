//
//  Geometry.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "Geometry.h"

CGPoint CGPointAdd(const CGPoint a, const CGPoint b) {
    return CGPointMake(a.x + b.x,
                       a.y + b.y);
}

CGPoint CGPointSubtract(const CGPoint minuend, const CGPoint subtrahend) {
    return CGPointMake(minuend.x - subtrahend.x,
                       minuend.y - subtrahend.y);
}

CGFloat DegreesToRadians(const CGFloat degrees) {
    return degrees * (M_PI/180.0);
}

CGRect CGRectExtendedOutOfBounds(const CGRect rect,
                                    const CGRect bounds,
                                    const CGPoint translation) {
    CGRect destination = rect;
    while (!CGRectIsNull(CGRectIntersection(bounds, destination))) {
        destination = CGRectMake(CGRectGetMinX(destination) + translation.x,
                                 CGRectGetMinY(destination) + translation.y,
                                 CGRectGetWidth(destination),
                                 CGRectGetHeight(destination));
    }
    
    return destination;
}
