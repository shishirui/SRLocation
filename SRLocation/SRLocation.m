//
//  SRLocation.m
//  SRLocationExample
//
//  Created by rexshi on 6/20/13.
//  Copyright (c) 2013 rexshi. All rights reserved.
//

#import "SRLocation.h"

@interface SRLocation ()

@property (nonatomic, strong) CSqlite *m_sqlite;

@end

@implementation SRLocation

- (id)init
{
    if (self = [super init]) {
        self.fixLocationInChina = YES;
        self.m_sqlite = [[CSqlite alloc] init];
        [_m_sqlite openSqlite];
    }
    
    return self;
}

- (void)startGetLocationWithComplete:(void (^)(CLLocation *location))complete failed:(void (^)(NSError *error))failed
{
    _complete = complete;
    _failed = failed;
    
    if ([CLLocationManager locationServicesEnabled] && _locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    
    [_locationManager startUpdatingLocation];
}

- (void)cancel
{
    _complete = nil;
    _failed = nil;
    
    if (_locationManager) {
        [_locationManager stopUpdatingLocation];
    }
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;
    mylocation = [self zzTransGPS:mylocation];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:mylocation.latitude longitude:mylocation.longitude];
    
    if (_complete != nil) {
        _complete(location);
    }
    
    [_locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (_failed != nil) {
        _failed(error);
    }
    
    [_locationManager stopUpdatingLocation];
}

- (CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat = 0;
    int TenLog = 0;
    
    TenLat = (int)(yGps.latitude * 10);
    TenLog = (int)(yGps.longitude * 10);
    NSString        *sql = [[NSString alloc] initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d", TenLat, TenLog];
    sqlite3_stmt    *stmtL = [_m_sqlite NSRunSql:sql];
    int             offLat = 0;
    int             offLog = 0;
    
    while (sqlite3_step(stmtL) == SQLITE_ROW) {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
    }
    
    if (offLat > 0 && offLog > 0 && _fixLocationInChina == YES) {
        yGps.latitude = yGps.latitude + offLat * 0.0001;
        yGps.longitude = yGps.longitude + offLog * 0.0001;
    }
    
    return yGps;
}

@end
