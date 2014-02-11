//
//  CustomerService.h
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 2/1/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//


#import "Customer.h"

@import Foundation;

@protocol CustomerServiceDelegate <NSObject>
@optional
- (void)customersLoaded:(NSArray*)customers;
- (void)customerUpdated:(Customer*)customer;
- (void)customerAdded:(Customer*)customer;
- (void)customerRemoved:(Customer*)customer;

- (void)errorOccured:(NSError*)error;

@end


@interface CustomerService : NSObject

- (void)loadCustomersWithDelegate:(id<CustomerServiceDelegate>)delegate;
- (void)saveCustomer:(Customer*)customer withDelegate:(id<CustomerServiceDelegate>)delegate;
- (void)deleteCustomer:(Customer*)customer withDelegate:(id<CustomerServiceDelegate>)delegate;
- (void)loadImageForCustomer:(Customer*)customer completionHandler:(void(^)(Customer* customer, UIImage* image, NSError* error)) handler;
@end
