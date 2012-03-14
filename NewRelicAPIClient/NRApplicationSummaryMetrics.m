//
//  NRApplicationSummaryMetrics.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRApplicationSummaryMetrics.h"
#import "WebRequest.h"
#import "JSON.h"
#import "Utility.h"
#import "NRUserDefaults.h"
#import "NRThresholdValue.h"

@interface NRApplicationSummaryMetrics (PRIVATE)

- (NRApplicationSummaryMetrics *)initWithDictionary: (NSDictionary *)dict;

@end


@implementation NRApplicationSummaryMetrics

+(NSArray *) getByApplicationID: (NSInteger)appID error:(NSError **)error {
	
	
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://rpm.newrelic.com/accounts/%d/applications/%d/threshold_values.xml", [[NRUserDefaults sharedDefaults] accountID], appID];
	
	NSDictionary *results = [[request makeWebRequest:[NSURL URLWithString:stringURL] 
									 withContentType:WebRequestContentTypeXml 
										   withError:&*error] objectForKey:@"threshold-values"];
	
	if (*error) {
		return nil;
	}
	
	if (results && ![results isEqual:[NSNull null]]) {
		
		NSMutableArray *applications = [[NSMutableArray alloc] initWithObjects:nil];
		
		// Go through each one and add to the applications to an array
		for (NSDictionary *value in [results objectForKey:@"threshold_value"]) {
			[applications addObject:[NRThresholdValue populateWithDictionary:value]];
		}
		
		return [applications copy];
	}
	
	return nil;
	
}

+ (void)getByApplicationID: (NSInteger)appID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock {
	
	
	WebRequest *request = [[WebRequest alloc] init];
	NSString *stringURL = [NSString stringWithFormat:@"https://rpm.newrelic.com/accounts/%d/applications/%d/threshold_values.xml", [[NRUserDefaults sharedDefaults] accountID], appID];
	
	
	[request makeWebRequest:[NSURL URLWithString:stringURL] 
			withContentType:WebRequestContentTypeXml 
			  usingCallback:^(id returnedResults) {
				  
				  NSMutableArray *applications = [[NSMutableArray alloc] initWithObjects:nil];
				  NSDictionary *applicationResults = nil;
				  
				  if (returnedResults && ![returnedResults isEqual:[NSNull null]]) {
					  
					  if ([returnedResults isKindOfClass:[NSDictionary class]]) {
						  applicationResults = [((NSDictionary *)returnedResults) objectForKey:@"threshold-values"];
					  }
					  
					  // Go through each one and add to the applications to an array
					  for (NSDictionary *value in [applicationResults objectForKey:@"threashold_value"]) {
						  [applications addObject:[NRThresholdValue populateWithDictionary:value]];
					  }
				  }
				  
				  // In case they are stupid enough to not create a results block
				  if (resultsBlock) {
					  resultsBlock([applications copy]);
				  }
			  }
				 errorBlock:^(NSError *localError) {
					 
					 if (errorBlock) {
						 errorBlock(localError);
					 }
				 }
	 ];
}

+ (NRApplicationSummaryMetrics *) populateWithDictionary: (NSDictionary *)dict {
	return nil;
}

- (NRApplicationSummaryMetrics *)initWithDictionary: (NSDictionary *)dict {
	return nil;
}


@end
