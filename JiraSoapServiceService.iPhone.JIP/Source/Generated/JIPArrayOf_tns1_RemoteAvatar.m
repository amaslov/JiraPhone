/*
	JIPArrayOf_tns1_RemoteAvatar.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemoteAvatar array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemoteAvatar.h"

@implementation JIPArrayOf_tns1_RemoteAvatar

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemoteAvatar alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemoteAvatar* value = [[JIPRemoteAvatar newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteAvatar"]];
		}
		return s;
	}
@end
