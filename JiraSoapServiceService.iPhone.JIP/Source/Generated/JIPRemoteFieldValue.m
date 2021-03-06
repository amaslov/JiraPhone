/*
	JIPRemoteFieldValue.h
	The implementation of properties and methods for the JIPRemoteFieldValue object.
	Generated by SudzC.com
*/
#import "JIPRemoteFieldValue.h"

#import "JIPArrayOf_xsd_string.h"
@implementation JIPRemoteFieldValue
	@synthesize _id = __id;
	@synthesize values = _values;

	- (id) init
	{
		if(self = [super init])
		{
			self._id = nil;
			self.values = nil; // [[JIPArrayOf_xsd_string alloc] init];

		}
		return self;
	}

	+ (JIPRemoteFieldValue*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (JIPRemoteFieldValue*)[[[JIPRemoteFieldValue alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self._id = [Soap getNodeValue: node withName: @"id"];
			self.values = [[JIPArrayOf_xsd_string newWithNode: [Soap getNode: node withName: @"values"]] object];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemoteFieldValue"];
	}
  
	- (NSMutableString*) serialize: (NSString*) nodeName
	{
		NSMutableString* s = [[NSMutableString alloc] init];
		[s appendFormat: @"<%@", nodeName];
		[s appendString: [self serializeAttributes]];
		[s appendString: @">"];
		[s appendString: [self serializeElements]];
		[s appendFormat: @"</%@>", nodeName];
		return [s autorelease];
	}
	
	- (NSMutableString*) serializeElements
	{
		NSMutableString* s = [super serializeElements];
		if (self._id != nil) [s appendFormat: @"<id>%@</id>", [[self._id stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.values != nil) [s appendString: [self.values serialize: @"values"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[JIPRemoteFieldValue class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self._id != nil) { [self._id release]; }
		if(self.values != nil) { [self.values release]; }
		[super dealloc];
	}

@end
