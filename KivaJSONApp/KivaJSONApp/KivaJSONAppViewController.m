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
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
    });
}

- (void)fetchedData:(NSData *)responseData {
    // Parse out the json data
    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSArray* latestLoans = [json objectForKey:@"loans"];
    
    NSLog(@"loans: %@", latestLoans);
    
    NSDictionary* loan = [latestLoans objectAtIndex:0];
    
    NSNumber* fundedAmount = [loan objectForKey:@"funded_amount"];
    NSNumber* loanAmount = [loan objectForKey:@"loan_amount"];
    float outstandingAmount = [loanAmount floatValue] - [fundedAmount floatValue];
    
    humanReadble.text = [NSString stringWithFormat:@"Latest loan: %@ from %@ needs another $%.2f to pursue their entrepreneural dream",
                         [loan objectForKey:@"name"],
                         [(NSDictionary*)[loan objectForKey:@"location"]
                          objectForKey:@"country"],
                          outstandingAmount];
    
    NSDictionary* info = [NSDictionary dictionaryWithObjectsAndKeys:
                          [loan objectForKey:@"name"],
                          @"who",
                          [(NSDictionary*)[loan objectForKey:@"location"] objectForKey:@"country"],
                          @"where",
                          [NSNumber numberWithFloat:outstandingAmount],
                          @"what",
                          nil];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
    
    jsonSummary.text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
