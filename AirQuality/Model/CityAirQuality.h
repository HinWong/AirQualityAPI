//
//  CityAirQuality.h
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTWWeather.h"
#import "HTWPollution.h"

NS_ASSUME_NONNULL_BEGIN

@interface CityAirQuality : NSObject

@property (nonatomic, copy, readonly) NSString *city;
@property (nonatomic, copy, readonly) NSString *state;
@property (nonatomic, copy, readonly) NSString *country;
@property (nonatomic, copy, readonly) HTWWeather *weather;
@property (nonatomic, copy, readonly) HTWPollution *poluution;

- (instancetype) initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                     weather:(HTWWeather *)weather
                   pollution:(HTWPollution *)pollution;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
