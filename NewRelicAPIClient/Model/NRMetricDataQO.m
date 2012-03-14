

#import "NRMetricDataQO.h"
#import "Utility.h"
#import "DateUtility.h"

@implementation NRMetricDataQO
@synthesize apps;
@synthesize appIDs;
@synthesize begin;
@synthesize end;
@synthesize metrics;
@synthesize field;
@synthesize summary;

- (NSString *) createQueryString {
	
	NSMutableString *queryString = [NSMutableString stringWithString:@"?"];
	bool firstParameter = true;
	
	if (apps && !appIDs) {
		
		for (NSString *currentApp in apps) {
			if (!firstParameter) {
				[queryString appendString:@"&"];
			}
			
			[queryString appendFormat:@"app[]=%@", [currentApp stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
			firstParameter = false;
		}
	}
	
	if (appIDs && !apps) {
		for (id currentAppID in appIDs) {
			if (!firstParameter) {
				[queryString appendString:@"&"];
			}
			
			[queryString appendFormat:@"app_id[]=%d", [Utility convertToInt:currentAppID]];
			firstParameter = false;
		}
	}
	
	if (begin) {
		if (!firstParameter) {
			[queryString appendString:@"&"];
		}
		
		[queryString appendFormat:@"begin=%@", [DateUtility stringFromDateAndTimeFrom:begin]];
		firstParameter = false;
	}
	
	if (end) {
		if (!firstParameter) {
			[queryString appendString:@"&"];
		}
		
		[queryString appendFormat:@"end=%@", [DateUtility stringFromDateAndTimeFrom:end]];
		firstParameter = false;
	}
	
	if (metrics) {
		for (id currentMetric in metrics) {
			if (!firstParameter) {
				[queryString appendString:@"&"];
			}
			
			[queryString appendFormat:@"metrics[]=%@", currentMetric];
			firstParameter = false;
		}
	}
	
	if (field) {
		if (!firstParameter) {
			[queryString appendString:@"&"];
		}
		
		[queryString appendFormat:@"field=%@", field];
		firstParameter = false;
	}
	
	if (!firstParameter) {
		[queryString appendString:@"&"];
	}
	
	[queryString appendFormat:@"summary=%d", summary];

	return [queryString copy];
	
}

@end
