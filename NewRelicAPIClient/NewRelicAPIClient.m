

#import "NewRelicAPIClient.h"
#import "NRUserDefaults.h"

@implementation NewRelicAPIClient

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void)setAccountID:(NSInteger)accountID withAPIKey:(NSString *)apiKey {
	
	[[NRUserDefaults sharedDefaults] setAccountID:accountID];
	[[NRUserDefaults sharedDefaults] setAPIKey:apiKey];
}

+ (void)removeKeys {
	[[NRUserDefaults sharedDefaults] killAll];
}



@end
