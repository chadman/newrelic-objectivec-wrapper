//
//  NRApplication.h
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NRApplication : NSObject

@property (nonatomic, assign) NSInteger applicationID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *overviewURL;


@end
