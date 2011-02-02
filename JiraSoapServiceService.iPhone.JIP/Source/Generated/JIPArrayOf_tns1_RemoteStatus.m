/*
	JIPArrayOf_tns1_RemoteStatus.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemoteStatus array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemoteStatus.h"

@implementation JIPArrayOf_tns1_RemoteStatus

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemoteStatus alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemoteStatus* value = [[JIPRemoteStatus newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteStatus"]];
		}
		return s;
	}
@end
