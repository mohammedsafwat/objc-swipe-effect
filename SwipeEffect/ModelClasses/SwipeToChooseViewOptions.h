//
//  SwipeToChooseViewOptions.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SwipeOptions.h"

@interface SwipeToChooseViewOptions : NSObject
@property (nonatomic, weak) id<SwipeToChooseDelegate> delegate;
@property (nonatomic, assign) CGFloat threshold;
@property (nonatomic, copy) SwipeToChooseOnPanBlock onPan;

@end
