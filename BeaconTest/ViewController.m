//
//  ViewController.m
//  BeaconTest
//
//  Created by Anthony Powles on 04/10/14.
//  Copyright (c) 2014 Anthony Powles. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) NSUUID *uuid;
@property (nonatomic, strong) CLBeaconRegion *region;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _uuid = [[NSUUID alloc] initWithUUIDString:@"9133EDC4-A87C-5529-BEFA-4F75F31A45D4"];
    _region = [[CLBeaconRegion alloc] initWithProximityUUID:_uuid identifier:@"LeExplorer Region"];
    _region.notifyEntryStateOnDisplay = YES;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;

    if ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        NSLog(@"requestAlwaysAuthorization!!!");
        [_locationManager requestAlwaysAuthorization];
    }

    [_locationManager startRangingBeaconsInRegion:_region];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    NSLog(@"%s : %@", __func__, beacons);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s : %@", __func__, error);
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    NSLog(@"%s : %@", __func__, error);
}

- (void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"%s : %@", __func__, error);
}

@end
