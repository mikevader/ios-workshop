//
//  Customer.h
//  Customers
//
//  Created by Michael Mühlebach on 12/03/14.
//  Copyright (c) 2014 Michael Mühlebach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
@import Foundation;

@interface Customer : NSObject // Ableitung muss immer angegeben werden! NSObject ist gemeinsamer Basistyp aller Klassen wie bsp. Object in Java
{
    // !!! Generierter Code! Wird von @synthesize generiert !!!
    NSString* _firstName; // Referenz
    NSString* _lastName;
    NSInteger _age; // Skalar
    // Instanzvariablen können nur im Interface definiert werden. Werden impliziet erstellt, wenn properties definiert werden.
    // Per Konvention werden Instanzvariablen immer mit einem Unterstrich begonnen.
}

@property (nonatomic, strong) NSString* firstName; // Properties generieren accessor methoden sowie Variablen. Für eine Instanzvariable muss also nur ein Property definiert werden.
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic) NSInteger age;

// !! Generierter Code! Wird von @property generiert !!!
- (NSString*)firstName;
- (void)setFirstName:(NSString *)firstName;

+ (NSString*)displayNameWithFirst:(NSString*)first andLast:(NSString*)last;



- (NSString*)fullname;

- (void)ageCustomerByYears:(NSInteger)years;

- (void)setFullnameWithFirstName:(NSString*)firstName andLastName:(NSString*)lastName;

@end
