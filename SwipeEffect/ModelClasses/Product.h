//
//  Product.h
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Product : NSObject
@property (nonatomic, copy) NSString* name;
@property (nonatomic, assign) NSInteger productID;
@property (nonatomic, assign) float productPrice;
@property (nonatomic, strong) UIImage* productImage;

- (instancetype)initWithName:(NSString*)name productID:(NSInteger)productID productPrice:(float)productPrice productImage:(UIImage*)productImage;
@end
