//
//  ShoppingItemInfo.h
//  ShoppingCart
//
//  Created by NakCheonJung on 12/8/14;
//  Copyright (c) 2014 NakCheonJung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShoppingItemInfo : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, assign) int price;
@property (nonatomic, assign) int count;

@end
