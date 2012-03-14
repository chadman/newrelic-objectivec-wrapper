//
//  NRMetricDataTests.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRMetricDataTests.h"
#import "NewRelicAPI.h"

@implementation NRMetricDataTests


- (void) testNRMetricDataGetByQOByAppName {

	NSError *error = nil;
	
	// Get the applications so we can then turn around and get threshold values for one of the applications
	NSArray *applications = [NRApplication getAll:&error];
	NRApplication *application = nil;
	
	// loop through the appliations until the appliation name that is in the base test constant is found
	for (NRApplication *currentApplication in applications) {
		
		if ([currentApplication.name isEqualToString:kTestApplicationName]) {
			application = currentApplication;
			break;
		}
	}

	NRMetricDataQO *qo = [[NRMetricDataQO alloc] init];
	qo.apps = [[[NSMutableArray alloc] initWithObjects:application.name, nil] copy];
	qo.begin = [[NSDate date] addTimeInterval:-86400];
	qo.end = [NSDate date];
	qo.metrics = [[[NSMutableArray alloc] initWithObjects:@"WebTransaction", nil] copy];
	qo.field = @"average_response_time";
	
	NSArray *results = [NRMetricData getByQO:qo error:&error];
	STAssertNotNil(results, @"metric data is nil, something went wrong.");
}

- (void) testNRMetricDataGetByQOByAppID {
	
	NSError *error = nil;
	
	// Get the applications so we can then turn around and get threshold values for one of the applications
	NSArray *applications = [NRApplication getAll:&error];
	NRApplication *application = nil;
	
	// loop through the appliations until the appliation name that is in the base test constant is found
	for (NRApplication *currentApplication in applications) {
		
		if ([currentApplication.name isEqualToString:kTestApplicationName]) {
			application = currentApplication;
			break;
		}
	}
	
	NRMetricDataQO *qo = [[NRMetricDataQO alloc] init];
	qo.appIDs = [[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:application.applicationID], nil] copy];
	qo.begin = [[NSDate date] addTimeInterval:-86400];
	qo.end = [NSDate date];
	qo.metrics = [[[NSMutableArray alloc] initWithObjects:@"WebTransaction", nil] copy];
	qo.field = @"average_response_time";
	
	NSArray *results = [NRMetricData getByQO:qo error:&error];
	STAssertNotNil(results, @"metric data is nil, something went wrong.");
}


- (void) testNRMetricDataGetByQOUsingCallback {
	
	NSError *error = nil;
	
	// Get the applications so we can then turn around and get threshold values for one of the applications
	NSArray *applications = [NRApplication getAll:&error];
	NRApplication *application = nil;
	
	// loop through the appliations until the appliation name that is in the base test constant is found
	for (NRApplication *currentApplication in applications) {
		
		if ([currentApplication.name isEqualToString:kTestApplicationName]) {
			application = currentApplication;
			break;
		}
	}
	
	NRMetricDataQO *qo = [[NRMetricDataQO alloc] init];
	qo.appIDs = [[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:application.applicationID], nil] copy];
	qo.begin = [[NSDate date] addTimeInterval:-86400];
	qo.end = [NSDate date];
	qo.metrics = [[[NSMutableArray alloc] initWithObjects:@"WebTransaction", nil] copy];
	qo.field = @"average_response_time";
	
	__block BOOL done= NO;
    int count = 0;
	
	[NRMetricData getByQO:qo 
			usingCallback:^(NSArray *metrics) {
				STAssertNotNil(metrics, @"metrics were not returned, something went wrong.");
				done = YES;
			}
					error:^(NSError *error) {
						STFail([NSString stringWithFormat:@"An error occured. %@", error]);
						done = YES;
					}
	 ];

	while (!done) {
        
        if (count < 20) {
            count++;
            [self runLoop];
        }
        else {
            done = YES;
            STFail(@"Did not complete testGetAllUsingCallback");
        }
    }
	
}


@end
