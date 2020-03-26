//
//  HTWWeather.m
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import "HTWWeather.h"

@implementation HTWWeather

- (instancetype)initWithWeatherInfo:(NSInteger)temperature
                           humidity:(NSInteger)humidity
                          windSpeed:(NSInteger)windSpeed
{
    self = [super init];
    
    if (self)
    {
        _temperature = temperature;
        _humidity = humidity;
        _windSpeed = windSpeed;
    }
    return self;
}

@end

@implementation HTWWeather (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger temperature = [dictionary[@"tp"]intValue];
    NSInteger humidity = [dictionary[@"hu"]intValue];
    NSInteger windSpeed = [dictionary[@"ws"]intValue];
    
    return [self initWithWeatherInfo:temperature humidity:humidity windSpeed:windSpeed];
}

@end
