//
//  NRMetricNameTests.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRMetricNameTests.h"
#import "NewRelicAPI.h"

@implementation NRMetricNameTests


- (void) testNRMetricNameGetAllByApplicationID {
	
	
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
	
	NRMetricNameQO *qo = [[NRMetricNameQO alloc] init];
	qo.limit = 10;
	qo.regularExpression = @"Apdex";
	
	NSArray *metricNames = [NRMetricName getAllByApplicationID:application.applicationID withQuery:qo error:&error];
	
	STAssertNotNil(metricNames, @"metric names are nil, something went wrong.");
	
}

- (void) testNRMetricNameGetAllByApplicationIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;
	
	NRMetricNameQO *qo = [[NRMetricNameQO alloc] init];
	qo.limit = 10;
	qo.regularExpression = @"Apdex";
	
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
	
	[NRMetricName getAllByApplicationID:application.applicationID 
							  withQuery:qo						  
						  usingCallback:^(id metrics) {
										  
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
