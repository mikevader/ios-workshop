//
//  DetailViewController.m
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 1/31/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomerDetailViewCell.h"
#import "CustomerService.h"

@interface DetailViewController ()
@property NSArray* properties;
@property (nonatomic, strong) CustomerService* service;

- (void)configureView;
@end

@implementation DetailViewController


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _properties = @[@"identifier",
                    @"title",
                    @"firstName",
                    @"middleName",
                    @"lastName",
                    @"company",
                    @"webPage",
                    @"phoneNumber",
                    @"faxNumber",
                    @"mobileNumber",
                    @"street",
                    @"email",
                    @"city", 
                    @"state", 
                    @"postalCode", 
                    @"country", 
                    @"department", 
                    @"office", 
                    @"profession", 
                    @"managersName", 
                    @"asssistantName", 
                    @"nickname", 
                    @"birthday", 
                    @"sales", 
                    @"margin",
                    @"imageUri"];

    
    self.title = @"Customer"; 
    
    _service = [[CustomerService alloc] init];
    
    // Configure the add and edit buttons.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
        
    [self configureView];
}

#pragma mark - Table view data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // only one section.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _properties.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"PropertyCell";
    
    CustomerDetailViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    NSString* propertyName = [_properties objectAtIndex:indexPath.row];
    NSString* propertyValue = [_customer valueForKey:propertyName];
    
    cell.textfield.text = [NSString stringWithFormat:@"%@", propertyValue];
    cell.title.text = propertyName;
    cell.textfield.tag = indexPath.row;
    cell.title.tag = indexPath.row;
    
    return cell;
}

#pragma mark - Editing
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    NSString* propertyName = _properties[index];
    
    [self.customer setValue:nil forKey:propertyName];
    
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
	// Don't show the Back button while editing.
	[self.navigationItem setHidesBackButton:editing animated:YES];
    
    if (!self.editing) {
        [self.service saveCustomer:self.customer withDelegate:nil];
    }
}



- (void)save
{
}


#pragma mark - Editing text fields
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSString* newValue = textField.text;
    NSInteger index = textField.tag;
    NSString* propertyName = _properties[index];

    [self.customer setValue:newValue forKey:propertyName];
    
    return YES;
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    textField.enabled = self.editing;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


#pragma mark - Managing the detail item

- (void)setCustomer:(Customer *)customer
{
    if (_customer != customer) {
        _customer = customer;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.customer) {
        //self.detailDescriptionLabel.text = [self.customer description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
