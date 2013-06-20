//
//  SRLocation.h
//  SRLocationExample
//
//  Created by rexshi on 6/20/13.
//  Copyright (c) 2013 rexshi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"

@interface SRLocation : NSObject <CLLocationManagerDelegate>
{
    void (^_complete)(CLLocation *location);
    void (^_failed)(NSError *error);
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) int minTries;

- (void)startGetLocationWithComplete:(void (^)(CLLocation *location))complete failed:(void (^)(NSError *error))failed;
- (void)cancel;

@end
