//
//  Message.m
//  HelloWorld
//
//  Created by Michael Mühlebach on 10/02/14.
//  Copyright (c) 2014 Zühlke. All rights reserved.
//

#import "Message.h"

@implementation Message

- (NSString *)description
{
    return [NSString stringWithFormat:@"Author: %@, Text: %@", self.author, self.text];
}

@end
