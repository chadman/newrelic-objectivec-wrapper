

#import "NRBaseQO.h"

@interface NRMetricDataQO : NRBaseQO

// The application names to pull metric data for. 
// The application name must be an exact match.
// Both apps and appIDs cannot be populated
@property (nonatomic, copy) NSArray *apps;

// The application ids to pull metric data for. 
// The application id must be an exact match.
// Both apps and appIDs cannot be populated
@property (nonatomic, copy) NSArray *appIDs;

// Begin time, in XML UTC format. (note that the New Relic site graphs 
// are NOT in UTC format, so when comparing results, be sure to convert)
@property (nonatomic, retain) NSDate *begin;

// End time, in XML UTC format. (note that the New Relic site graphs 
// are NOT in UTC format, so when comparing results, be sure to convert)
@property (nonatomic, retain) NSDate *end;

// Included one or many times, this 
// lists the metrics you are interested in.
@property (nonatomic, copy) NSArray *metrics;

// Each metric supports different fields, such as ‘average_response_time’. 
// If the field is not valid for a given metric, you will get a blank value, 
// and if there are no valid fields for the metrics you request, you will get an error.
@property (nonatomic, copy) NSString *field;

// This determines whether you get back a single value aggregated over the 
// entire time period, or a time series. Summary results do not include the 
// begin and end times in the result. Time series results 
// give you a separate row for each time segment.
@property (nonatomic, assign) BOOL summary;


- (NSString *) createQueryString;

@end
