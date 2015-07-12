//
//  SwipeResult.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SwipeDirection.h"

typedef void (^SwipedOnCompletionBlock)(void);

@interface SwipeResult : NSObject

@property (nonatomic, strong) UIView *view;
@property (nonatomic, assign) CGPoint translation;
@property (nonatomic, assign) SwipeDirection direction;

// A callback to be executed after any animations performed by the
// SwipeOptions 'onChosen' callback.
@property (nonatomic, copy) SwipedOnCompletionBlock onCompletion;
@end
