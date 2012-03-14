

#import "NRBaseQO.h"

@implementation NRBaseQO

- (BOOL) getDirtyFlag: (id)value1 comparer: (id)value2 {
    
	return value1 != value2;
}

@end
