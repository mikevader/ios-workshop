//
//  CWViewController.m
//  ColdWater
//
//  Created by Michael Mühlebach on 10/02/14.
//  Copyright (c) 2014 Zühlke. All rights reserved.
//

#import "CWViewController.h"

@interface CWViewController ()

@end

@implementation CWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _model = [[CWHelloWorld alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sayHello:(id)sender {

    if ([self.label.text isEqualToString:@""]) {
        self.label.text = [self.model sayHello];
    } else {
        self.label.text = @"";
    }
}

@end
