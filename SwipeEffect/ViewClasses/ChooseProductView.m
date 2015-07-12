//
//  ChooseProductView.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "ChooseProductView.h"

@interface ChooseProductView()
@property (nonatomic, strong) UIView *informationView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation ChooseProductView

- (instancetype)initWithFrame:(CGRect)frame product:(Product *)product options:(SwipeToChooseViewOptions *)options
{
    self = [super initWithFrame:frame options:options];
    if(self) {
        self.product = product;
        self.imageView.image = product.productImage;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleBottomMargin;
        self.imageView.autoresizingMask = self.autoresizingMask;
        
        [self constructInformationView];
    }
    return self;
}

#pragma mark - Internal Methods

- (void)constructInformationView {
    CGFloat bottomHeight = 60.f;
    CGRect bottomFrame = CGRectMake(0,
                                    CGRectGetHeight(self.bounds) - bottomHeight,
                                    CGRectGetWidth(self.bounds),
                                    bottomHeight);
    self.informationView = [[UIView alloc] initWithFrame:bottomFrame];
    self.informationView.backgroundColor = [UIColor colorWithRed:108.0f/255.0f green:122.0f/255.0f blue:137.0f/255.0f alpha:0.8f];
    self.informationView.clipsToBounds = YES;
    self.informationView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleTopMargin;
    [self addSubview:self.informationView];
    
    [self constructNameLabel];
    [self constructPriceLabel];
}

- (void)constructNameLabel {
    CGFloat leftPadding = 12.f;
    CGFloat topPadding = -17.0f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(self.informationView.frame)/2),
                              CGRectGetHeight(self.informationView.frame) - topPadding);
    self.nameLabel = [[UILabel alloc] initWithFrame:frame];
    self.nameLabel.text = self.product.name;
    self.nameLabel.font = [UIFont systemFontOfSize:20.0f];
    self.nameLabel.textColor = [UIColor whiteColor];
    [self.informationView addSubview:self.nameLabel];
}

- (void)constructPriceLabel {
    CGFloat leftPadding = 12.0f;
    CGFloat topPadding = 30.0f;
    CGRect frame = CGRectMake(leftPadding,
                              topPadding,
                              floorf(CGRectGetWidth(self.informationView.frame)/2),
                              CGRectGetHeight(self.informationView.frame) - topPadding);
    self.priceLabel = [[UILabel alloc] initWithFrame:frame];
    self.priceLabel.text = [NSString stringWithFormat:@"$%0.2f", self.product.productPrice];
    self.priceLabel.font = [UIFont systemFontOfSize:16.0f];
    self.priceLabel.textColor = [UIColor colorWithRed:(219.0f/255.0f) green:(10.0f/255.0f) blue:(91.0f/205.0f) alpha:1.0f];
    [self.informationView addSubview:self.priceLabel];
}
@end
