//
//  ViewController.m
//  Opener
//
//  Created by Michael Mühlebach on 24/03/14.
//  Copyright (c) 2014 FHNW. All rights reserved.
//

#import "ViewController.h"
@import Social;

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)sendSms:(id)sender {
    NSURL* url = [NSURL URLWithString:@"sms:0787295027"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)sendMail:(id)sender {
    NSURL* url = [NSURL URLWithString:@"http://maps.apple.com/?q=cupertino"];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)sendTweet:(id)sender {
    SLComposeViewController* tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    
    [self presentViewController:tweetSheet animated:YES completion:^{}];
}

@end
