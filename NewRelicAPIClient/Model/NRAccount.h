

#import <Foundation/Foundation.h>

@interface NRAccount : NSObject <NSCoding>
	
@property (nonatomic, assign) NSInteger accountID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSArray *applications;


+ (NRAccount *) populateWithDictionary: (NSDictionary *)dict;



@end
