
#import "NRApplicationSummaryMetricTests.h"
#import "NewRelicAPI.h"

@implementation NRApplicationSummaryMetricTests


- (void) testNRApplicationSummaryMetricGetByAppID {
	
	
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
	
	
	NSArray *thresholdValues = [NRApplicationSummaryMetrics getByApplicationID:application.applicationID error:&error];
	
	
	
	
	STAssertNotNil(thresholdValues, @"thresholdValues came back nil, something went wrong.");
	
}

- (void) testNRApplicationSummaryMetricGetByAppIDUsingCallback {
	
	NSError *error = nil;
	__block BOOL done= NO;
    int count = 0;

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
	
	[NRApplicationSummaryMetrics getByApplicationID:application.applicationID 
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
