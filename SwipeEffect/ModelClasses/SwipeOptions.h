//
//  SwipeOptions.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class PanState;
@class SwipeResult;
@protocol SwipeToChooseDelegate;

typedef void (^SwipeToChooseOnPanBlock)(PanState *state);
typedef void (^SwipeToChooseOnChosenBlock)(SwipeResult *state);

@interface SwipeOptions : NSObject

@property (nonatomic, weak) id<SwipeToChooseDelegate> delegate;
@property (nonatomic, assign) NSTimeInterval swipeCancelledAnimationDuration;
@property (nonatomic, assign) UIViewAnimationOptions swipeCancelledAnimationOptions;
@property (nonatomic, assign) NSTimeInterval swipeAnimationDuration;
@property (nonatomic, assign) UIViewAnimationOptions swipeAnimationOptions;
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, assign) CGFloat rotationFactor;
@property (nonatomic, copy) SwipeToChooseOnPanBlock onPan;
@property (nonatomic, copy) SwipeToChooseOnChosenBlock onChosen;
+ (SwipeToChooseOnChosenBlock)exitScreenOnChosenWithDuration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options;

@end
