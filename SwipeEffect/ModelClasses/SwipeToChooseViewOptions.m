//
//  SwipeToChooseViewOptions.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "SwipeToChooseViewOptions.h"

@implementation SwipeToChooseViewOptions
- (instancetype)init {
    self = [super init];
    if (self) {
        self.threshold = 100.f;
    }
    return self;
}
@end
