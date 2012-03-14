
#import <SenTestingKit/SenTestingKit.h>

@interface BaseTests : SenTestCase

extern NSString * const kTestNewRelicAPIKey;
extern int const kTestNewRelicAccountID;
extern NSString * const kTestApplicationName;


- (void) runLoop;

@end
