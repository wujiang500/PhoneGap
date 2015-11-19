//
//  NSYNETLocationPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/14.
//
//

#import "NSYNETLocationPlugin.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NSYNETLocationPlugin ()<CLLocationManagerDelegate>

@property (retain, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString * userLocation;
@property (copy, nonatomic) NSString * callBackID;
@property (assign, nonatomic) BOOL isOne;

@end

@implementation NSYNETLocationPlugin

- (void)userLocation:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    if (arguments.count > 0)
    {
        self.callBackID = [arguments objectAtIndex:0];
       
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=0.0f;
        _isOne = YES;
        [_locationManager startUpdatingLocation];
    }else{
        CDVPluginResult * result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    self.coordinate = [location coordinate];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            
            CLPlacemark *placemark = [array objectAtIndex:0];
            
            CDVPluginResult *result = nil;
            if (placemark)
            {
                NSString *city = placemark.administrativeArea;
                NSString *subLocality = placemark.subLocality;
                NSString *thoroughfare = placemark.thoroughfare;
                
                self.userLocation = [NSString stringWithFormat:@"经度:%f, 纬度:%f, 详细位置信息:%@%@%@", self.coordinate.longitude, self.coordinate.latitude, city, subLocality, thoroughfare];
                
                if (_isOne) {
                    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:self.userLocation];
                    [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
                    [_locationManager stopUpdatingLocation];
                    _isOne = NO;
                }
            }
            else
            {
                result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"定位失败"];
                [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    CDVPluginResult *result = nil;
    result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"定位失败"];
    [self.commandDelegate sendPluginResult:result callbackId:self.callBackID];
}


@end
