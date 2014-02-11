//
//  Tweet.m
//  TwitterFeedUI
//
//  Created by Michael Mühlebach on 4/14/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tweet from: '%@' with text: '%@'", self.author, self.text];
}

@end
