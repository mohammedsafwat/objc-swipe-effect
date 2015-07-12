//
//  ViewState.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef CGFloat RotationDirection;
extern const RotationDirection RotationAwayFromCenter;
extern const RotationDirection RotationTowardsCenter;

@interface ViewState : NSObject
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, assign) CGAffineTransform originalTransform;
@property (nonatomic, assign) RotationDirection rotationDirection;
@end
