/*
	JIPRemoteIssue.h
	The implementation of properties and methods for the JIPRemoteIssue object.
	Generated by SudzC.com
*/
#import "JIPRemoteIssue.h"

#import "JIPArrayOf_tns1_RemoteVersion.h"
#import "JIPArrayOf_xsd_string.h"
#import "JIPArrayOf_tns1_RemoteComponent.h"
#import "JIPArrayOf_tns1_RemoteCustomFieldValue.h"
#import "JIPArrayOf_tns1_RemoteVersion.h"
@implementation JIPRemoteIssue
	@synthesize affectsVersions = _affectsVersions;
	@synthesize assignee = _assignee;
	@synthesize attachmentNames = _attachmentNames;
	@synthesize components = _components;
	@synthesize created = _created;
	@synthesize customFieldValues = _customFieldValues;
	@synthesize description = _description;
	@synthesize duedate = _duedate;
	@synthesize environment = _environment;
	@synthesize fixVersions = _fixVersions;
	@synthesize key = _key;
	@synthesize priority = _priority;
	@synthesize project = _project;
	@synthesize reporter = _reporter;
	@synthesize resolution = _resolution;
	@synthesize status = _status;
	@synthesize summary = _summary;
	@synthesize type = _type;
	@synthesize updated = _updated;
	@synthesize votes = _votes;

	- (id) init
	{
		if(self = [super init])
		{
			self.affectsVersions = nil; // [[JIPArrayOf_tns1_RemoteVersion alloc] init];
			self.assignee = nil;
			self.attachmentNames = nil; // [[JIPArrayOf_xsd_string alloc] init];
			self.components = nil; // [[JIPArrayOf_tns1_RemoteComponent alloc] init];
			self.created = nil;
			self.customFieldValues = nil; // [[JIPArrayOf_tns1_RemoteCustomFieldValue alloc] init];
			self.description = nil;
			self.duedate = nil;
			self.environment = nil;
			self.fixVersions = nil; // [[JIPArrayOf_tns1_RemoteVersion alloc] init];
			self.key = nil;
			self.priority = nil;
			self.project = nil;
			self.reporter = nil;
			self.resolution = nil;
			self.status = nil;
			self.summary = nil;
			self.type = nil;
			self.updated = nil;

		}
		return self;
	}

	+ (JIPRemoteIssue*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (JIPRemoteIssue*)[[[JIPRemoteIssue alloc] initWithNode: node] autorelease];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.affectsVersions = [[JIPArrayOf_tns1_RemoteVersion newWithNode: [Soap getNode: node withName: @"affectsVersions"]] object];
			self.assignee = [Soap getNodeValue: node withName: @"assignee"];
			self.attachmentNames = [[JIPArrayOf_xsd_string newWithNode: [Soap getNode: node withName: @"attachmentNames"]] object];
			self.components = [[JIPArrayOf_tns1_RemoteComponent newWithNode: [Soap getNode: node withName: @"components"]] object];
			self.created = [Soap dateFromString: [Soap getNodeValue: node withName: @"created"]];
			self.customFieldValues = [[JIPArrayOf_tns1_RemoteCustomFieldValue newWithNode: [Soap getNode: node withName: @"customFieldValues"]] object];
			self.description = [Soap getNodeValue: node withName: @"description"];
			self.duedate = [Soap dateFromString: [Soap getNodeValue: node withName: @"duedate"]];
			self.environment = [Soap getNodeValue: node withName: @"environment"];
			self.fixVersions = [[JIPArrayOf_tns1_RemoteVersion newWithNode: [Soap getNode: node withName: @"fixVersions"]] object];
			self.key = [Soap getNodeValue: node withName: @"key"];
			self.priority = [Soap getNodeValue: node withName: @"priority"];
			self.project = [Soap getNodeValue: node withName: @"project"];
			self.reporter = [Soap getNodeValue: node withName: @"reporter"];
			self.resolution = [Soap getNodeValue: node withName: @"resolution"];
			self.status = [Soap getNodeValue: node withName: @"status"];
			self.summary = [Soap getNodeValue: node withName: @"summary"];
			self.type = [Soap getNodeValue: node withName: @"type"];
			self.updated = [Soap dateFromString: [Soap getNodeValue: node withName: @"updated"]];
			self.votes = [[Soap getNodeValue: node withName: @"votes"] longLongValue];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"RemoteIssue"];
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
		if (self.affectsVersions != nil) [s appendString: [self.affectsVersions serialize: @"affectsVersions"]];
		if (self.assignee != nil) [s appendFormat: @"<assignee>%@</assignee>", [[self.assignee stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.attachmentNames != nil) [s appendString: [self.attachmentNames serialize: @"attachmentNames"]];
		if (self.components != nil) [s appendString: [self.components serialize: @"components"]];
		if (self.created != nil) [s appendFormat: @"<created>%@</created>", [Soap getDateString: self.created]];
		if (self.customFieldValues != nil) [s appendString: [self.customFieldValues serialize: @"customFieldValues"]];
		if (self.description != nil) [s appendFormat: @"<description>%@</description>", [[self.description stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.duedate != nil) [s appendFormat: @"<duedate>%@</duedate>", [Soap getDateString: self.duedate]];
		if (self.environment != nil) [s appendFormat: @"<environment>%@</environment>", [[self.environment stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.fixVersions != nil) [s appendString: [self.fixVersions serialize: @"fixVersions"]];
		if (self.key != nil) [s appendFormat: @"<key>%@</key>", [[self.key stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.priority != nil) [s appendFormat: @"<priority>%@</priority>", [[self.priority stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.project != nil) [s appendFormat: @"<project>%@</project>", [[self.project stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.reporter != nil) [s appendFormat: @"<reporter>%@</reporter>", [[self.reporter stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.resolution != nil) [s appendFormat: @"<resolution>%@</resolution>", [[self.resolution stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.status != nil) [s appendFormat: @"<status>%@</status>", [[self.status stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.summary != nil) [s appendFormat: @"<summary>%@</summary>", [[self.summary stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.type != nil) [s appendFormat: @"<type>%@</type>", [[self.type stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.updated != nil) [s appendFormat: @"<updated>%@</updated>", [Soap getDateString: self.updated]];
		[s appendFormat: @"<votes>%@</votes>", [NSString stringWithFormat: @"%ld", self.votes]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[JIPRemoteIssue class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}
	
	- (void) dealloc
	{
		if(self.affectsVersions != nil) { [self.affectsVersions release]; }
		if(self.assignee != nil) { [self.assignee release]; }
		if(self.attachmentNames != nil) { [self.attachmentNames release]; }
		if(self.components != nil) { [self.components release]; }
		if(self.created != nil) { [self.created release]; }
		if(self.customFieldValues != nil) { [self.customFieldValues release]; }
		if(self.description != nil) { [self.description release]; }
		if(self.duedate != nil) { [self.duedate release]; }
		if(self.environment != nil) { [self.environment release]; }
		if(self.fixVersions != nil) { [self.fixVersions release]; }
		if(self.key != nil) { [self.key release]; }
		if(self.priority != nil) { [self.priority release]; }
		if(self.project != nil) { [self.project release]; }
		if(self.reporter != nil) { [self.reporter release]; }
		if(self.resolution != nil) { [self.resolution release]; }
		if(self.status != nil) { [self.status release]; }
		if(self.summary != nil) { [self.summary release]; }
		if(self.type != nil) { [self.type release]; }
		if(self.updated != nil) { [self.updated release]; }
		[super dealloc];
	}

@end
