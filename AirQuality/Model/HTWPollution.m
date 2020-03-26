//
//  HTWPollution.m
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import "HTWPollution.h"

@implementation HTWPollution

- (instancetype) initWithInt:(NSInteger)aqi
{
    self = [super init];
    
    if (self)
    {
        _airQualityIndex = aqi;
    }
    return self;
}

@end

@implementation HTWPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger aqi = [dictionary[@"aqius"]intValue];
    
    return [self initWithInt:aqi];
}

@end
