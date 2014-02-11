//
//  MasterViewController.m
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 1/31/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "CustomerService.h"
#import "Customer.h"
#import "NSData+Base64.h"

@interface MasterViewController () <CustomerServiceDelegate>

@property (nonatomic, strong) CustomerService* customerService;
@property (nonatomic, strong) NSMutableArray* customers;
@property (nonatomic, strong) NSMutableArray* sections;
@property (nonatomic, strong) UILocalizedIndexedCollation* collation;

@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    [self.tableView setSectionIndexMinimumDisplayRowCount:1];
    
    self.customerService = [[CustomerService alloc] init];
    
    UIRefreshControl* refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadCustomer) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshControl;
    

    [self loadCustomer];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.tableView reloadData];
}

- (void)loadCustomer
{
    [self.customerService loadCustomersWithDelegate:self];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    [self performSegueWithIdentifier:@"newCustomer" sender:self];    
}

#pragma mark - Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.collation sectionTitles] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	NSArray *rowsInSection = [self.sections objectAtIndex:section];
    if ([rowsInSection isKindOfClass:[NSArray class]]) {
        return [rowsInSection count];
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSArray* customersOfSection = [self.sections objectAtIndex:indexPath.section];

    Customer *customer = [customersOfSection objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",  customer.firstName, customer.lastName];
    cell.detailTextLabel.text = customer.profession;
    
    UIImage* image = customer.image;
    
    if (!image) {
        
        //if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
            [self.customerService loadImageForCustomer:customer completionHandler:^(Customer *customer, UIImage *image, NSError *error) {
                
                [self.tableView reloadData];
            }];
        //}
    } else {
        cell.imageView.image = image;
    }

    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        int section = indexPath.section;
        int row = indexPath.row;
        
        NSMutableArray* customersOfSection = [self.sections objectAtIndex:section];
        Customer *customer = [customersOfSection objectAtIndex:row];
        
        [customersOfSection removeObjectAtIndex:row];

        [self.tableView deleteRowsAtIndexPaths:@[[indexPath copy]] withRowAnimation:UITableViewRowAnimationTop];

        [self.customerService deleteCustomer:customer withDelegate:nil];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


///*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
//*/

///*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return NO;
}
//*/


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if ([[self.sections objectAtIndex:section] count]  > 0) {
        return [[self.collation sectionTitles] objectAtIndex:section];
    }
    return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.collation sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return [self.collation sectionForSectionIndexTitleAtIndex:index];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray* customersOfSection = [self.sections objectAtIndex:indexPath.section];
        Customer *customer = [customersOfSection objectAtIndex:indexPath.row];
        
        [[segue destinationViewController] setCustomer:customer];
    } else if ([[segue identifier] isEqualToString:@"newCustomer"]) {
        Customer *customer = [[Customer alloc] init];
        
        [[segue destinationViewController] setCustomer:customer];
    }
}


#pragma mark - CustomerServiceDelegate
- (void)customersLoaded:(NSArray *)customers
{
    [self.customers removeAllObjects];
    self.customers = [NSMutableArray arrayWithArray:customers];
    
    [self configureSections];
    
    [self.tableView reloadData];
}

-(void)errorOccured:(NSError *)error
{
    NSLog(@"Error occured on loading: %@", [error localizedDescription]);
}

- (void)configureSections {
	
	// Get the current collation and keep a reference to it.
	self.collation = [UILocalizedIndexedCollation currentCollation];
	
	NSInteger index, sectionTitlesCount = [[self.collation sectionTitles] count];
	
	NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
	
	// Set up the sections array: elements are mutable arrays that will contain the time zones for that section.
	for (index = 0; index < sectionTitlesCount; index++) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		[newSectionsArray addObject:array];
	}
	
	// Segregate the time zones into the appropriate arrays.
	for (Customer* customer in self.customers) {
		
		// Ask the collation which section number the time zone belongs in, based on its locale name.
		NSInteger sectionNumber = [self.collation sectionForObject:customer collationStringSelector:@selector(lastName)];
		
		// Get the array for the section.
		NSMutableArray *sectionCustomers = [newSectionsArray objectAtIndex:sectionNumber];
		
		//  Add the time zone to the section.
		[sectionCustomers addObject:customer];
	}
	
	// Now that all the data's in place, each section array needs to be sorted.
	for (index = 0; index < sectionTitlesCount; index++) {
		
		NSMutableArray *customersArrayForSection = [newSectionsArray objectAtIndex:index];
		
		// If the table view or its contents were editable, you would make a mutable copy here.
		NSArray *sortedCustomersArrayForSection = [self.collation sortedArrayFromArray:customersArrayForSection collationStringSelector:@selector(lastName)];
        
        NSMutableArray* mutableSortedCustomersArrayForSection = [NSMutableArray arrayWithArray:sortedCustomersArrayForSection];
		
		// Replace the existing array with the sorted array.
		[newSectionsArray replaceObjectAtIndex:index withObject:mutableSortedCustomersArrayForSection];
	}
	
	self.sections = newSectionsArray;
}

/*
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        [self loadImagesForOnscreenRows];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}
*/

- (void)loadImagesForOnscreenRows
{
    if ([self.customers count] > 0) {
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            NSArray* customersOfSection = [self.sections objectAtIndex:indexPath.section];
            Customer *customer = [customersOfSection objectAtIndex:indexPath.row];
            
            if (!customer.image) {
                [self.customerService loadImageForCustomer:customer completionHandler:^(Customer *customer, UIImage *image, NSError *error) {
                    
                    [self.tableView reloadData];
                }];
            }
        }
    }
}

@end
