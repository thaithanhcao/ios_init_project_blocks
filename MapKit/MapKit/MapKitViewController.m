//
//  MapKitViewController.m
//  MapKit
//
//  Created by TOANACHAU on 2/18/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import "MapKitViewController.h"
#import <AddressBook/AddressBook.h>

@interface MapKitViewController ()

@end

@implementation MapKitViewController
{
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@synthesize mapView;

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    locationManager = [[CLLocationManager alloc] init];
    geocoder = [[CLGeocoder alloc] init];
    self.mapView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCurrentLocation:(id)sender {
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [locations lastObject];
    CLLocation *oldLocation;
    
    if (locations.count > 1)
    {
        oldLocation = [locations objectAtIndex:locations.count-2];
    }
    else
    {
        oldLocation = nil;
    }
    
    NSLog(@"didUpdateLocations %@ from %@", newLocation, oldLocation);
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 800, 800);
    [self.mapView setRegion:userLocation animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point;
    
    if (newLocation != nil)
    {
        if (point == nil)
        {
            point = [[MKPointAnnotation alloc] init];
            point.coordinate = newLocation.coordinate;
            point.title = [NSString stringWithFormat:@"Lat: %6.8f Long: %6.8f", newLocation.coordinate.latitude, newLocation.coordinate.longitude];
            point.subtitle = @"I'm another one here!!!";
        }
        
        [self.mapView addAnnotation:point];
    }
    
    // Reverse Geocoding
    NSLog(@"Resolving the Address");
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        
        if (error) {
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        
        if (placemarks && [placemarks count] > 0)
        {
            placemark = placemarks[0];//[placemarks lastObject];
            
            NSDictionary *addressDictionary = placemark.addressDictionary;
            
            NSString *address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            NSString *zip = [addressDictionary objectForKey:(NSString *)kABPersonAddressZIPKey];
            NSString *country = [addressDictionary objectForKey:(NSString *)kABPersonAddressCountryKey];
            NSLog(@"%@ %@ %@ %@", address, city, state, zip);
            
            if (point != nil && placemark != nil)
            {
                point.subtitle = [NSString stringWithFormat:@"%@ %@ %@ %@",//@"%@ %@\n%@ %@\n%@\n%@",
                                  //placemark.subThoroughfare, placemark.thoroughfare,
                                  //placemark.postalCode, placemark.locality,
                                  address,
                                  //city,
                                  zip, state,
                                  //placemark.administrativeArea,
                                  country];
                                  //placemark.country];
            }
        }
        else
        {
            NSLog(@"%@", error.debugDescription);
        }
    }];
    
    // Stop Location Manager
    [locationManager stopUpdatingLocation];
}
@end
