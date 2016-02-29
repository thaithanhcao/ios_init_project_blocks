//
//  MapKitViewController.h
//  MapKit
//
//  Created by TOANACHAU on 2/18/16.
//  Copyright (c) 2016 TOANACHAU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapKitViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)getCurrentLocation:(id)sender;

@end
