
#import "BaseTests.h"
#import "NRUserDefaults.h"

@implementation BaseTests

// Set the account and api key. You cant have mine you gotta make your own
NSString * const kTestNewRelicAPIKey = @"a79c6bc1e2ce855ecc78745525eed422595209252a38a0d";
int const kTestNewRelicAccountID = 25945;
NSString * const kTestApplicationName = @"InFellowship"; 


- (void) setUp {
	// Set the account and api key. You cant have mine you gotta make your own
	[[NRUserDefaults sharedDefaults] setAPIKey:kTestNewRelicAPIKey];
	[[NRUserDefaults sharedDefaults] setAccountID:kTestNewRelicAccountID];
}

- (void) tearDown {
	
	[[NRUserDefaults sharedDefaults] killAll];
}

- (void) runLoop {
    
    @try {
        // This executes another run loop.
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        // Sleep 1/100th sec
        usleep(10000);
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
	
}

@end
