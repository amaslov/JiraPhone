/*
	JIPRemoteProjectRole.h
	The implementation of properties and methods for the JIPRemoteProjectRole object.
	Generated by SudzC.com
*/
#import "JIPRemoteProjectRole.h"

@implementation JIPRemoteProjectRole
	@synthesize description = _description;
	@synthesize _id = __id;
	@synthesize name = _name;

	- (id) init
	{
		if(self = [super init])
		{
			self.description = nil;
			self.name = nil;

		}
		return self;
	}

	+ (JIPRemoteProjectRole*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (JIPRemoteProjectRole*)[[[JIPRemoteProjectRole alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.description = [Soap getNodeValue: node withName: @"description"];
			self._id = [[Soap getNodeValue: node withName: @"id"] longLongValue];
			self.name = [Soap getNodeValue: node withName: @"name"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemoteProjectRole"];
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
		if (self.description != nil) [s appendFormat: @"<description>%@</description>", [[self.description stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<id>%@</id>", [NSString stringWithFormat: @"%ld", self._id]];
		if (self.name != nil) [s appendFormat: @"<name>%@</name>", [[self.name stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[JIPRemoteProjectRole class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.description != nil) { [self.description release]; }
		if(self.name != nil) { [self.name release]; }
		[super dealloc];
	}

@end
