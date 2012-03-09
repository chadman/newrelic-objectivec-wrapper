//
//  NRUserDefaults.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRUserDefaults : NSObject

+ (NRUserDefaults *) sharedDefaults;

- (NSString *) APIKey;

- (void) setAPIKey: (NSString *)apiKey;

- (NSInteger) accountID;

- (void) setAccountID: (NSInteger)accountID;

- (void) killAll;

@end
