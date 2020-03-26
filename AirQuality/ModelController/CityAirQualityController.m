//
//  CityAirQualityController.m
//  AirQuality
//
//  Created by Hin Wong on 3/25/20.
//  Copyright © 2020 Hin Wong. All rights reserved.
//

#import "CityAirQualityController.h"
#import "CityAirQuality.h"


static NSString * const baseURLString = @"https://api.airvisual.com/";
static NSString * const versionComponent = @"v2";
static NSString * const countryComponent = @"countries";
static NSString * const stateComponent = @"states";
static NSString * const cityComponent = @"cities";
static NSString * const cityDetailsComponent = @"city";
static NSString * const apiKey = @"b4958749-bf77-4001-9c80-4c2e80508ef0";

@implementation CityAirQualityController

+ (void) fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
    
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *dataDict = topLevelJSON[@"data"];
        NSMutableArray *countries = [NSMutableArray new];
        for (NSDictionary *countryDict in dataDict)
        {
            NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
            [countries addObject:country];
        }
        completion(countries);
        
    }]resume];
}

+ (void) fetchSupportedStatesInCountry:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *statesURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc]initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc]initWithName:@"key" value:apiKey];
    
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:statesURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *dataDict = topLevelJSON[@"data"];
        NSMutableArray *states = [NSMutableArray new];
        for (NSDictionary *stateDict in dataDict)
        {
            NSString *state = [[NSString alloc] initWithString:stateDict[@"state"]];
            [states addObject:state];
        }
        completion(states);
        
    }]resume];
}

+ (void) fetchSupportedCitiesInState:(NSString *)state country:(NSString *)country completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc]initWithName:@"state" value:state];
    NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc]initWithName:@"country" value:country];
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc]initWithName:@"key" value:apiKey];
    
    [queryItems addObject:stateQuery];
    [queryItems addObject:countryQuery];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlCompenents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];
    
    [urlCompenents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlCompenents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        if (!data)
        {
            NSLog(@"%@", error);
            completion(nil);
            return;
        }
        
        NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        NSDictionary *dataDict = topLevelJSON[@"data"];
        NSMutableArray *cities = [NSMutableArray new];
        for (NSDictionary *cityDict in dataDict)
        {
            NSString *city = cityDict[@"city"];
            [cities addObject:city];
        }
        completion(cities);
        
    }]resume];
}
+ (void)fetchDataForCity:(NSString *)city state:(NSString *)state country:(NSString *)country completion:(void (^)(CityAirQuality * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *versionURL = [baseURL URLByAppendingPathComponent:versionComponent];
    NSURL *cityURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
        
        NSURLQueryItem *cityQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:city];
        NSURLQueryItem *stateQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
        NSURLQueryItem *countryQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
        NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value:apiKey];
        
        [queryItems addObject:cityQuery];
        [queryItems addObject:stateQuery];
        [queryItems addObject:countryQuery];
        [queryItems addObject:apiKeyQuery];
        
        NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityURL resolvingAgainstBaseURL:true];
        
        [urlComponents setQueryItems:queryItems];
        
        NSURL *finalURL = [urlComponents URL];
        
        [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (error)
            {
                NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
                completion(nil);
                return;
            }
            
            if (!data)
            {
                NSLog(@"%@", error);
                completion(nil);
                return;
            }
            
            NSDictionary *topLevelJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            NSDictionary *dataDict = topLevelJSON[@"data"];
            
            CityAirQuality *cityAQI = [[CityAirQuality alloc]initWithDictionary:dataDict];
            completion(cityAQI);
            
        }] resume];
    }


@end
