//
//  HTWWeather.h
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTWWeather : NSObject

@property (nonatomic, readonly) NSInteger temperature;
@property (nonatomic, readonly) NSInteger humidity;
@property (nonatomic, readonly) NSInteger windSpeed;

- (instancetype) initWithWeatherInfo: (NSInteger)temperature
                            humidity:(NSInteger)humidity
                           windSpeed:(NSInteger)windSpeed;

- (instancetype) initWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
