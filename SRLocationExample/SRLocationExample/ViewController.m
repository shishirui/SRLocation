//
//  ViewController.m
//  SRLocationExample
//
//  Created by rexshi on 6/20/13.
//  Copyright (c) 2013 rexshi. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)start:(id)sender
{
    if (_location == nil) {
        self.location = [[SRLocation alloc] init];
    }
    
    [_location startGetLocationWithComplete:^(CLLocation *location) {
        [self getLocationName:location];
    } failed:^(NSError *error) {
        
    }];
}

- (void)setMapPoint:(CLLocationCoordinate2D)myLocation title:(NSString *)title subtitle:(NSString *)subtitle
{
    POI *poi = [[POI alloc] initWithCoords:myLocation];
    poi.title = title;
    poi.subtitle = subtitle;
    [self.mapView addAnnotation:poi];

    MKCoordinateRegion theRegion = {{0.0, 0.0}, {0.0, 0.0}};
    theRegion.center = myLocation;
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    theRegion.span.longitudeDelta = 0.01f;
    theRegion.span.latitudeDelta = 0.01f;
    [self.mapView setRegion:theRegion animated:YES];
}

- (void)getLocationName:(CLLocation *)location
{
    // get location name
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray * placemarks, NSError * error)
     {
         if (placemarks.count > 0) {
             CLPlacemark *plmark = [placemarks objectAtIndex:0];
             NSString *country = plmark.country;
             NSString *city = plmark.locality;
             
             NSString *title = [NSString stringWithFormat:@"%@ %@", country, city];
             [self setMapPoint:location.coordinate title:title subtitle:plmark.name];
         } else {
             [self setMapPoint:location.coordinate title:nil subtitle:nil];
         }
     }];
}

@end

@implementation POI

- (id)initWithCoords:(CLLocationCoordinate2D)coords
{
    self = [super init];

    if (self != nil) {
        _coordinate = coords;
    }

    return self;
}

@end