//
//  DeviceDetailViewController.m
//  CompanyDeviceStore
//
//  Created by TOANACHAU on 2/2/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import "DeviceDetailViewController.h"

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController
@synthesize nameTextField;
@synthesize versionTextField;
@synthesize companyTextField;
@synthesize device;

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)])
    {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    if (self.device) {
        [self.nameTextField setText:[self.device valueForKey:@"name"]];
        [self.versionTextField setText:[self.device valueForKey:@"version"]];
        [self.companyTextField setText:[self.device valueForKey:@"company"]];
    }
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setVersionTextField:nil];
    [self setCompanyTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (self.device)
    {
        // Update existing device
        [self.device setValue:self.nameTextField.text forKey:@"name"];
        [self.device setValue:self.versionTextField.text forKey:@"version"];
        [self.device setValue:self.companyTextField.text forKey:@"company"];
    }
    else
    {
        // Create a new managed object
        NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device" inManagedObjectContext:context];
        [newDevice setValue:self.nameTextField.text forKey:@"name"];
        [newDevice setValue:self.versionTextField.text forKey:@"version"];
        [newDevice setValue:self.companyTextField.text forKey:@"company"];
    }
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't save! %@ %@", error, [error localizedDescription]);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
