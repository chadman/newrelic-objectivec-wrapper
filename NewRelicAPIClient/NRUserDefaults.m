

#import "NRUserDefaults.h"

@implementation NRUserDefaults

static NRUserDefaults *_sharedDefaults = nil;

+ (NRUserDefaults *) sharedDefaults {
	return _sharedDefaults;
}

+ (void)initialize {
    static BOOL initialized = NO;
    if(!initialized)
    {
        initialized = YES;
        _sharedDefaults = [[NRUserDefaults alloc] init];
    }
}


- (NSString *)APIKey {
	return [[NSUserDefaults standardUserDefaults] objectForKey:kNewRelicAPIKey];
}

- (void) setAPIKey:(NSString *)apiKey {
	
	[[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:kNewRelicAPIKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


- (NSInteger) accountID {
	return [[NSUserDefaults standardUserDefaults] integerForKey:kNewRelicAccountID];
}

- (void) setAccountID:(NSInteger)accountID {
	
	[[NSUserDefaults standardUserDefaults] setInteger:accountID forKey:kNewRelicAccountID];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) killAll {
	
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:kNewRelicAccountID];
	[[NSUserDefaults standardUserDefaults] removeObjectForKey:kNewRelicAPIKey];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

@end
