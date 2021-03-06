/*
	ArrayOf_tns1_RemoteProjectRole.h
	The implementation of properties and methods for the ArrayOf_tns1_RemoteProjectRole array.
	Generated by SudzC.com
*/
#import "ArrayOf_tns1_RemoteProjectRole.h"
#import "RemoteProjectRole.h"

@implementation ArrayOf_tns1_RemoteProjectRole

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[ArrayOf_tns1_RemoteProjectRole alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				RemoteProjectRole* value = [[RemoteProjectRole newWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"RemoteProjectRole"]];
		}
		return s;
	}
@end
