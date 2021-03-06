/*
	ArrayOf_tns1_RemoteVersion.h
	The implementation of properties and methods for the ArrayOf_tns1_RemoteVersion array.
	Generated by SudzC.com
*/
#import "ArrayOf_tns1_RemoteVersion.h"
#import "RemoteVersion.h"

@implementation ArrayOf_tns1_RemoteVersion

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[ArrayOf_tns1_RemoteVersion alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				RemoteVersion* value = [[RemoteVersion newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteVersion"]];
		}
		return s;
	}
@end
