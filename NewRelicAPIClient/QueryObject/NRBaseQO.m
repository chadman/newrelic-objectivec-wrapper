//
//  NRBaseQO.m
//  NewRelicAPIClient
//
//  Created by Meyer, Chad on 3/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NRBaseQO.h"

@implementation NRBaseQO

- (BOOL) getDirtyFlag: (id)value1 comparer: (id)value2 {
    
	return value1 != value2;
}

@end
