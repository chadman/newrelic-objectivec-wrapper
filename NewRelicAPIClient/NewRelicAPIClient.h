//
//  NewRelicAPIClient.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewRelicAPIClient : NSObject


// Sets the account id for the session along with the API key to do future API calls
+ (void) setAccountID: (NSString *)accountID withAPIKey:(NSString *)apiKey;

@end
