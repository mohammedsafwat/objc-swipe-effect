//
//  SwipeToChooseView.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwipeToChooseViewOptions;

@interface SwipeToChooseView : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *likedView;
@property (nonatomic, strong) UIView *nopeView;
- (instancetype)initWithFrame:(CGRect)frame options:(SwipeToChooseViewOptions *)options;
@end
