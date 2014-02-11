//
//  CustomerService.m
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 2/1/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "CustomerService.h"
#import "CustomerParser.h"


@interface CustomerService ()

@property (nonatomic, strong) CustomerParser* parser;
@property (nonatomic, strong) NSString* serviceBaseUrl;
@property (nonatomic, strong) NSOperationQueue* queue;

@end

@implementation CustomerService

#define SERVICE_URL @"http://mega-crm.azurewebsites.net/"


- (id)init
{
    self = [super init];
    if (self) {
        self.serviceBaseUrl = SERVICE_URL;
        self.queue = [[NSOperationQueue alloc] init];
        self.parser = [[CustomerParser alloc] init];
        
    }
    return self;
}

- (void)loadCustomersWithDelegate:(id<CustomerServiceDelegate>)delegate
{
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/customer?format=json", self.serviceBaseUrl]];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:self.queue
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
         
         if (error) {
             [delegate errorOccured:error];
         } else {
             NSArray* customerList = [self.parser parseCustomerList:data];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [delegate customersLoaded:customerList];
             });
         }
     }];
}

- (void)saveCustomer:(Customer*)customer withDelegate:(id<CustomerServiceDelegate>)delegate
{
    NSURL* url = nil;
    NSString* method = nil;
    
    if (customer.identifier) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/customer/%@?format=json", self.serviceBaseUrl, customer.identifier]];
        method = @"POST";
    } else {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/customer?format=json", self.serviceBaseUrl]];
        method = @"POST";
        
        NSNumber* newId = [NSNumber numberWithInt:arc4random() % 100];
        
        customer.identifier = newId;
    }
    
    CustomerParser* parser = [[CustomerParser alloc] init];
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    NSData* data = [parser serializeCustomer:customer];
    request.HTTPBody = data;
    NSLog(@"%@", [NSString stringWithUTF8String:[data bytes]]);
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:self.queue
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
         
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (error) {
                 [delegate errorOccured:error];
             } else {
                 [delegate customerUpdated:customer];
             }
         });
     }];
}


- (void)deleteCustomer:(Customer*)customer withDelegate:(id<CustomerServiceDelegate>)delegate
{
    
    NSURL* url = nil;
    NSString* method = nil;
    
    url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/customer/%@?format=json", self.serviceBaseUrl, customer.identifier]];
    method = @"DELETE";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:self.queue
     completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
         
         dispatch_async(dispatch_get_main_queue(), ^{
             if (error) {
                 [delegate errorOccured:error];
             } else {
                 [delegate customerRemoved:customer];
             }
         });
     }];
}


- (void)loadImageForCustomer:(Customer*)customer completionHandler:(void(^)(Customer* customer, UIImage* image, NSError* error)) handler {
    
    NSURL* url = nil;
    NSString* method = nil;
    
    url = [NSURL URLWithString:customer.imageUri];
    method = @"GET";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:self.queue
     completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
         
         if (error) {
             handler(nil, nil, error);
         } else {
             UIImage* image = [UIImage imageWithData:data];
             customer.image = image;
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 handler(customer, image, nil);
             });
         }
     }];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"Failed with Error %@", [error description]);
    
}


@end
