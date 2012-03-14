//
//  NRFieldData.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRFieldData : NSObject <NSCoding> 


+ (NRFieldData *) populateWithDictionary: (NSDictionary *)dict;


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) id value;

@end