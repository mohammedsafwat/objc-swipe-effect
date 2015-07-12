//
//  ChooseProductView.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "SwipeToChooseView.h"
#import "Product.h"
#import "SwipeToChoose.h"

@interface ChooseProductView : SwipeToChooseView
@property (nonatomic, strong) Product* product;

- (instancetype)initWithFrame:(CGRect)frame product:(Product*)product options: (SwipeToChooseViewOptions *)options;
@end
