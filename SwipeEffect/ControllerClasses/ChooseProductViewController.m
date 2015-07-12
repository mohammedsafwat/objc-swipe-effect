//
//  ViewController.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "ChooseProductViewController.h"
#import "Product.h"
#import "ChooseProductView.h"

@interface ChooseProductViewController ()
@property (nonatomic, strong) NSMutableArray* products;
@property (nonatomic, strong) Product* currentProduct;
@property (nonatomic, strong) ChooseProductView* frontCardView;
@property (nonatomic, strong) ChooseProductView* backCardView;
@end

@implementation ChooseProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initializeValues];
    
    // Display the first ChoosePersonView in front. Users can swipe to indicate
    // whether they like or dislike the person displayed.
    self.frontCardView = [self popPersonViewWithFrame:[self frontCardViewFrame]];
    [self.view addSubview:self.frontCardView];
    
    // Display the second ChoosePersonView in back. This view controller uses
    // the SwipeToChooseDelegate protocol methods to update the front and
    // back views after each user swipe.
    self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]];
    [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
}

- (void)initializeValues {
    
    self.products = [NSMutableArray arrayWithArray:@[
                                                     [[Product alloc]initWithName:@"Product1" productID:1 productPrice:100 productImage:[UIImage imageNamed:@"Product1"]],
                                                     [[Product alloc]initWithName:@"Product2" productID:2 productPrice:200 productImage:[UIImage imageNamed:@"Product2"]],
                                                     [[Product alloc]initWithName:@"Product3" productID:3 productPrice:300 productImage:[UIImage imageNamed:@"Product3"]],
                                                     [[Product alloc]initWithName:@"Product4" productID:4 productPrice:400 productImage:[UIImage imageNamed:@"Product4"]],
                                                     [[Product alloc]initWithName:@"Product5" productID:5 productPrice:500 productImage:[UIImage imageNamed:@"Product5"]],
                                                     [[Product alloc]initWithName:@"Product6" productID:6 productPrice:300 productImage:[UIImage imageNamed:@"Product6"]],
                                                     [[Product alloc]initWithName:@"Product7" productID:7 productPrice:300 productImage:[UIImage imageNamed:@"Product7"]],
                                                     [[Product alloc]initWithName:@"Product8" productID:8 productPrice:300 productImage:[UIImage imageNamed:@"Product8"]],
                                                     [[Product alloc]initWithName:@"Product9" productID:9 productPrice:900 productImage:[UIImage imageNamed:@"Product9"]],
                                                     [[Product alloc]initWithName:@"Product10" productID:10 productPrice:1000 productImage:[UIImage imageNamed:@"Product10"]]
                                                     ]
                    ];
}

- (ChooseProductView *)popPersonViewWithFrame:(CGRect)frame {
    if ([self.products count] == 0) {
        return nil;
    }
    
    // UIView+SwipeToChoose and SwipeToChooseView are heavily customizable.
    // Each take an "options" argument. Here, we specify the view controller as
    // a delegate, and provide a custom callback that moves the back card view
    // based on how far the user has panned the front card view.
    SwipeToChooseViewOptions *options = [[SwipeToChooseViewOptions alloc]init];
    options.delegate = self;
    options.threshold = 160.f;
    
    options.onPan = ^(PanState *state){
        CGRect frame = [self backCardViewFrame];
        self.backCardView.frame = CGRectMake(frame.origin.x,
                                             frame.origin.y - (state.thresholdRatio * 10.f),
                                             CGRectGetWidth(frame),
                                             CGRectGetHeight(frame));
    };
    
    ChooseProductView* productView = [[ChooseProductView alloc] initWithFrame:frame product:self.products[0] options:options];
    [self.products removeObjectAtIndex:0];
    return productView;
}

#pragma mark View Contruction

- (CGRect)frontCardViewFrame {
    CGFloat horizontalPadding = 40.f;
    CGFloat topPadding = 60.f;
    CGFloat bottomPadding = 200.f;
    return CGRectMake(horizontalPadding,
                      topPadding,
                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
                      CGRectGetHeight(self.view.frame) - bottomPadding);
}

- (CGRect)backCardViewFrame {
    CGRect frontFrame = [self frontCardViewFrame];
    return CGRectMake(frontFrame.origin.x,
                      frontFrame.origin.y + 20.f,
                      CGRectGetWidth(frontFrame),
                      CGRectGetHeight(frontFrame));
}

#pragma mark - SwipeToChooseDelegate Callbacks

- (void)viewDidCancelSwipe:(UIView *)view {
    NSLog(@"Did cancel swipe.");
}

- (void)view:(UIView *)view wasChosenWithDirection:(SwipeDirection)direction {
    if (direction == SwipeDirectionLeft) {
        NSLog(@"Product deleted");
    }
    else {
        NSLog(@"Product saved");
    }
    
    // SwipeToChooseView removes the view from the view hierarchy
    // after it is swiped (this behavior can be customized via the
    // SwipeOptions class). Since the front card view is gone, we
    // move the back card to the front, and create a new back card.
    self.frontCardView = self.backCardView;
    if ((self.backCardView = [self popPersonViewWithFrame:[self backCardViewFrame]])) {
        // Fade the back card into view.
        self.backCardView.alpha = 0.f;
        [self.view insertSubview:self.backCardView belowSubview:self.frontCardView];
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.backCardView.alpha = 1.f;
                         } completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
