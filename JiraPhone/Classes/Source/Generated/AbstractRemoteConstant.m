/*
	AbstractRemoteConstant.h
	The implementation of properties and methods for the AbstractRemoteConstant object.
	Generated by SudzC.com
*/
#import "AbstractRemoteConstant.h"

@implementation AbstractRemoteConstant
	@synthesize description = _description;
	@synthesize icon = _icon;

	- (id) init
	{
		if(self = [super init])
		{
			self.description = nil;
			self.icon = nil;

		}
		return self;
	}

	+ (AbstractRemoteConstant*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (AbstractRemoteConstant*)[[[AbstractRemoteConstant alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.description = [Soap getNodeValue: node withName: @"description"];
			self.icon = [Soap getNodeValue: node withName: @"icon"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"AbstractRemoteConstant"];
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
		if (self.icon != nil) [s appendFormat: @"<icon>%@</icon>", [[self.icon stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[AbstractRemoteConstant class]]) {
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
		if(self.icon != nil) { [self.icon release]; }
		[super dealloc];
	}

@end
