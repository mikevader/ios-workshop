//
//  CustomerDatabase.m
//  Customers
//
//  Created by Michael Mühlebach on 17/03/14.
//  Copyright (c) 2014 Michael Mühlebach. All rights reserved.
//

#import "CustomerDatabase.h"
#import "Customer.h"

@interface CustomerDatabase ()
@property Customer* myCustomer;
@end

@implementation CustomerDatabase

- (void)main
{
    [self createCustomer];
    [self logCustomer];
}

- (void)createCustomer
{
    self.myCustomer = [[Customer alloc] init];
    [self.myCustomer setFullnameWithFirstName:@"Hello"
                                  andLastName:@"World"];
}

- (void)logCustomer
{
    NSString* log = [Customer displayNameWithFirst:
                     self.myCustomer.firstName
                                           andLast:
                     self.myCustomer.lastName];
}

@end
