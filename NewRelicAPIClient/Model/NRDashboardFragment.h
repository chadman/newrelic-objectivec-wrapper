

#import <Foundation/Foundation.h>

@interface NRDashboardFragment : NSObject

+ (NSString *) getForAllApplications;

+ (NSString *) getForApplication: (NSInteger)applicationID;

@end
