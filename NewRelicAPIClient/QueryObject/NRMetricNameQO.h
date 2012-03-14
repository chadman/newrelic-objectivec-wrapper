

#import "NRBaseQO.h"

@interface NRMetricNameQO : NRBaseQO

// A regular expression to filter the metric names by. Optional
@property (nonatomic, copy) NSString * regularExpression;

// The number of metrics to retrieve. Optional. By default the limit is 5000.
@property (nonatomic, assign) NSInteger limit;

- (NSString *) createQueryString;

@end
