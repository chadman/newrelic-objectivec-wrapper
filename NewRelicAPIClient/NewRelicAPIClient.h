//
//  NewRelicAPIClient.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewRelicAPIClient : NSObject


// Sets the api key for the New Relic API
// Possible error of 403  for invalid API key
+ (void) setApiKey: (NSString *)apiKey;

@end
