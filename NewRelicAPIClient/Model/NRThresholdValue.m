

#import "NRThresholdValue.h"
#import "Utility.h"
#import "NRUserDefaults.h"

@interface NRThresholdValue (PRIVATE)

- (NRThresholdValue *)initWithDictionary: (NSDictionary *)dict;

@end

@implementation NRThresholdValue

@synthesize name;
@synthesize beginTime;
@synthesize endTime;
@synthesize formattedMetricValue;
@synthesize metricValue;
@synthesize thresholdValue;



+ (NRThresholdValue *)populateWithDictionary:(NSDictionary *)dict {
	return [[NRThresholdValue alloc] initWithDictionary:dict];
}

- (NRThresholdValue *)initWithDictionary:(NSDictionary *)dict {
	if (![super init]) {
		return nil;
	}
	
	self.name = [dict objectForKey:@"@name"];
	self.beginTime = [Utility convertToCustomNSDate:[dict objectForKey:@"@begin_time"] formatter:@"yyyy-MM-dd HH:mm:ss"];
	self.endTime = [Utility convertToCustomNSDate:[dict objectForKey:@"@end_time"] formatter:@"yyyy-MM-dd HH:mm:ss"];
	self.formattedMetricValue = [dict objectForKey:@"@formatted_metric_value"];
	self.metricValue = [Utility convertToFloat:[dict objectForKey:@"@metric_value"]];
	self.thresholdValue = [Utility convertToInt:[dict objectForKey:@"@threshold_value"]];
	
	return self;
}



#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
	
	self = [[NRThresholdValue alloc] init];
	
	if (self != nil) {
		self.name = [coder decodeObjectForKey:@"name"];
		self.beginTime = [coder decodeObjectForKey:@"beginTime"];
		self.endTime = [coder decodeObjectForKey:@"endTime"];
		self.formattedMetricValue = [coder decodeObjectForKey:@"formattedMetricValue"];
		self.thresholdValue = [coder decodeIntForKey:@"threshholdValue"];
		self.metricValue = [coder decodeIntForKey:@"metricValue"];
	}
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
	
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:beginTime forKey:@"beginTime"];
	[coder encodeObject:endTime forKey:@"endTime"];
	[coder encodeObject:formattedMetricValue forKey:@"formattedMetricValue"];
	[coder encodeInt:thresholdValue forKey:@"threshholdValue"];
	[coder encodeInt:metricValue forKey:@"metricValue"];
}

@end
