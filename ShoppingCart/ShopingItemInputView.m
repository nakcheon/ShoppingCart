//
//  ShopingItemInputView.m
//  ShoppingCart
//
//  Created by NakCheonJung on 12/8/14.
//  Copyright (c) 2014 NakCheonJung. All rights reserved.
//

#import "ShopingItemInputView.h"

@implementation ShopingItemInputView

#pragma mark - class life cycle

-(id)init
{
    self = [super init];
    if (self) {
        NSLog(@"ShopingItemInputView::INIT");
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        NSLog(@"ShopingItemInputView::INIT");
    }
    return self;
}

-(void)prepareForRelease
{
    
}

-(void)dealloc
{
    NSLog(@"ShopingItemInputView::DEALLOC");
    _delegate = nil;
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [_itemNameInput becomeFirstResponder];
}


#pragma mark - IBActions

-(IBAction)selectorCancelButtonClicked:(id)sender
{
    [_delegate itemInfoInputFinished:@""
                               price:0
                               count:0];
    _delegate = nil;
    [self removeFromSuperview];
}

-(IBAction)selectorDoneButtonClicked:(id)sender
{
    [_delegate itemInfoInputFinished:_itemNameInput.text
                               price:[_itemPriceInput.text intValue]
                               count:[_itemCountInput.text intValue]];
    _delegate = nil;
    [self removeFromSuperview];
}

#pragma mark - UITextFieldDelegate

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
//- (void)textFieldDidBeginEditing:(UITextField *)textField;
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
//- (void)textFieldDidEndEditing:(UITextField *)textField;
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField;

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_itemNameInput]) {
        [_itemNameInput resignFirstResponder];
        [_itemPriceInput becomeFirstResponder];
    }
    if ([textField isEqual:_itemPriceInput]) {
        [_itemPriceInput resignFirstResponder];
        [_itemCountInput becomeFirstResponder];
    }
    if ([textField isEqual:_itemCountInput]) {
        [_itemCountInput resignFirstResponder];
    }
        
    return YES;
}

@end

