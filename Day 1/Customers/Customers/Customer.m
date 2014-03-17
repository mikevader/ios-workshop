//
//  Customer.m
//  Customers
//
//  Created by Michael Mühlebach on 12/03/14.
//  Copyright (c) 2014 Michael Mühlebach. All rights reserved.
//

#import "Customer.h" // Dateinamen von Header und Impl sind nicht gebunden an Interface oder Implementation (idealerweise aber identisch)


@interface Customer ()
@property (nonatomic, strong) NSDate* birthday;
@end

@implementation Customer // Name muss identisch sein mit Interface


// !!! Generierter Code! Wird von @property generiert !!!
@synthesize firstName = _firstName; // synthesize generiert die Implementation der Accessormethoden. Vor dem '=' steht der Propertyname und dahinter die zu verwendende (oder falls nicht existierend zu generierende) Instanzvariable.

// !!! Generierter Code! Wird von @synthesize generiert !!!
- (NSString *)firstName
{
    return _firstName;
}
- (void)setFirstName:(NSString *)firstName
{
    _firstName = firstName;
}

- (NSString*)fullname
{
    NSString* fullname = [NSString stringWithFormat:@"%@, %@", self.firstName, [self lastName]];
    
    return fullname;
}

- (void)ageCustomerByYears:(NSInteger)years // Returntyp sowie Parametertypen gehören nicht zur Methodensignatur!!!!
{
    self.birthday = [self.birthday dateByAddingTimeInterval:60*60*24*365*years];
    
    [self setAge:self.age + years];
    // self.age = self.age + years;   // identisch!!!!
    // _age = self.age + years;       // fast identisch! Umgeht Accessormethoden
}

- (void)setFullnameWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName
{
    _firstName = firstName;  // or self.firstName = firstName;
    _lastName = lastName;    // or self.lastName = lastName;
}

- (NSInteger)age
{
    return abs([self.birthday timeIntervalSinceNow])/(60*60*24*365);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _firstName = @"John";
        _lastName = @"Doe";
        _birthday = nil;
    }
    return self;
}

+ (NSString*)displayNameWithFirst:(NSString*)first andLast:(NSString*)last
{
    return [NSString stringWithFormat:@"%@, %@", first, last];
}

@end