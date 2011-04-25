/*
	RemoteFilter.h
	The implementation of properties and methods for the RemoteFilter object.
	Generated by SudzC.com
*/
#import "RemoteFilter.h"

@implementation RemoteFilter
	@synthesize author = _author;
	@synthesize description = _description;
	@synthesize project = _project;
	@synthesize xml = _xml;

	- (id) init
	{
		if(self = [super init])
		{
			self.author = nil;
			self.description = nil;
			self.project = nil;
			self.xml = nil;

		}
		return self;
	}

	+ (RemoteFilter*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (RemoteFilter*)[[[RemoteFilter alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.author = [Soap getNodeValue: node withName: @"author"];
			self.description = [Soap getNodeValue: node withName: @"description"];
			self.project = [Soap getNodeValue: node withName: @"project"];
			self.xml = [Soap getNodeValue: node withName: @"xml"];
			// Get the node that holds the real filter ID
			CXMLNode *_idNode = [node childAtIndex:2];
			// Set the ID of the filter
			self._id = [_idNode stringValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemoteFilter"];
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
		if (self.author != nil) [s appendFormat: @"<author>%@</author>", [[self.author stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.description != nil) [s appendFormat: @"<description>%@</description>", [[self.description stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.project != nil) [s appendFormat: @"<project>%@</project>", [[self.project stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.xml != nil) [s appendFormat: @"<xml>%@</xml>", [[self.xml stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[RemoteFilter class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.author != nil) { [self.author release]; }
		if(self.description != nil) { [self.description release]; }
		if(self.project != nil) { [self.project release]; }
		if(self.xml != nil) { [self.xml release]; }
		[super dealloc];
	}

@end
