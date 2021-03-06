/*
	JIPArrayOf_tns1_RemotePermissionMapping.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemotePermissionMapping array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemotePermissionMapping.h"

@implementation JIPArrayOf_tns1_RemotePermissionMapping

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemotePermissionMapping alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemotePermissionMapping* value = [[JIPRemotePermissionMapping newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemotePermissionMapping"]];
		}
		return s;
	}
@end
