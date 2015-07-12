//
//  Product.m
//  SwipeEffect
//
//  Created by Mohammad Safwat on 7/3/15.
//  Copyright (c) 2015 Spyros. All rights reserved.
//

#import "Product.h"

@implementation Product
- (instancetype)initWithName:(NSString *)name productID:(NSInteger)productID productPrice:(float)productPrice productImage:(UIImage*)productImage{
    self = [super init];
    if(self) {
        self.name = name;
        self.productID = productID;
        self.productPrice = productPrice;
        self.productImage = productImage;
    }
    return self;
}
@end
