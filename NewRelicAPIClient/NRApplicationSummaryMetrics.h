

#import <Foundation/Foundation.h>

@interface NRApplicationSummaryMetrics : NSObject


/*! 
 @method      getByApplicationID: error:
 
 @abstract 
 Performs a synchronous call the New Relic API Application
 summary metrics resource. It assumes the developer has set 
 the account id and the API key.  
 
 @discussion
 
 @param
 appID	The application ID to query against in the New Relic
 API. Get a listing of applications by running the 
 NRApplication getAll method.
 
 @param
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 @result      Returns an NSArray containing NRThresholdValues
 */
+(NSArray *) getByApplicationID: (NSInteger)appID error:(NSError **)error;


/*! 
 @method      getByApplicationID:usingCallback:error:
 
 @abstract 
 Performs a asynchronous call the New Relic API Application
 summary metrics resource. It assumes the developer has set 
 the account id and the API key.  
 
 
 @discussion
 
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
 
 */
+ (void)getByApplicationID: (NSInteger)appID usingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;

@end
