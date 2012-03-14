//
//  NRApplication.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRApplication : NSObject <NSCoding>

@property (nonatomic, assign) NSInteger applicationID;
@property (strong) NSString *name;
@property (strong) NSString *overviewURL;
@property (strong) NSArray *threshholdValues;


+ (NRApplication *) populateWithDictionary: (NSDictionary *)dict;


/*! 
 @method      getAll:
 
 @abstract 
 Performs a synchronous call the New Relic API Application
 resource. It assumes the developer has set the account id
 and the API key.
 
 
 @discussion
 
 @param
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 @result      An array of NR Application objects or nil if 
 the load failed.
 */
+ (NSArray *)getAll: (NSError **)error;


/*! 
 @method      getAllUsingCallback:
 
 @abstract 
 Performs a asynchronous call the New Relic API Application
 resource. It assumes the developer has set the account id
 and the API key.
 
 
 @discussion
 
 @param
 resultsBlock	The block that is performed after the
 request to the new relic api has happened.
 
 @param
 errorBlock	If the requests errors for any reason, a block is available for that

 */
+ (void)getAllUsingCallback:(void (^)(NSArray *))resultsBlock error:(void (^)(NSError *))errorBlock;


/*! 
 @method      delete:
 
 @abstract 
 Deletes the specific application. The application will be deleted
 in New Relic, use with caution
 
 
 @discussion
 Deleting an application can be dangerous and you can lose all
 the data pertaining to that application. It is suggested that 
 when using this method that there is a confirmation question 
 given to the user before performing
 
 @param
 error     Out parameter (may be NULL) used if an error occurs
 while processing the request. Will not be modified if the 
 load succeeds.
 
 */
- (void) delete: (NSError **)error;



@end
