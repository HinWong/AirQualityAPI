//
//  HTWPollution.h
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTWPollution : NSObject

@property (nonatomic, readonly) NSInteger airQualityIndex;

- (instancetype)initWithInt: (NSInteger)aqi;

- (instancetype)initWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
