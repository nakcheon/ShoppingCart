//
//  DetailViewController.h
//  ShoppingCart
//
//  Created by NakCheonJung on 12/8/14.
//  Copyright (c) 2014 NakCheonJung. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

