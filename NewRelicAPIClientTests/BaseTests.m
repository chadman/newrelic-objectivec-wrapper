//
//  BaseTests.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseTests.h"
#import "NRUserDefaults.h"

@implementation BaseTests

// Set the account and api key. You cant have mine you gotta make your own
NSString * const kTestNewRelicAPIKey = @"";
int const kTestNewRelicAccountID = 0;
NSString * const kTestApplicationName = @""; 


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
