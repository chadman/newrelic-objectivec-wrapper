//
//  NRApplicationTests.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRApplicationTests.h"
#import "NRApplication.h"
#import "NRUserDefaults.h"

@implementation NRApplicationTests


- (void) testGetAll {
	
	// Set the account and api key. You cant have mine you gotta make your own
	[[NRUserDefaults sharedDefaults] setAPIKey:@""];
	[[NRUserDefaults sharedDefaults] setAccountID:1];
	
	NSError *error = nil;
	
	
	NSArray *applications = [NRApplication getAll:&error];
	
	STAssertNotNil(applications, @"applications came back nil, something went wrong.");
	
}

@end
