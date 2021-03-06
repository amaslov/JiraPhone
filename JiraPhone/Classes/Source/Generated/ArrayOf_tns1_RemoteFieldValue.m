/*
	ArrayOf_tns1_RemoteFieldValue.h
	The implementation of properties and methods for the ArrayOf_tns1_RemoteFieldValue array.
	Generated by SudzC.com
*/
#import "ArrayOf_tns1_RemoteFieldValue.h"
#import "RemoteFieldValue.h"

@implementation ArrayOf_tns1_RemoteFieldValue

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[ArrayOf_tns1_RemoteFieldValue alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				RemoteFieldValue* value = [[RemoteFieldValue newWithNode: child] object];
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
