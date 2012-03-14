//
//  NRMetricData.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRMetricData.h"
#import "Utility.h"
#import "NRFieldData.h"
#import "WebRequest.h"
#import	"NRUserDefaults.h"
#import "NRMetricDataQO.h"

@interface NRMetricData (PRIVATE)

- (NRMetricData *)initWithDictionary: (NSDictionary *)dict;

@end

@implementation NRMetricData
@synthesize begin;
@synthesize end;
@synthesize app;
@synthesize metricName;
@synthesize field;



#pragma mark - Data Population Methods

+ (NSArray *)getByQO: (NRMetricDataQO *)qo error: (NSError **)error {
	
	
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://api.newrelic.com/api/v1/accounts/%d/metrics/data.xml%@", [[NRUserDefaults sharedDefaults] accountID], [qo createQueryString]];
	
	NSDictionary *results = [[request makeWebRequest:[NSURL URLWithString:stringURL] 
									 withContentType:WebRequestContentTypeXml 
										   withError:&*error] objectForKey:@"metrics"];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		
		NSMutableArray *metrics = [[NSMutableArray alloc] initWithObjects:nil];
		
		// Go through each one and add to the applications to an array
		for (NSDictionary *value in [results objectForKey:@"metric"]) {
			[metrics addObject:[NRMetricData populateWithDictionary:value]];
		}
		
		return [metrics copy];
	}
	
	return nil;
	
}

+ (void)getByQO:(NRMetricDataQO *)qo usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
	
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://api.newrelic.com/api/v1/accounts/%d/metrics/data.xml%@", [[NRUserDefaults sharedDefaults] accountID], [qo createQueryString]];
	
	
	[request makeWebRequest:[NSURL URLWithString:stringURL] 
			withContentType:WebRequestContentTypeXml 
			  usingCallback:^(id returnedResults) {
				  
				  NSMutableArray *metrics = [[NSMutableArray alloc] initWithObjects:nil];
				  NSDictionary *metricsResults = nil;
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  
					  if ([returnedResults isKindOfClass:[NSDictionary class]]) {
						  metricsResults = [((NSDictionary *)returnedResults) objectForKey:@"metrics"];
					  }
					  
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in [metricsResults objectForKey:@"metric"]) {
						  [metrics addObject:[NRMetricData populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([metrics copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];

	
}


#pragma mark - Population Methods

+ (NRMetricData *)populateWithDictionary:(NSDictionary *)dict {
	return [[NRMetricData alloc] initWithDictionary:dict];
}

- (NRMetricData *)initWithDictionary:(NSDictionary *)dict {
	if (![super init]) {
		return nil;
	}
	
	self.begin = [Utility convertToFullNSDate:[dict	objectForKey:@"@begin"]];
	self.end = [Utility convertToFullNSDate:[dict objectForKey:@"@end"]];
	self.app = [dict objectForKey:@"@app"];
	self.metricName = [dict objectForKey:@"@name"];
	self.field = [NRFieldData populateWithDictionary:[dict objectForKey:@"field"]];
	
	return self;
}



#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
	
	self = [[NRMetricData alloc] init];
	
	if (self != nil) {
		self.begin = [coder decodeObjectForKey:@"begin"];
		self.end = [coder decodeObjectForKey:@"end"];
		self.app = [coder decodeObjectForKey:@"app"];
		self.metricName = [coder decodeObjectForKey:@"metricName"];
		self.field = [coder decodeObjectForKey:@"field"];
	}
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
	
	[coder encodeObject:begin forKey:@"begin"];
	[coder encodeObject:end forKey:@"end"];
	[coder encodeObject:app forKey:@"app"];
	[coder encodeObject:metricName forKey:@"metricName"];
	[coder encodeObject:field forKey:@"field"];
}


@end

