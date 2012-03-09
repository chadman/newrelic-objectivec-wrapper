
#import "WebRequest.h"
#import "NRUserDefaults.h"
#import "JSON.h"
#import "NRXMLParser.h"

@interface WebRequest (PRIVATE)

- (NSString *) contentType:(WebRequestContentType)type;

@end


@implementation WebRequest

@synthesize requestURL;
@synthesize responseData;
@synthesize requestError;
@synthesize storedBlock;


- (void) makeWebRequest: (NSURL *) theUrl withContentType: (WebRequestContentType)contentType usingCallback:(void (^)(id))returnedResults {
    
    NSLog(@"Making request to %@", theUrl);
    
    self.storedBlock = returnedResults;
	
	// Create the request 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];	
	
	[request setValue:[[NRUserDefaults sharedDefaults] APIKey] forHTTPHeaderField:@"x-api-key"];
	[request setValue:[self contentType:contentType] forHTTPHeaderField:@"Content-Type"]; 
	
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
}

- (id) putWebRequest:(NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData:(NSData *)data withError:(NSError **)error {
	
	NSURLResponse *localResponse = nil;
    
    // Create the request 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];
	[request setValue:[[NRUserDefaults sharedDefaults] APIKey] forHTTPHeaderField:@"x-api-key"];
	[request setValue:[self contentType:contentType] forHTTPHeaderField:@"Content-Type"]; 
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
	
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
														  returningResponse:&localResponse
																	  error:&*error];
	if (*error) {
        NSLog(@"Error occurred :: %@", *error);
		return nil;
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Web Request Response :: %@", responseBody);
		
		// Create new SBJSON parser object   
		return [responseBody JSONValue];
    }
}


- (void) putWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults {
    
    NSLog(@"Posting request to %@", theUrl);
    
    self.storedBlock = returnedResults;
    
    // Create the request 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];	
	[request setValue:[[NRUserDefaults sharedDefaults] APIKey] forHTTPHeaderField:@"x-api-key"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; 
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:data];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
}

- (id) postWebRequest:(NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData:(NSData *)data withError:(NSError **)error {

    NSLog(@"Posting request to %@", theUrl);
	
	NSError *localError = nil;
	NSURLResponse *localResponse = nil;
    
    // Create the request 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setValue:[[NRUserDefaults sharedDefaults] APIKey] forHTTPHeaderField:@"x-api-key"];
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; 
	[request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
	
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
                                                          returningResponse:&localResponse
                                                                      error:&localError];
	
	if (localError) {
        NSLog(@"Error occurred :: %@", localError);
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Web Request Response :: %@", responseBody);
		
		// Create new SBJSON parser object   
		return [responseBody JSONValue];
    }
    
    return localError;
}

- (void) postWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withData: (NSData *)data usingCallback:(void (^)(id))returnedResults {
    
    NSLog(@"Posting request to %@", theUrl);
    
    self.storedBlock = returnedResults;
    
    // Create the request 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];	
	[request setValue:[[NRUserDefaults sharedDefaults] APIKey] forHTTPHeaderField:@"x-api-key"];
	[request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"]; 
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
	responseData = [NSMutableData data];
}

- (id) makeWebRequest: (NSURL *)theUrl withContentType: (WebRequestContentType)contentType withError:(NSError **)error {

	NSURLResponse *localResponse = nil;
    
	// Create the request 
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:theUrl];
	[request setCachePolicy:NSURLRequestReloadIgnoringCacheData];
	[request setHTTPMethod:@"GET"];
	[request setValue:[[NRUserDefaults sharedDefaults] APIKey] forHTTPHeaderField:@"x-api-key"];
	[request setValue:[self contentType:contentType] forHTTPHeaderField:@"Content-Type"]; 
	
	responseData = (NSMutableData *)[NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&localResponse
                                                     error:&*error];
	if (*error) {
        NSLog(@"Error occurred :: %@", *error);
		return nil;
    }
    else {
        NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"Web Request Response :: %@", responseBody);
		
		switch (contentType) {
			case WebRequestContentTypeXml:
				return [NRXMLParser dictionaryForXMLString:responseBody error:&*error];
			case WebRequestContentTypeJson:
				return [responseBody JSONValue];
			default:
				break;
		}
    }
	
	return nil;
}


#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)aResponse {
	response = aResponse;
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data {
	[responseData appendData:data];
	
	int statusCode = [((NSHTTPURLResponse *)response) statusCode];
   
	if (statusCode >= 400) {
			[connection cancel];  // stop connecting; no more delegate messages
			NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
											  NSLocalizedString(@"Server returned status code %d",@""),
											  statusCode]
									  forKey:NSLocalizedDescriptionKey];
        NSError *statusError = [NSError errorWithDomain:@"dontknow"
							  code:statusCode
						  userInfo:errorInfo];
		
		self.storedBlock(statusError);
    }
}

- (void)connection:(NSURLConnection *)aConnection didFailWithError:(NSError *)webError {
    self.storedBlock(webError);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
	
	NSString *responseBody = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	NSLog(@"Web Request Response :: %@", responseBody);
    
    self.storedBlock([responseBody JSONValue]);
}


#pragma mark Private Methods

- (NSString *) contentType:(WebRequestContentType)type  {
	
	switch (type) {
		case WebRequestContentTypeXml:
			return @"application/xml";
		case WebRequestContentTypeJson:
			return @"application/json";
	}
	
	return nil;
}

@end
