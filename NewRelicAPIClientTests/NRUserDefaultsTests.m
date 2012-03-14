

#import "NRUserDefaultsTests.h"
#import "NRUserDefaults.h"

@implementation NRUserDefaultsTests


- (void) testSettingAPIKey {
	
	
	NSString *testString = [NSString stringWithString:@"test_api_key"];
	[[NRUserDefaults sharedDefaults] setAPIKey:testString];
	
	
	STAssertEquals(testString, [[NRUserDefaults sharedDefaults] APIKey], @"API Keys do not match, it was not set");
	
	[[NRUserDefaults sharedDefaults] killAll];
}

- (void) testSettingAccountID {
	
	NSInteger testAccountID = 1234567;
	[[NRUserDefaults sharedDefaults] setAccountID:testAccountID];
	
	STAssertEquals(testAccountID, [[NRUserDefaults sharedDefaults] accountID], @"Account IDs do not match, it was not set");
	
	[[NRUserDefaults sharedDefaults] killAll];
	
}

- (void) testKillAll {
	
	NSString *testString = [NSString stringWithString:@"test_api_key"];
	[[NRUserDefaults sharedDefaults] setAPIKey:testString];
	
	NSInteger testAccountID = 1234567;
	[[NRUserDefaults sharedDefaults] setAccountID:testAccountID];
	
	[[NRUserDefaults sharedDefaults] killAll];
	
	STAssertNil([[NRUserDefaults sharedDefaults] APIKey], @"API Key is not nil, it was not deleted from defaults.");
	STAssertTrue([[NRUserDefaults sharedDefaults] accountID] <= 0, @"Account ID is not nil, it was not deleted from defaults.");
}

@end
