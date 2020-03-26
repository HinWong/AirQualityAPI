//
//  CityAirQualityController.h
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CityAirQuality;

NS_ASSUME_NONNULL_BEGIN

@interface CityAirQualityController : NSObject

//take in no parameter and complete with an array of strings
+ (void) fetchSupportedCountries: (void(^) (NSArray<NSString *> *_Nullable))completion;

//take in a string parameter for the country and complete with an array of strings
+ (void) fetchSupportedStatesInCountry: (NSString *)country
                            completion:(void(^) (NSArray<NSString *> *_Nullable))completion;

//take in a string parameter for the country and state and complete with an array of strings
+ (void) fetchSupportedCitiesInState: (NSString *)state
                             country: (NSString *)country
                          completion:(void(^) (NSArray<NSString *> *_Nullable))completion;

//take in a string parameter for country, state, city and complete with a CityAirQuality object
+ (void) fetchDataForCity:(NSString *)city
                    state:(NSString *)state
                  country:(NSString *)country
               completion:(void(^) (CityAirQuality *_Nullable))completion;


@end

NS_ASSUME_NONNULL_END
