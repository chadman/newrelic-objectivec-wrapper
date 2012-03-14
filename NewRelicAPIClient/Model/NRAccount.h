//
//  NRAccount.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRAccount : NSObject <NSCoding>
	
@property (nonatomic, assign) NSInteger accountID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *applications;


+ (NRAccount *) populateWithDictionary: (NSDictionary *)dict;



@end
