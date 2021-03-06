/*
	JIPArrayOf_tns1_RemoteFieldValue.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemoteFieldValue array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemoteFieldValue.h"

@implementation JIPArrayOf_tns1_RemoteFieldValue

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemoteFieldValue alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemoteFieldValue* value = [[JIPRemoteFieldValue newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteFieldValue"]];
		}
		return s;
	}
@end
