//
//  NRMetricName.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRMetricName.h"
#import "Utility.h"
#import "NRUserDefaults.h"
#import "WebRequest.h"
#import "NRMetricNameQO.h"


@interface NRMetricName (PRIVATE)

- (NRMetricName *)initWithDictionary: (NSDictionary *)dict;

@end

@implementation NRMetricName
@synthesize name;
@synthesize fields;



#pragma mark - API Access Methods

+ (NSArray *) getAllByApplicationID: (NSInteger)appID error:(NSError **)error {
	
	/*
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://api.newrelic.com/api/v1/applications/%d/metrics.xml?limit=100", appID];
	
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
			[metrics addObject:[NRMetricName populateWithDictionary:value]];
		}
		
		return [metrics copy];
	}
	
	return nil;
	*/
	
	NSMutableDictionary* details = [NSMutableDictionary dictionary];
	[details setValue:@"method not implemented" forKey:NSLocalizedDescriptionKey];
	
	*error = [NSError errorWithDomain:@"com.52projects.newrelicapi" code:500 userInfo:details];
	return nil;
}

+ (void)getAllByApplicationID: (NSInteger)appID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
	
	
	/*
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://api.newrelic.com/api/v1/applications/%d/metrics.xml?limit=100", appID];
	
	[request makeWebRequest:[NSURL URLWithString:stringURL] 
			withContentType:WebRequestContentTypeXml 
			  usingCallback:^(id returnedResults) {
				  
				  NSMutableArray *metrics = [[NSMutableArray alloc] initWithObjects:nil];
				  NSDictionary *metricResults = nil;
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  
					  if ([returnedResults isKindOfClass:[NSDictionary class]]) {
						  metricResults = [((NSDictionary *)returnedResults) objectForKey:@"metrics"];
					  }
					  
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in [metricResults objectForKey:@"metric"]) {
						  [metrics addObject:[NRMetricName populateWithDictionary:value]];
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
	 */
	
	NSMutableDictionary* details = [NSMutableDictionary dictionary];
	[details setValue:@"method not implemented" forKey:NSLocalizedDescriptionKey];
	
	errorBlock([NSError errorWithDomain:@"com.52projects.newrelicapi" code:500 userInfo:details]);
}

+ (NSArray *) getAllByApplicationID: (NSInteger)appID withQuery: (NRMetricNameQO *)qo error:(NSError **)error {
	
	 WebRequest *request = [[WebRequest alloc] init];
	 NSString *stringURL = [NSString stringWithFormat:@"https://api.newrelic.com/api/v1/applications/%d/metrics.xml%@", appID, [qo createQueryString]];
	 
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
	 [metrics addObject:[NRMetricName populateWithDictionary:value]];
	 }
	 
	 return [metrics copy];
	 }
	 
	 return nil;
}

+ (void)getAllByApplicationID: (NSInteger)appID  withQuery:(NRMetricNameQO *)qo usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
	
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://api.newrelic.com/api/v1/applications/%d/metrics.xml%@", appID, [qo createQueryString]];
	
	[request makeWebRequest:[NSURL URLWithString:stringURL] 
			withContentType:WebRequestContentTypeXml 
			  usingCallback:^(id returnedResults) {
				  
				  NSMutableArray *metrics = [[NSMutableArray alloc] initWithObjects:nil];
				  NSDictionary *metricResults = nil;
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  
					  if ([returnedResults isKindOfClass:[NSDictionary class]]) {
						  metricResults = [((NSDictionary *)returnedResults) objectForKey:@"metrics"];
					  }
					  
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in [metricResults objectForKey:@"metric"]) {
						  [metrics addObject:[NRMetricName populateWithDictionary:value]];
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

+ (NRMetricName *)populateWithDictionary:(NSDictionary *)dict {
	return [[NRMetricName alloc] initWithDictionary:dict];
}

- (NRMetricName *)initWithDictionary:(NSDictionary *)dict {
	if (![super init]) {
		return nil;
	}
	
	self.name = [dict objectForKey:@"name"];
	
	// If there are threshhold values then populate em
	if ([dict objectForKey:@"fields"]) {
		
		NSMutableArray *localFields = [[NSMutableArray alloc] initWithObjects:nil];
		NSDictionary *fieldsArray = [dict objectForKey:@"fields"];
		
		for (NSDictionary *value in [fieldsArray objectForKey:@"field"]) {
			[localFields addObject:[value objectForKey:@"@name"]];
		}
		
		self.fields = localFields;
	}
	
	return self;
}



#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
	
	self = [[NRMetricName alloc] init];
	
	if (self != nil) {
		self.name = [coder decodeObjectForKey:@"name"];
		self.fields = [coder decodeObjectForKey:@"fields"];
	}
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
	
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:fields forKey:@"fields"];
}

@end
