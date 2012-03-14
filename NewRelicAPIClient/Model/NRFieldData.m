//
//  NRFieldData.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRFieldData.h"

@interface NRFieldData (PRIVATE)

- (NRFieldData *)initWithDictionary: (NSDictionary *)dict;

@end


@implementation NRFieldData

@synthesize name;
@synthesize value;

#pragma mark - Population Methods

+ (NRFieldData *)populateWithDictionary:(NSDictionary *)dict {
	return [[NRFieldData alloc] initWithDictionary:dict];
}

- (NRFieldData *)initWithDictionary:(NSDictionary *)dict {
	if (![super init]) {
		return nil;
	}
	
	self.name = [dict objectForKey:@"@name"];
	self.value = [dict objectForKey:@"text"];
	
	return self;
}



#pragma mark - NSCoding Methods

- (id) initWithCoder: (NSCoder *)coder {
	
	self = [[NRFieldData alloc] init];
	
	if (self != nil) {
		self.name = [coder decodeObjectForKey:@"name"];
		self.value = [coder decodeObjectForKey:@"value"];
	}
	
	return self;
}

- (void) encodeWithCoder: (NSCoder *)coder {
	
	[coder encodeObject:name forKey:@"name"];
	[coder encodeObject:value forKey:@"value"];
}


@end