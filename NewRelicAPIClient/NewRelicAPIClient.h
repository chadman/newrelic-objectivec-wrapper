

#import <Foundation/Foundation.h>

@interface NewRelicAPIClient : NSObject


// Sets the account id for the session along with the API key to do future API calls
+ (void) setAccountID: (NSInteger)accountID withAPIKey:(NSString *)apiKey;


// Removing the keys is similiar to logging out. It will clear out the api key and account id
+ (void) removeKeys;

@end
