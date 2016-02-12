//
//  KivaJSONAppViewController.m
//  KivaJSONApp
//
//  Created by TOANACHAU on 2/4/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define kLatestKivaLoansURL [NSURL URLWithString:@"http://api.kivaws.org/v1/loans/search.json?status=fundraising"]

#import "KivaJSONAppViewController.h"

@interface KivaJSONAppViewController ()

@end

@implementation KivaJSONAppViewController
@synthesize humanReadble;
@synthesize jsonSummary;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL:kLatestKivaLoansURL];
        
        //CAO//Begin
        NSDictionary* json = nil;
        
        if (data) {
            json = [NSJSONSerialization
                    JSONObjectWithData:data options:kNilOptions error:nil];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateUIWithDictionary:json];
        });
        //CAO//End
    });
}

-(void)updateUIWithDictionary:(NSDictionary*)json {
    @try {
        
        NSNumber* fundedAmount = json[@"loans"][0][@"funded_amount"];
        NSNumber* loanAmount = json[@"loans"][0][@"loan_amount"];
        float outstandingAmount = [loanAmount floatValue] - [fundedAmount floatValue];
        
        humanReadble.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
                             json[@"loans"][0][@"name"],
                             json[@"loans"][0][@"location"][@"country"],
                             outstandingAmount];
        
        NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                              json[@"loans"][0][@"name"],
                              @"who",
                              json[@"loans"][0][@"location"][@"country"],
                              @"where",
                              [NSNumber numberWithFloat:outstandingAmount],
                              @"what",
                              nil];
        
        NSError* error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
        
        jsonSummary.text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];  
    }
    @catch (NSException *exception) {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Could not parse the JSON feed." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        NSLog(@"Exception: %@", exception);
    }
}

- ( void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
