/*
	JIPRemoteConfiguration.h
	The implementation of properties and methods for the JIPRemoteConfiguration object.
	Generated by SudzC.com
*/
#import "JIPRemoteConfiguration.h"

@implementation JIPRemoteConfiguration
	@synthesize allowAttachments = _allowAttachments;
	@synthesize allowExternalUserManagment = _allowExternalUserManagment;
	@synthesize allowIssueLinking = _allowIssueLinking;
	@synthesize allowSubTasks = _allowSubTasks;
	@synthesize allowTimeTracking = _allowTimeTracking;
	@synthesize allowUnassignedIssues = _allowUnassignedIssues;
	@synthesize allowVoting = _allowVoting;
	@synthesize allowWatching = _allowWatching;
	@synthesize timeTrackingDaysPerWeek = _timeTrackingDaysPerWeek;
	@synthesize timeTrackingHoursPerDay = _timeTrackingHoursPerDay;

	- (id) init
	{
		if(self = [super init])
		{

		}
		return self;
	}

	+ (JIPRemoteConfiguration*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (JIPRemoteConfiguration*)[[[JIPRemoteConfiguration alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.allowAttachments = [[Soap getNodeValue: node withName: @"allowAttachments"] boolValue];
			self.allowExternalUserManagment = [[Soap getNodeValue: node withName: @"allowExternalUserManagment"] boolValue];
			self.allowIssueLinking = [[Soap getNodeValue: node withName: @"allowIssueLinking"] boolValue];
			self.allowSubTasks = [[Soap getNodeValue: node withName: @"allowSubTasks"] boolValue];
			self.allowTimeTracking = [[Soap getNodeValue: node withName: @"allowTimeTracking"] boolValue];
			self.allowUnassignedIssues = [[Soap getNodeValue: node withName: @"allowUnassignedIssues"] boolValue];
			self.allowVoting = [[Soap getNodeValue: node withName: @"allowVoting"] boolValue];
			self.allowWatching = [[Soap getNodeValue: node withName: @"allowWatching"] boolValue];
			self.timeTrackingDaysPerWeek = [[Soap getNodeValue: node withName: @"timeTrackingDaysPerWeek"] intValue];
			self.timeTrackingHoursPerDay = [[Soap getNodeValue: node withName: @"timeTrackingHoursPerDay"] intValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemoteConfiguration"];
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
		[s appendFormat: @"<allowAttachments>%@</allowAttachments>", (self.allowAttachments)?@"true":@"false"];
		[s appendFormat: @"<allowExternalUserManagment>%@</allowExternalUserManagment>", (self.allowExternalUserManagment)?@"true":@"false"];
		[s appendFormat: @"<allowIssueLinking>%@</allowIssueLinking>", (self.allowIssueLinking)?@"true":@"false"];
		[s appendFormat: @"<allowSubTasks>%@</allowSubTasks>", (self.allowSubTasks)?@"true":@"false"];
		[s appendFormat: @"<allowTimeTracking>%@</allowTimeTracking>", (self.allowTimeTracking)?@"true":@"false"];
		[s appendFormat: @"<allowUnassignedIssues>%@</allowUnassignedIssues>", (self.allowUnassignedIssues)?@"true":@"false"];
		[s appendFormat: @"<allowVoting>%@</allowVoting>", (self.allowVoting)?@"true":@"false"];
		[s appendFormat: @"<allowWatching>%@</allowWatching>", (self.allowWatching)?@"true":@"false"];
		[s appendFormat: @"<timeTrackingDaysPerWeek>%@</timeTrackingDaysPerWeek>", [NSString stringWithFormat: @"%i", self.timeTrackingDaysPerWeek]];
		[s appendFormat: @"<timeTrackingHoursPerDay>%@</timeTrackingHoursPerDay>", [NSString stringWithFormat: @"%i", self.timeTrackingHoursPerDay]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[JIPRemoteConfiguration class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		[super dealloc];
	}

@end
