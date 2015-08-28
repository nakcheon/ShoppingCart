//
//  MasterViewController.m
//  ShoppingCart
//
//  Created by NakCheonJung on 12/8/14.
//  Copyright (c) 2014 NakCheonJung. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ShoppingItemInfo.h"

@interface MasterViewController ()
{
    ShopingItemInputView* _view;
}

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.title = @"총 0원";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private methods

-(void)privateRecalculateTotalPrice
{
    // 총합 계산
    int totalPrice = 0;
    for (ShoppingItemInfo* item in self.objects) {
        totalPrice += (item.price * item.count);
    }
    self.title = [NSString stringWithFormat:@"총합: %d원", totalPrice];
}

#pragma mark - selectors

- (void)insertNewObject:(id)sender
{
    if (_view) {
        return;
    }
    ShopingItemInputView* view = [[[NSBundle mainBundle] loadNibNamed:@"ShopingItemInputView" owner:nil options:nil] objectAtIndex:0];
    view.delegate = self;
    [self.view addSubview:view];
    _view = view;
}

#pragma mark - ShopingItemInputViewDelegate

-(void)itemInfoInputFinished:(NSString*)itemName price:(int)price count:(int)count
{
    _view = nil;
    
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    
    if ([itemName isEqualToString:@""] || price == 0 || count == 0) {
        return;
    }
    
    ShoppingItemInfo* item = [[ShoppingItemInfo alloc] init];
    item.title = [NSString stringWithString:itemName];
    item.price = price;
    item.count = count;
    
    [self.objects insertObject:item atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    // 총합 계산
    [self privateRecalculateTotalPrice];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    ShoppingItemInfo *object = self.objects[indexPath.row];
    NSString* text = [NSString stringWithFormat:@"%@, %d원, %d개", object.title, object.price, object.count];
    cell.textLabel.text = text;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
    [self privateRecalculateTotalPrice];
}

@end
