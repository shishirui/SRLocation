//
//  ViewController.h
//  SRLocationExample
//
//  Created by rexshi on 6/20/13.
//  Copyright (c) 2013 rexshi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRLocation.h"
#import <MapKit/MapKit.h>

@interface POI : NSObject <MKAnnotation> 

@property (nonatomic, readonly) CLLocationCoordinate2D  coordinate;
@property (nonatomic, retain) NSString                  *subtitle;
@property (nonatomic, retain) NSString                  *title;

- (id)initWithCoords:(CLLocationCoordinate2D)coords;

@end

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) SRLocation *location;

- (IBAction)start:(id)sender;

@end
