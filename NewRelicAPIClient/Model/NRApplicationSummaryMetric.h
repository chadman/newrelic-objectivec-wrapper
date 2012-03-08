//
//  NRApplicationSummaryMetric.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRApplicationSummaryMetrics : NSObject

+ (NSArray *) getByApplicationID: (NSInteger)appID;

@end
