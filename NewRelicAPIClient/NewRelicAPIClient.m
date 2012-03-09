//
//  NewRelicAPIClient.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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
