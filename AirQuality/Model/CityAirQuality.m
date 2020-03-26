//
//  CityAirQuality.m
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import "CityAirQuality.h"
#import "HTWPollution.h"
#import "HTWWeather.h"

@implementation CityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(HTWWeather *)weather pollution:(HTWPollution *)pollution
{
    self = [super init];
    
    if (self)
    {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _poluution = pollution;
    }
    return self;
}
@end

@implementation CityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    NSDictionary *currentInfo = dictionary[@"current"];
    
    HTWWeather *weather = [[HTWWeather alloc] initWithDictionary:currentInfo[@"weather"]];
    HTWPollution *pollution = [[HTWPollution alloc] initWithDictionary:currentInfo[@"pollution"]];
    
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
}

@end
