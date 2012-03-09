

#import <Foundation/Foundation.h>


/* Enum that informs the search methods what to include in the search parameters */
typedef enum {
	WebRequestContentTypeXml, // The content type of the request is xml
	WebRequestContentTypeJson, // The content type of the request is json
} WebRequestContentType;

@interface WebRequest : NSObject {

	NSURL *requestURL;
	NSURLResponse *response;
	NSURLConnection *connection;
	NSMutableData *responseData;
	NSError *requestError;
}

@property (nonatomic, retain) NSURL *requestURL;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic, retain) NSError *requestError;
@property(copy) void (^storedBlock)(id);

- (id) makeWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withError:(NSError **)error;

- (void) makeWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType usingCallback:(void (^)(id))returnedResults;

- (id) putWebRequest:(NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData:(NSData *)data withError:(NSError **)error;

- (void) putWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults;

- (id) postWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData: (NSData *)data withError:(NSError **)error;

- (void) postWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults;

@end

