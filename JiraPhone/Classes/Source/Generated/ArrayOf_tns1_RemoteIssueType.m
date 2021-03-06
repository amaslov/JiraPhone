/*
	ArrayOf_tns1_RemoteIssueType.h
	The implementation of properties and methods for the ArrayOf_tns1_RemoteIssueType array.
	Generated by SudzC.com
*/
#import "ArrayOf_tns1_RemoteIssueType.h"
#import "RemoteIssueType.h"

@implementation ArrayOf_tns1_RemoteIssueType

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[[ArrayOf_tns1_RemoteIssueType alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				RemoteIssueType* value = [[RemoteIssueType newWithNode: child] object];
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
			[s appendString: [item serialize: @"RemoteIssueType"]];
		}
		return s;
	}
@end
