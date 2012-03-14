

#import "NRMetricNameQO.h"

@implementation NRMetricNameQO

@synthesize regularExpression;
@synthesize limit;



- (NSString *) createQueryString {
	
	NSMutableString *queryString = [NSMutableString stringWithString:@"?"];
	bool firstParameter = true;
	
	if (regularExpression) {
		[queryString appendFormat:@"re=%@", regularExpression];
		firstParameter = false;
	}
	
	if (limit > 0) {
	
		if (!firstParameter) {
			[queryString appendString:@"&"];
		}
		
		[queryString appendFormat:@"limit=%d", limit];
	}
	
	return [queryString copy];
	
}

@end
