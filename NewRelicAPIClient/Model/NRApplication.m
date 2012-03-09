//
//  NRApplication.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRApplication.h"
#import "WebRequest.h"
#import "JSON.h"
#import "Utility.h"
#import "NRUserDefaults.h"

@interface NRApplication (PRIVATE)

- (NRApplication *)initWithDictionary: (NSDictionary *)dict;

@end

@implementation NRApplication

@synthesize applicationID;
@synthesize name;
@synthesize	overviewURL;
@synthesize threshholdValues;

+ (NSArray *)getAll:(NSError *__autoreleasing *)error {
	
	
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://rpm.newrelic.com/accounts/%d/applications.xml", [[NRUserDefaults sharedDefaults] accountID]];
	
	NSDictionary *results = [[request makeWebRequest:[NSURL URLWithString:stringURL] 
									 withContentType:WebRequestContentTypeXml 
										   withError:&*error] objectForKey:@"applications"];
						   
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		
		NSMutableArray *applications = [[NSMutableArray alloc] initWithObjects:nil];
		
		// Go through each one and add to the applications to an array
		for (NSDictionary *value in [results objectForKey:@"application"]) {
			[applications addObject:[NRApplication populateWithDictionary:value]];
		}
		
		return [applications copy];
	}
	
	return nil;
	
}

+ (NRApplication *)populateWithDictionary:(NSDictionary *)dict {
	return [[NRApplication alloc] initWithDictionary:dict];
}

- (NRApplication *)initWithDictionary:(NSDictionary *)dict {
	if (![super init]) {
		return nil;
	}
	
	self.applicationID = [Utility convertToInt:[[dict objectForKey:@"id"] objectForKey:@"text"]];
	self.name = [dict objectForKey:@"name"];
	self.overviewURL = [dict objectForKey:@"overview-url"];
	
	// If there are threshhold values then populate em
	if ([dict objectForKey:@"threshhold-values"]) {
		
		NSMutableArray *localThreshholdValues = [[NSMutableArray alloc] initWithObjects:nil];
		
		for (NSDictionary *value in [dict objectForKey:@"threshhold-values"]) {
			
		}
		
		self.threshholdValues = localThreshholdValues;
	}
	
	return self;
}



#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
	
	self = [[NRApplication alloc] init];
	
	if (self != nil) {
		self.applicationID = [coder decodeIntForKey:@"applicationID"];
		self.name = [coder decodeObjectForKey:@"name"];
		self.overviewURL = [coder decodeObjectForKey:@"overviewURL"];
		self.threshholdValues = [coder decodeObjectForKey:@"threshholdValues"];	
	}
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
	
	[coder encodeInt:applicationID forKey:@"applicationID"];
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:overviewURL forKey:@"overviewURL"];
	[coder encodeObject:threshholdValues forKey:@"threshholdValues"];
}


@end
