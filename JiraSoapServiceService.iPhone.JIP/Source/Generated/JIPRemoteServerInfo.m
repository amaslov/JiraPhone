/*
	JIPRemoteServerInfo.h
	The implementation of properties and methods for the JIPRemoteServerInfo object.
	Generated by SudzC.com
*/
#import "JIPRemoteServerInfo.h"

#import "JIPRemoteTimeInfo.h"
@implementation JIPRemoteServerInfo
	@synthesize baseUrl = _baseUrl;
	@synthesize buildDate = _buildDate;
	@synthesize buildNumber = _buildNumber;
	@synthesize edition = _edition;
	@synthesize serverTime = _serverTime;
	@synthesize version = _version;

	- (id) init
	{
		if(self = [super init])
		{
			self.baseUrl = nil;
			self.buildDate = nil;
			self.buildNumber = nil;
			self.edition = nil;
			self.serverTime = nil; // [[JIPRemoteTimeInfo alloc] init];
			self.version = nil;

		}
		return self;
	}

	+ (JIPRemoteServerInfo*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (JIPRemoteServerInfo*)[[[JIPRemoteServerInfo alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.baseUrl = [Soap getNodeValue: node withName: @"baseUrl"];
			self.buildDate = [Soap dateFromString: [Soap getNodeValue: node withName: @"buildDate"]];
			self.buildNumber = [Soap getNodeValue: node withName: @"buildNumber"];
			self.edition = [Soap getNodeValue: node withName: @"edition"];
			self.serverTime = [[JIPRemoteTimeInfo newWithNode: [Soap getNode: node withName: @"serverTime"]] object];
			self.version = [Soap getNodeValue: node withName: @"version"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemoteServerInfo"];
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
		if (self.baseUrl != nil) [s appendFormat: @"<baseUrl>%@</baseUrl>", [[self.baseUrl stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.buildDate != nil) [s appendFormat: @"<buildDate>%@</buildDate>", [Soap getDateString: self.buildDate]];
		if (self.buildNumber != nil) [s appendFormat: @"<buildNumber>%@</buildNumber>", [[self.buildNumber stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.edition != nil) [s appendFormat: @"<edition>%@</edition>", [[self.edition stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.serverTime != nil) [s appendString: [self.serverTime serialize: @"serverTime"]];
		if (self.version != nil) [s appendFormat: @"<version>%@</version>", [[self.version stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[JIPRemoteServerInfo class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.baseUrl != nil) { [self.baseUrl release]; }
		if(self.buildDate != nil) { [self.buildDate release]; }
		if(self.buildNumber != nil) { [self.buildNumber release]; }
		if(self.edition != nil) { [self.edition release]; }
		if(self.serverTime != nil) { [self.serverTime release]; }
		if(self.version != nil) { [self.version release]; }
		[super dealloc];
	}

@end
