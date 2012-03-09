//
//  NewRelicAPIClientTests.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewRelicAPIClientTests.h"
#import "NewRelicAPIClient.h"
#import "NRUserDefaults.h"

@implementation NewRelicAPIClientTests



- (void) testSetAccountInformation {
	
	NSString *testString = [NSString stringWithString:@"test_api_key"];
	NSInteger testAccountID = 1234567;
	
	[NewRelicAPIClient setAccountID:testAccountID withAPIKey:testString];
	
	STAssertEquals(testString, [[NRUserDefaults sharedDefaults] APIKey], @"API Key was not set from Client.");
	STAssertEquals(testAccountID, [[NRUserDefaults sharedDefaults] accountID], @"Account id was not set from Client.");
	
	[[NRUserDefaults sharedDefaults] killAll];
}

- (void) testRemoveAccountInformation {
	
	NSString *testString = [NSString stringWithString:@"test_api_key"];
	NSInteger testAccountID = 1234567;
	
	[NewRelicAPIClient setAccountID:testAccountID withAPIKey:testString];
	[[NRUserDefaults sharedDefaults] killAll];
	
	NSString *afterKillAPIKey = [[NRUserDefaults sharedDefaults] APIKey];
	NSInteger afterKillAccountID = [[NRUserDefaults sharedDefaults] accountID];
	
	STAssertNil(afterKillAPIKey, @"API Key was not deleted from Client.");
	STAssertTrue(afterKillAccountID <= 0, @"Account ID was not deleted from Client.");
}

@end