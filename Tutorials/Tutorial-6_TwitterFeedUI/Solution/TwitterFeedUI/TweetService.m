//
//  TweetService.m
//  TwitterFeedUI
//
//  Created by Michael Mühlebach on 4/12/13.
//  Copyright (c) 2013 FHNW. All rights reserved.
//

#import "TweetService.h"
#import "Tweet.h"
@import Social;
@import Accounts;

@implementation TweetService
- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}


- (void)requestTweets
{
    ACAccountStore* store = [[ACAccountStore alloc] init];
    
    
    if ([self userHasAccessToTwitter]) {
        
        //  Step 1:  Obtain access to the user's Twitter accounts
        ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [store
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {
                 //  Step 2:  Create a request
                 NSArray *accounts = [store accountsWithAccountType:twitterAccountType];
                 
                 NSURL* url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
                 
                 SLRequest* request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:@{@"q": @"%23fhnw"}];
                 //  Attach an account to the request
                 [request setAccount:[accounts lastObject]];
                 
                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                     
                     NSArray* tweets = [self parseTweets:responseData];
                     
                     [self.delegate retrievedTweets:tweets];
                 }];
             } else {
                 // Access was not granted, or an error occurred
                 NSLog(@"%@", [error localizedDescription]);
             }
         }];
    }
}

- (NSArray*)parseTweets:(NSData*)tweetData
{
    NSMutableArray* tweets = [[NSMutableArray alloc] init];
    
    NSError* parseError;
    NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:tweetData options:NSJSONReadingAllowFragments error:&parseError];
    
    NSArray* statuses = [jsonDict valueForKey:@"statuses"];
    
    for (NSDictionary* tweetDict in statuses) {
        NSString* text = [tweetDict valueForKey:@"text"];
        NSString* author = [[tweetDict valueForKey:@"user"] valueForKey:@"name"];
        
        Tweet* tweet = [[Tweet alloc] init];
        tweet.text = text;
        tweet.author = author;
        
        [tweets addObject:tweet];
    }
    
    NSLog(@"Tweets: %@", tweets);
    
    return tweets;
}

@end
