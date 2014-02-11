//
//  DetailViewController.h
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 1/31/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "Customer.h"

@import UIKit;

@interface DetailViewController : UITableViewController<UITextFieldDelegate>

@property (strong, nonatomic) Customer* customer;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
