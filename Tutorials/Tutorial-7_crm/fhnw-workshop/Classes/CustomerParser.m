//
//  CustomerParser.m
//  fhnw-workshop
//
//  Created by Michael Mühlebach on 2/12/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "CustomerParser.h"
#import "NSData+Base64.h"

@implementation CustomerParser

- (Customer*)parseCustomer:(NSDictionary*)customerDict
{
    NSNumber* identifier = [customerDict objectForKey:@"Id"];
    NSString* title = [customerDict objectForKey:@"Title"];
    NSString* firstName = [customerDict objectForKey:@"FirstName"];
    NSString* middleName = [customerDict objectForKey:@"MiddleName"];
    NSString* lastName = [customerDict objectForKey:@"LastName"];
    NSString* company = [customerDict objectForKey:@"Company"];
    NSString* webPage = [customerDict objectForKey:@"WebPage"];
    NSString* phoneNumber = [customerDict objectForKey:@"PhoneNumber"];
    NSString* faxNumber = [customerDict objectForKey:@"FaxNumber"];
    NSString* mobileNumber = [customerDict objectForKey:@"MobileNumber"];
    NSString* street = [customerDict objectForKey:@"Street"];
    NSString* email = [customerDict objectForKey:@"Email"];
    NSString* city = [customerDict objectForKey:@"City"];
    NSString* state = [customerDict objectForKey:@"State"];
    NSString* postalCode = [customerDict objectForKey:@"PostalCode"];
    NSString* country = [customerDict objectForKey:@"Country"];
    NSString* department = [customerDict objectForKey:@"Department"];
    NSString* office = [customerDict objectForKey:@"Office"];
    NSString* profession = [customerDict objectForKey:@"Profession"];
    NSString* managersName = [customerDict objectForKey:@"ManagersName"];
    NSString* assistantName = [customerDict objectForKey:@"AssistantName"];
    NSString* nickname = [customerDict objectForKey:@"Nickname"];
    NSString* birthday = [customerDict objectForKey:@"Birthday"];
    NSString* imageUri = [customerDict objectForKey:@"ImageUri"];
    NSNumber* sales = [customerDict objectForKey:@"Sales"];
    NSNumber* margin = [customerDict objectForKey:@"Margin"];
    
    Customer* customer = [[Customer alloc] init];
    [customer setIdentifier:identifier];
    [customer setTitle:title];
    [customer setFirstName:firstName];
    [customer setMiddleName:middleName];
    [customer setLastName:lastName];
    [customer setCompany:company];
    [customer setWebPage:webPage];
    [customer setPhoneNumber:phoneNumber];
    [customer setFaxNumber:faxNumber];
    [customer setMobileNumber:mobileNumber];
    [customer setStreet:street];
    [customer setEmail:email];
    [customer setCity:city];
    [customer setState:state];
    [customer setPostalCode:postalCode];
    [customer setCountry:country];
    [customer setDepartment:department];
    [customer setOffice:office];
    [customer setProfession:profession];
    [customer setManagersName:managersName];
    [customer setAsssistantName:assistantName];
    [customer setNickname:nickname];
    [customer setBirthday:birthday];
    [customer setImageUri:imageUri];
    [customer setSales:sales];
    [customer setMargin:margin];

    return customer;
}

- (NSArray*)parseCustomerList:(NSData*)data
{
    NSMutableArray* customerList = [NSMutableArray array];
    NSError* error;
    NSArray* listOfCustomers = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    for (NSDictionary* customerDict in listOfCustomers) {
        Customer* customer = [self parseCustomer:customerDict];
        
        [customerList addObject:customer];
    }
    
    return customerList;
}

- (NSString*)serializeImage:(UIImage*)image
{
    NSData* data = UIImageJPEGRepresentation(image, 1.0);
    
    NSString* string = [data base64EncodedString];
    
    return string;
}


- (NSData*)serializeCustomer:(Customer*)customer
{
    NSDictionary* dict = [self mapToDict:customer];
    NSError* error = nil;
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSLog(@"%@", [NSString stringWithUTF8String:[data bytes]]);
    
    return data;
}


- (NSDictionary*)mapToDict:(Customer*)customer
{
    NSMutableDictionary* customerDict = [[NSMutableDictionary alloc] init];
    
    NSNumber* identifier = customer.identifier;
    NSString* title = customer.title;
    NSString* firstName = customer.firstName;
    NSString* middleName = customer.middleName;
    NSString* lastName = customer.lastName;
    NSString* company = customer.company;
    NSString* webPage = customer.webPage;
    NSString* phoneNumber = customer.phoneNumber;
    NSString* faxNumber = customer.faxNumber;
    NSString* mobileNumber = customer.mobileNumber;
    NSString* street = customer.street;
    NSString* email = customer.email;
    NSString* city = customer.city;
    NSString* state = customer.state;
    NSString* postalCode = customer.postalCode;
    NSString* country = customer.country;
    NSString* department = customer.department;
    NSString* office = customer.office;
    NSString* profession = customer.profession;
    NSString* managersName = customer.managersName;
    NSString* assistantName = customer.asssistantName;
    NSString* nickname = customer.nickname;
    NSString* birthday = customer.birthday;
    NSString* imageUri = customer.imageUri;
    NSNumber* sales = customer.sales;
    NSNumber* margin = customer.margin;

    [self onDictionary:customerDict setObject:identifier forKey:@"Id"];
    [self onDictionary:customerDict setObject:title forKey:@"Title"];
    [self onDictionary:customerDict setObject:firstName forKey:@"FirstName"];
    [self onDictionary:customerDict setObject:middleName forKey:@"MiddleName"];
    [self onDictionary:customerDict setObject:lastName forKey:@"LastName"];
    [self onDictionary:customerDict setObject:company forKey:@"Company"];
    [self onDictionary:customerDict setObject:webPage forKey:@"WebPage"];
    [self onDictionary:customerDict setObject:phoneNumber forKey:@"PhoneNumber"];
    [self onDictionary:customerDict setObject:faxNumber forKey:@"FaxNumber"];
    [self onDictionary:customerDict setObject:mobileNumber forKey:@"MobileNumber"];
    [self onDictionary:customerDict setObject:street forKey:@"Street"];
    [self onDictionary:customerDict setObject:email forKey:@"Email"];
    [self onDictionary:customerDict setObject:city forKey:@"City"];
    [self onDictionary:customerDict setObject:state forKey:@"State"];
    [self onDictionary:customerDict setObject:postalCode forKey:@"PostalCode"];
    [self onDictionary:customerDict setObject:country forKey:@"Country"];
    [self onDictionary:customerDict setObject:department forKey:@"Department"];
    [self onDictionary:customerDict setObject:office forKey:@"Office"];
    [self onDictionary:customerDict setObject:profession forKey:@"Profession"];
    [self onDictionary:customerDict setObject:managersName forKey:@"ManagersName"];
    [self onDictionary:customerDict setObject:assistantName forKey:@"AssistantName"];
    [self onDictionary:customerDict setObject:nickname forKey:@"Nickname"];
    [self onDictionary:customerDict setObject:birthday forKey:@"Birthday"];
    [self onDictionary:customerDict setObject:imageUri forKey:@"ImageUri"];
    [self onDictionary:customerDict setObject:sales forKey:@"Sales"];
    [self onDictionary:customerDict setObject:margin forKey:@"Margin"];
    
    return customerDict;
}

- (void)onDictionary:(NSMutableDictionary*)dictionary setObject:(id)object forKey:(id<NSCopying>)key
{
    if (object) {
        [dictionary setObject:object forKey:key];
    }
}


@end
