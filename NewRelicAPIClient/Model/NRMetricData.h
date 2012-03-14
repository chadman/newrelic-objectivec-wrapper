//
//  NRMetricData.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class NRFieldData;
@class NRMetricDataQO;

@interface NRMetricData : NSObject <NSCoding>

+ (NRMetricData *) populateWithDictionary: (NSDictionary *)dict;

@property (nonatomic, retain) NSDate *begin;
@property (nonatomic, retain) NSDate *end;
@property (nonatomic, copy) NSString *app;
@property (nonatomic, copy) NSString *metricName;
@property (nonatomic, retain) NRFieldData *field;



/*! 
 @method      getByQO:error:
 
 @abstract 
 Performs a synchronous call the New Relic API Metric
 resource. It assumes the developer has set the account id
 and the API key.
 
 
 @discussion
 
 @param	
 qo		The query object holding the information to search
 the API for. Refer to the header file of NRMetricDataQO
 for more information
 
 @param
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 @result      An array of metric objects or nil if 
 the load failed.
 */
+ (NSArray *)getByQO: (NRMetricDataQO *)qo error: (NSError **)error;


/*! 
 
 @method	
 
 @abstract 
 Performs an asynchronous call the New Relic API Metric
 resource. It assumes the developer has set the account id
 and the API key.
 
 
 @discussion
 
 @param	
 qo		The query object holding the information to search
 the API for. Refer to the header file of NRMetricDataQO
 for more information

 @param
 resultsBlock	The block that is performed after the
 request to the new relic api has happened.
 
 @param
 errorBlock	If the requests errors for any reason, a block is available for that
 
 
 @result      An array of metric objects or nil if 
 the load failed.

 */
+ (void)getByQO:(NRMetricDataQO *)qo usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;

@end

