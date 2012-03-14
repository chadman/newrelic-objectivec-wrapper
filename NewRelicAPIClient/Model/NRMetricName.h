//
//  NRMetricName.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NRMetricNameQO;

@interface NRMetricName : NSObject <NSCoding>

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSArray *fields;

+ (NRMetricName *) populateWithDictionary: (NSDictionary *)dict;

/*! 
 @method      getAllByApplicationID:error:
 
 @abstract 
 Performs a synchronous call the New Relic API Metric Name
 resource. It assumes the developer has set the account id
 and the API key.
 
 
 @discussion
 This is a pretty long query in itself. There is a lot of 
 data that is returned and it really depends on the amount
 of pages the user has for a specific application
 
 I am going to limit this query to only pull back 100 results
 I do not think this is a very good query for New Relic to allow.
 The information returned while has a place, I'm not quite sure
 the API is the correct place. Placing a limit doesn't give you
 counts or additional pages or anything so there is no way to
 page through the data set.
 
 @param
 appliationID	The appliation that the user will be searching
 on. This can be found in the New Relic url or by calling
 the NRAppliation getAll method
 
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 @result      An array of NR Application objects or nil if 
 the load failed.
 
 WARNING: After consideration, I have decided to not allow
 the use of these methods. If there is a need to get metric 
 names, a Query Object will have to be present
 */

+ (NSArray *) getAllByApplicationID: (NSInteger)appID error:(NSError **)error;


/*! 
 @method      getAllByApplicationID:usingCallback:error:
 
 @abstract 
 Performs a asynchronous call the New Relic API Application
 summary metrics resource. It assumes the developer has set 
 the account id and the API key.  
 
 
 @discussion
 This is a pretty long query in itself. There is a lot of 
 data that is returned and it really depends on the amount
 of pages the user has for a specific application
 
 I am going to limit this query to only pull back 100 results
 I do not think this is a very good query for New Relic to allow.
 The information returned while has a place, I'm not quite sure
 the API is the correct place. Placing a limit doesn't give you
 counts or additional pages or anything so there is no way to
 page through the data set.
 
 @param
 appID	The application ID to query against in the New Relic
 API. Get a listing of applications by running the 
 NRApplication getAll method.
 
 @param
 resultsBlock	The block that is performed after the
 request to the new relic api has happened. The results
 will be an NSArray of NRThreshholdValues
 
 @param
 errorBlock	If the requests errors for any reason, a block is 
 available for that
 
 WARNING: After consideration, I have decided to not allow
 the use of these methods. If there is a need to get metric 
 names, a Query Object will have to be present
 */


+ (void)getAllByApplicationID: (NSInteger)appID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;



/*! 
 @method      getAllByApplicationID:error:
 
 @abstract 
 Performs a synchronous call the New Relic API Metric Name
 resource. It assumes the developer has set the account id
 and the API key.
 
 
 @discussion
 
 @param
 appID	The appliation that the user will be searching
 on. This can be found in the New Relic url or by calling
 the NRAppliation getAll method
 
 @param
 qo		The query object that will hold the regular expression
 and the limit for the request
 
 @param
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 @result      An array of NR Application objects or nil if 
 the load failed.
 */

+ (NSArray *) getAllByApplicationID: (NSInteger)appID withQuery: (NRMetricNameQO *)qo error:(NSError **)error;



/*! 
 @method      getAllByApplicationID:usingCallback:error:
 
 @abstract 
 Performs a asynchronous call the New Relic API Application
 summary metrics resource. It assumes the developer has set 
 the account id and the API key.  
 
 
 @discussion
 This is a pretty long query in itself. There is a lot of 
 data that is returned and it really depends on the amount
 of pages the user has for a specific application
 
 I am going to limit this query to only pull back 100 results
 I do not think this is a very good query for New Relic to allow.
 The information returned while has a place, I'm not quite sure
 the API is the correct place. Placing a limit doesn't give you
 counts or additional pages or anything so there is no way to
 page through the data set.
 
 @param
 appID	The appliation that the user will be searching
 on. This can be found in the New Relic url or by calling
 the NRAppliation getAll method
 
 @param
 qo		The query object that will hold the regular expression
 and the limit for the request
 
 @param
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 @param
 resultsBlock	The block that is performed after the
 request to the new relic api has happened. The results
 will be an NSArray of NRThreshholdValues
 
 @param
 errorBlock	If the requests errors for any reason, a block is 
 available for that
 
 
 @result      An array of NR Metric Name objects or nil if 
 the load failed.
 
 */
 


+ (void)getAllByApplicationID: (NSInteger)appID  withQuery:(NRMetricNameQO *)qo usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;





@end
