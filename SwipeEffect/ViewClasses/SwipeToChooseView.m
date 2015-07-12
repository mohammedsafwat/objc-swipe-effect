//
//  SwipeToChooseView.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "SwipeToChooseView.h"
#import "SwipeToChoose.h"
#import "Geometry.h"
#import <QuartzCore/QuartzCore.h>

@interface SwipeToChooseView()
@property (nonatomic, strong) SwipeToChooseViewOptions *options;
@end

@implementation SwipeToChooseView

- (instancetype)initWithFrame:(CGRect)frame options:(SwipeToChooseViewOptions *)options {
    self = [super initWithFrame:frame];
    if(self) {
        self.options = options ? options : [SwipeToChooseViewOptions new];
        [self setupView];
        [self constructImageView];
        [self setupSwipeToChoose];
    }
    return self;
}

- (void)setupView {
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 2.f;
    self.layer.borderColor = [UIColor grayColor].CGColor;
}

- (void)constructImageView {
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
}

- (void)setupSwipeToChoose {
    SwipeOptions *options = [[SwipeOptions alloc]init];
    options.delegate = self.options.delegate;
    options.threshold = self.options.threshold;
    
    __block UIView *likedImageView = self.likedView;
    __block UIView *nopeImageView = self.nopeView;
    __weak SwipeToChooseView *weakself = self;
    options.onPan = ^(PanState *state) {
        if (state.direction == SwipeDirectionNone) {
            likedImageView.alpha = 0.f;
            nopeImageView.alpha = 0.f;
            self.imageView.alpha = 1.0f;
        } else if (state.direction == SwipeDirectionLeft) {
            likedImageView.alpha = 0.f;
            nopeImageView.alpha = state.thresholdRatio;
            self.imageView.alpha = 1 - (state.thresholdRatio * 0.5);
        } else if (state.direction == SwipeDirectionRight) {
            likedImageView.alpha = state.thresholdRatio;
            nopeImageView.alpha = 0.f;
            self.imageView.alpha = 1 - (state.thresholdRatio * 0.5);
        }
        
        if (weakself.options.onPan) {
            weakself.options.onPan(state);
        }
    };
    
    [self swipeToChooseSetup:options];
}

@end
