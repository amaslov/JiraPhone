/*
	ArrayOf_tns1_RemoteIssue.h
	The implementation of properties and methods for the ArrayOf_tns1_RemoteIssue array.
	Generated by SudzC.com
*/
#import "ArrayOf_tns1_RemoteIssue.h"
#import "RemoteIssue.h"

@implementation ArrayOf_tns1_RemoteIssue

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[ArrayOf_tns1_RemoteIssue alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [super init]) {
			for(CXMLElement* child in [node children])
			{
				// skip not issue elements
				if (![Soap getNodeValue:child withName:@"key"]) {
					continue;
				}
				
				RemoteIssue* value = [[RemoteIssue newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteIssue"]];
		}
		return s;
	}
@end
