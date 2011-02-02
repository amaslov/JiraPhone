/*
	JIPArrayOf_tns1_RemoteAttachment.h
	The implementation of properties and methods for the JIPArrayOf_tns1_RemoteAttachment array.
	Generated by SudzC.com
*/
#import "JIPArrayOf_tns1_RemoteAttachment.h"

@implementation JIPArrayOf_tns1_RemoteAttachment

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[JIPArrayOf_tns1_RemoteAttachment alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				JIPRemoteAttachment* value = [[JIPRemoteAttachment newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteAttachment"]];
		}
		return s;
	}
@end
