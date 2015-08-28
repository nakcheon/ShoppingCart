//
//  ShopingItemInputView.h
//  ShoppingCart
//
//  Created by NakCheonJung on 12/8/14.
//  Copyright (c) 2014 NakCheonJung. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopingItemInputViewDelegate
-(void)itemInfoInputFinished:(NSString*)itemName price:(int)price count:(int)count;
@end

@interface ShopingItemInputView : UIView <UITextFieldDelegate>

@property (nonatomic, assign) id<ShopingItemInputViewDelegate> delegate;

@property (nonatomic, retain) IBOutlet UITextField* itemNameInput;
@property (nonatomic, retain) IBOutlet UITextField* itemCountInput;
@property (nonatomic, retain) IBOutlet UITextField* itemPriceInput;
@property (nonatomic, retain) IBOutlet UIButton* btnDone;
@property (nonatomic, retain) IBOutlet UIButton* btnCancel;

@end
