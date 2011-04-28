/*
	AbstractRemoteEntity.h
	The implementation of properties and methods for the AbstractRemoteEntity object.
	Generated by SudzC.com
*/
#import "AbstractRemoteEntity.h"

@implementation AbstractRemoteEntity
	@synthesize _id = __id;

	- (id) init
	{
		if(self = [super init])
		{
			self._id = nil;

		}
		return self;
	}

	+ (AbstractRemoteEntity*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (AbstractRemoteEntity*)[[[AbstractRemoteEntity alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self._id = [Soap getNodeValue: node withName: @"id"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"AbstractRemoteEntity"];
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

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[AbstractRemoteEntity class]]) {
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
		[super dealloc];
	}

@end
