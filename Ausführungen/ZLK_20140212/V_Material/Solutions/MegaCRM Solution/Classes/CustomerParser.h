//
//  CustomerParser.h
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 2/12/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "Customer.h"

@import Foundation;

@interface CustomerParser : NSObject


- (NSArray*)parseCustomerList:(NSData*)data;

- (NSData*)serializeCustomer:(Customer*)customer;

@end
