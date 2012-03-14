
#import <Foundation/Foundation.h>

@interface NRThresholdValue : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSDate *beginTime;
@property (nonatomic, retain) NSDate *endTime;
@property (nonatomic, copy) NSString *formattedMetricValue;
@property (nonatomic, assign) NSInteger thresholdValue;
@property (nonatomic, assign) float metricValue;

+ (NRThresholdValue *) populateWithDictionary: (NSDictionary *)dict;

@end
