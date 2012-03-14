//
//  NRAccount.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRAccount.h"
#import "Utility.h"
#import "NRUserDefaults.h"
#import "NRApplication.h"


@interface NRAccount (PRIVATE)

- (NRAccount *)initWithDictionary: (NSDictionary *)dict;

@end

@implementation NRAccount

@synthesize accountID;
@synthesize name;
@synthesize applications;


+ (NRAccount *)populateWithDictionary:(NSDictionary *)dict {
	return [[NRAccount alloc] initWithDictionary:dict];
}

- (NRAccount *)initWithDictionary:(NSDictionary *)dict {
	if (![super init]) {
		return nil;
	}
	
	NSDictionary *results = [dict objectForKey:@"applications"];
	
	self.name = [dict objectForKey:@"@name"];
	self.accountID = [Utility convertToInt:[dict objectForKey:@"id"]];
	
	if (results && ![results isEqual:[NSNull null]]) {
		
		NSMutableArray *localApplications = [[NSMutableArray alloc] initWithObjects:nil];
		
		// Go through each one and add to the applications to an array
		for (NSDictionary *value in [results objectForKey:@"application"]) {
			[localApplications addObject:[NRApplication populateWithDictionary:value]];
		}
		
		self.applications = [localApplications copy];
	}
	
	return self;
}


#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
	
	self = [[NRAccount alloc] init];
	
	if (self != nil) {
		self.accountID = [coder decodeIntForKey:@"accountID"];
		self.name = [coder decodeObjectForKey:@"name"];
		self.applications = [coder decodeObjectForKey:@"applications"];
	}
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
	
	[coder encodeInt:accountID forKey:@"applicationID"];
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:applications forKey:@"applications"];
}


@end
