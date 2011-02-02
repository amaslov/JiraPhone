/*
	JIPArrayOf_tns1_RemotePermission.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemotePermission array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemotePermission.h"

@implementation JIPArrayOf_tns1_RemotePermission

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemotePermission alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemotePermission* value = [[JIPRemotePermission newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemotePermission"]];
		}
		return s;
	}
@end
