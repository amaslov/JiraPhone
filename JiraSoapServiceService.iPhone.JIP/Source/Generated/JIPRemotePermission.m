/*
	JIPRemotePermission.h
	The implementation of properties and methods for the JIPRemotePermission object.
	Generated by SudzC.com
*/
#import "JIPRemotePermission.h"

@implementation JIPRemotePermission
	@synthesize name = _name;
	@synthesize permission = _permission;

	- (id) init
	{
		if(self = [super init])
		{
			self.name = nil;

		}
		return self;
	}

	+ (JIPRemotePermission*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (JIPRemotePermission*)[[[JIPRemotePermission alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.name = [Soap getNodeValue: node withName: @"name"];
			self.permission = [[Soap getNodeValue: node withName: @"permission"] longLongValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemotePermission"];
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
		if (self.name != nil) [s appendFormat: @"<name>%@</name>", [[self.name stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<permission>%@</permission>", [NSString stringWithFormat: @"%ld", self.permission]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[JIPRemotePermission class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.name != nil) { [self.name release]; }
		[super dealloc];
	}

@end
