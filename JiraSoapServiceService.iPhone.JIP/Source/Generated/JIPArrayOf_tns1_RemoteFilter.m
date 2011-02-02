/*
	JIPArrayOf_tns1_RemoteFilter.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemoteFilter array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemoteFilter.h"

@implementation JIPArrayOf_tns1_RemoteFilter

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemoteFilter alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemoteFilter* value = [[JIPRemoteFilter newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteFilter"]];
		}
		return s;
	}
@end
