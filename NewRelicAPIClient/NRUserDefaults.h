

#import <Foundation/Foundation.h>

@interface NRUserDefaults : NSObject

+ (NRUserDefaults *) sharedDefaults;

- (NSString *) APIKey;

- (void) setAPIKey: (NSString *)apiKey;

- (NSInteger) accountID;

- (void) setAccountID: (NSInteger)accountID;

- (void) killAll;

@end
