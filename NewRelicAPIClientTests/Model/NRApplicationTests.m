
#import "NRApplicationTests.h"
#import "NewRelicAPI.h"

@implementation NRApplicationTests


- (void) testNRApplicationGetAll {

	
	NSError *error = nil;
	
	
	NSArray *applications = [NRApplication getAll:&error];
	
	STAssertNotNil(applications, @"applications came back nil, something went wrong.");
	
}

- (void) testNRApplicationGetAllUsingCallback {
	
	__block BOOL done= NO;
    int count = 0;
	

	[NRApplication getAllUsingCallback:^(id applications) {
		
		STAssertNotNil(applications	, @"applications were not returned, something went wrong.");
		done = YES;
		
	}
								 error:^(NSError *errorBlock) {
									 
									 STFail([NSString stringWithFormat:@"An error occured. %@", errorBlock]);
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
