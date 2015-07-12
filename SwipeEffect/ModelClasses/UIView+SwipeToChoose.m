//
//  UIView+SwipeToChoose.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "UIView+SwipeToChoose.h"
#import "SwipeToChoose.h"
#import "ViewState.h"
#import "Geometry.h"
#import <objc/runtime.h>

const void * const SwipeOptionsKey = &SwipeOptionsKey;
const void * const ViewStateKey = &ViewStateKey;

@implementation UIView (SwipeToChoose)

- (void)swipeToChooseSetup:(SwipeOptions *)options {
    [self set_options:options ? options : [SwipeOptions new]];
    [self set_viewState:[ViewState new]];
    self.viewState.originalCenter = self.center;
    
    [self setupPanGestureRecognizer];
}

- (void)swipe:(SwipeDirection)direction {
    [self swipeToChooseSetupIfNecessary];
    
    // A swipe in no particular direction "finalizes" the swipe.
    if (direction == SwipeDirectionNone) {
        [self finalizePosition];
        return;
    }
    
    // Moves the view to the minimum point exceeding the threshold.
    // Transforms and executes pan callbacks as well.
    void (^animations)(void) = ^{
        CGPoint translation = [self translationExceedingThreshold:self.m_options.threshold direction:direction];
        self.center = CGPointAdd(self.center, translation);
        [self rotateForTranslation:translation
                     rotationDirection:RotationAwayFromCenter];
        [self executeOnPanBlockForTranslation:translation];
    };
    
    // Finalize upon completion of the animations.
    void (^completion)(BOOL) = ^(BOOL finished) {
        if (finished) { [self finalizePosition]; }
    };
    
    [UIView animateWithDuration:self.m_options.swipeAnimationDuration delay:0.0 options:self.m_options.swipeAnimationOptions animations:animations completion:completion];
}

#pragma mark - Internal Methods

- (void)set_options:(SwipeOptions *)options {
    objc_setAssociatedObject(self, SwipeOptionsKey, options, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SwipeOptions *)m_options {
    return objc_getAssociatedObject(self, SwipeOptionsKey);
}

- (void)set_viewState:(ViewState *)state {
    objc_setAssociatedObject(self, ViewStateKey, state, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ViewState *)viewState {
    return objc_getAssociatedObject(self, ViewStateKey);
}

#pragma mark Setup

- (void)swipeToChooseSetupIfNecessary {
    if (!self.m_options || !self.viewState) {
        [self swipeToChooseSetup:nil];
    }
}

- (void)setupPanGestureRecognizer {
    SEL action = @selector(onSwipeToChoosePanGestureRecognizer:);
    UIPanGestureRecognizer *panGestureRecognizer =
    [[UIPanGestureRecognizer alloc] initWithTarget:self
                                            action:action];
    [self addGestureRecognizer:panGestureRecognizer];
}

#pragma mark Translation

- (void)finalizePosition {
    SwipeDirection direction = [self directionOfExceededThreshold];
    switch (direction) {
        case SwipeDirectionRight:
        case SwipeDirectionLeft: {
            CGPoint translation = CGPointSubtract(self.center,
                                                     self.viewState.originalCenter);
            [self exitSuperviewFromTranslation:translation];
            break;
        }
        case SwipeDirectionNone:
            [self returnToOriginalCenter];
            [self executeOnPanBlockForTranslation:CGPointZero];
            break;
    }
}

- (void)returnToOriginalCenter {
    [UIView animateWithDuration:self.m_options.swipeCancelledAnimationDuration
                          delay:0.0
                        options:self.m_options.swipeCancelledAnimationOptions
                     animations:^{
                         self.transform = self.viewState.originalTransform;
                         self.center = self.viewState.originalCenter;
                     } completion:^(BOOL finished) {
                         id<SwipeToChooseDelegate> delegate = self.m_options.delegate;
                         if ([delegate respondsToSelector:@selector(viewDidCancelSwipe:)]) {
                             [delegate viewDidCancelSwipe:self];
                         }
                     }];
}

- (void)exitSuperviewFromTranslation:(CGPoint)translation {
    SwipeDirection direction = [self directionOfExceededThreshold];
    id<SwipeToChooseDelegate> delegate = self.m_options.delegate;
    if ([delegate respondsToSelector:@selector(view:shouldBeChosenWithDirection:)]) {
        BOOL should = [delegate view:self shouldBeChosenWithDirection:direction];
        if (!should) {
            return;
        }
    }
    
    SwipeResult *state = [SwipeResult new];
    state.view = self;
    state.translation = translation;
    state.direction = direction;
    state.onCompletion = ^{
        if ([delegate respondsToSelector:@selector(view:wasChosenWithDirection:)]) {
            [delegate view:self wasChosenWithDirection:direction];
        }
    };
    self.m_options.onChosen(state);
}

- (void)executeOnPanBlockForTranslation:(CGPoint)translation {
    if (self.m_options.onPan) {
        CGFloat thresholdRatio = MIN(1.f, fabsf(translation.x)/self.m_options.threshold);
        
        SwipeDirection direction = SwipeDirectionNone;
        if (translation.x > 0.f) {
            direction = SwipeDirectionRight;
        } else if (translation.x < 0.f) {
            direction = SwipeDirectionLeft;
        }
        
        PanState *state = [PanState new];
        state.view = self;
        state.direction = direction;
        state.thresholdRatio = thresholdRatio;
        self.m_options.onPan(state);
    }
}

#pragma mark Rotation

- (void)rotateForTranslation:(CGPoint)translation
               rotationDirection:(RotationDirection)rotationDirection {
    CGFloat rotation = DegreesToRadians(translation.x/100 * self.m_options.rotationFactor);
    self.transform = CGAffineTransformRotate(self.viewState.originalTransform,
                                             rotationDirection * rotation);
}

#pragma mark Threshold

- (CGPoint)translationExceedingThreshold:(CGFloat)threshold
                                   direction:(SwipeDirection)direction {
    NSParameterAssert(direction != SwipeDirectionNone);
    
    CGFloat offset = threshold + 1.f;
    switch (direction) {
        case SwipeDirectionLeft:
            return CGPointMake(-offset, 0);
        case SwipeDirectionRight:
            return CGPointMake(offset, 0);
        default:
            [NSException raise:NSInternalInconsistencyException
                        format:@"Invallid direction argument."];
            return CGPointZero;
    }
}

- (SwipeDirection)directionOfExceededThreshold {
    if (self.center.x > self.viewState.originalCenter.x + self.m_options.threshold) {
        return SwipeDirectionRight;
    } else if (self.center.x < self.viewState.originalCenter.x - self.m_options.threshold) {
        return SwipeDirectionLeft;
    } else {
        return SwipeDirectionNone;
    }
}

#pragma mark Gesture Recognizer Events

- (void)onSwipeToChoosePanGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    UIView *view = panGestureRecognizer.view;
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.viewState.originalCenter = view.center;
        self.viewState.originalTransform = view.transform;
        
        // If the pan gesture originated at the top half of the view, rotate the view
        // away from the center. Otherwise, rotate towards the center.
        if ([panGestureRecognizer locationInView:view].y < view.center.y) {
            self.viewState.rotationDirection = RotationAwayFromCenter;
        } else {
            self.viewState.rotationDirection = RotationTowardsCenter;
        }
    } else if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // Either move the view back to its original position or move it off screen.
        [self finalizePosition];
    } else {
        // Update the position and transform. Then, notify any listeners of
        // the updates via the pan block.
        CGPoint translation = [panGestureRecognizer translationInView:view];
        view.center = CGPointAdd(self.viewState.originalCenter, translation);
        [self rotateForTranslation:translation
                     rotationDirection:self.viewState.rotationDirection];
        [self executeOnPanBlockForTranslation:translation];
    }
}

@end
