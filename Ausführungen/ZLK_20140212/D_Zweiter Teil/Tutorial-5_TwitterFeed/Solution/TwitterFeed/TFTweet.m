//
//  TFTweet.m
//  TwitterFeed
//
//  Created by Michael Mühlebach on 10/02/14.
//
//

#import "TFTweet.h"

@implementation TFTweet

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@: %@", self.author, self.text];
}

@end
