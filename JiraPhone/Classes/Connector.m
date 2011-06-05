//
//  Connector.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/20/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
// http://docs.atlassian.com/software/jira/docs/api/rpc-jira-plugin/latest/com/atlassian/jira/rpc/soap/JiraSoapService.html
// jql - jira query language

//TODO create static initializer

#import "Connector.h"
#import "JiraSoapServiceService.h"
#import "RemoteIssue.h"
#import "ArrayOf_tns1_RemoteProject.h"
#import "RemoteProject.h"
#import "Project.h"
#import "Issue.h"
#import "IssueType.h"
#import "User.h"
#import "Group.h"
#import "Filter.h"
#import "Comment.h"
#import "RemoteComment.h"

@implementation Connector
@synthesize delegate;

//vl singleton.h
- (id)init {
	if (self = [super init]) {
		jira = [[JiraSoapServiceService alloc] init];
		jira.defaultHandler = self;
//		jira.logging = YES;
	}
	return self;
}

- (void)dealloc {
	delegate = nil;
	jira.defaultHandler = nil;
	[jira release];
	[token release];
	[super dealloc];
}

#pragma mark -
#pragma mark Logic

- (void)loginToServer:(NSString *)_server withName:(NSString *)_name andPassword:(NSString *)_password {
	jira.serviceUrl = [NSString stringWithFormat:@"%@/rpc/soap/jirasoapservice-v2", _server];
	[jira login:self action:@selector(loginHandler:) in0:_name in1:_password];
}

- (void)logout {
	[jira logout:self action:@selector(logoutHandler:) in0: token];
}

- (void)addComment:(NSString *)_issueKey comment:(Comment *)_comment {
	RemoteComment *rComment = [[RemoteComment alloc] init];
	[rComment setBody:_comment.body];
	[jira addComment:self in0:token in1:_issueKey in2:rComment];
	[rComment release];
}

- (void)getProjects {
	[jira getProjectsNoSchemes:self in0: token];
}

- (void)getIssuesOfProject:(Project *)_project {
	[jira getIssuesFromJqlSearch:self in0:token in1:[NSString stringWithFormat:@"project = \"%@\"", _project.name] in2:10];
}

- (void)getIssuesForDashboard:(User *)_user {
	[jira getIssuesFromJqlSearch:self in0:token in1:[NSString stringWithFormat:@"assignee = currentUser() AND resolution = unresolved ORDER BY priority DESC, created ASC"] in2:10];//@"assignee = \"%@\" and status = open order by priority DESC", [User loggedInUser].name] in2:10];
}

- (void)getDueIssuesForProject:(Project *)_project {
	[jira getIssuesFromJqlSearch:self in0:token in1:[NSString stringWithFormat:@"project = \"%@\" and resolution = Unresolved and due != null order by due ASC, priority DESC, created ASC",_project.key] in2:4];
}

-(void)getRecentIssuesForProject:(Project *)_project {
	[jira getIssuesFromJqlSearch:self in0:token in1:[NSString stringWithFormat:@"project = \"%@\" order by updated DESC, priority DESC, created ASC",_project.key]  in2:4];
}
- (void)getIssuesOfProject:(Project *)_project fromTextSearch:(NSString *)_word {	
	[jira getIssuesFromTextSearchWithProject:self in0:token in1: nil in2:_word in3:10];
}

- (void)getIssuesFromFilter:(NSString *)_id {
	[jira getIssuesFromFilterWithLimit:self in0:token in1:_id in2:0 in3:10];
}

- (void)getFavouriteFilters {
	[jira getFavouriteFilters:self in0:token];
}

- (void)getIssuesFromJql:(NSString *)_jql {
	[jira getIssuesFromJqlSearch:self in0:token in1:_jql in2:10];
}

- (void)getUser:(NSString *)_username {
	[jira getUser:self in0:token in1:_username];
}
 //this should work with RemoteIssue!
 /*
- (void)getCustomFieldValues:(Issue *)_issue {
	RemoteIssue *rIssue= //[[RemoteIssue alloc] init];
	
	j_issue=[jira getIssueById:self in0:token in1:_issue.key];;
	j_issue.defaultHandler=self;
	[j_issue getCustomFieldValues:self
	//[issue getCustomFieldValues: self 
} 
*/
- (void)getDetailsOfIssue:(Issue *)_issue {
	[jira getIssue:self in0:token in1:_issue.key];
}

- (void)getCommentsOfIssue:(Issue *)_issue {
	[jira getComments:self in0:token in1:_issue.key];
}

- (void)createIssue:(Issue *)_issue {
	RemoteIssue *rIssue = [[RemoteIssue alloc] init];
	rIssue.project = _issue.project;
	rIssue.type = [NSString stringWithFormat:@"%i", _issue.type.number];
	rIssue.summary = _issue.summary;
	rIssue.priority = [NSString stringWithFormat:@"%i", _issue.priority.number];
	rIssue.assignee = _issue.assignee;
	rIssue.reporter = _issue.reporter;
	[jira createIssue:self in0:token in1:rIssue];
	[rIssue release];
}
//TODO consider dynamic class initialization (didreceivedata)
//keys - dictionary, blocks - embedded functions
#pragma mark -
#pragma mark Soap Service delegate
#pragma mark default handlers
- (void) onload: (id) value {
	//[here goes value populate]
	//Array of Projects
	if ([value isKindOfClass:[ArrayOf_tns1_RemoteProject class]]) {

		//	ArrayOf_tns1_RemoteProject => array
		ArrayOf_tns1_RemoteProject *remProjs = (ArrayOf_tns1_RemoteProject *)value;
		Project *proj;
		NSMutableArray *projs = [NSMutableArray array];
		for (RemoteProject *remProj in remProjs) {
			proj = [[Project alloc] init];
			proj.name = remProj.name;
			proj.lead = remProj.lead;
			proj.key = remProj.key;
			proj.projectUrl = remProj.projectUrl;
			proj.url = remProj.url;
		//	proj.hashCode=[remProj hashCode];
			[projs addObject:proj];
			[proj release];
		}
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:projs];
		}
		return;
	}
	//Array of issues
	if ([value isKindOfClass:[ArrayOf_tns1_RemoteIssue class]]) {
		
		// ArrayOf_tns1_RemoteIssue => array
		ArrayOf_tns1_RemoteIssue *remIssues = (ArrayOf_tns1_RemoteIssue *)value;
		Issue *issue;
		NSMutableArray *issues = [NSMutableArray array];
		NSLog(@"Got array of remote issues from server.");
		for (RemoteIssue *remIssue in remIssues) {
			issue = [[Issue alloc] init];
			issue.key = remIssue.key;
			NSLog(@"%@", issue.key);
			issue.assignee = remIssue.assignee;
			issue.created = remIssue.created;
			issue.description = remIssue.description;
			issue.duedate = remIssue.duedate;
			//hash code doesn't work properly now. Following string just crashes the app.
//			issue.hashCode=[remIssue hashCode];
			Priority *p = [[Priority alloc] init];
			p.number = [remIssue.priority intValue];
			issue.priority = p;
			[p release];
			
			issue.reporter = remIssue.reporter;
			issue.project = remIssue.project;
			issue.resolution = remIssue.resolution;
			issue.status = remIssue.status;
			issue.summary = remIssue.summary;
			issue.environment=remIssue.environment;
			
			IssueType *t = [[IssueType alloc] init];
			t.number = [remIssue.type intValue];
			issue.type = t;
			[t release];
			
			issue.updated = remIssue.updated;
			[issues addObject:issue];
			[issue release];
		}
		NSLog(@"Done with array of remote issues.");
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:issues];
		}
		return;
	}
	//Issue
	if ([value isKindOfClass:[RemoteIssue class]]) {
		RemoteIssue *remIssue = (RemoteIssue *)value;
		
		// RemoteIssue => Issue
		Issue *issue = [[Issue alloc] init];
		issue.key = remIssue.key;
		issue.assignee = remIssue.assignee;
		issue.created = remIssue.created;
		issue.description = remIssue.description;
		issue.duedate = remIssue.duedate;
		issue.environment=remIssue.environment;
		Priority *p = [[Priority alloc] init];
		p.number = [remIssue.priority intValue];
		issue.priority = p;
		[p release];
		issue.reporter = remIssue.reporter;
		issue.project = remIssue.project;
		issue.resolution = remIssue.resolution;
		issue.status = remIssue.status;
		issue.summary = remIssue.summary;
		IssueType *t = [[IssueType alloc] init];
		t.number = [remIssue.type intValue];
		issue.type = t;
		[t release];
		issue.updated = remIssue.updated;
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:issue];
		}
		return;		
	}
	
	if ([value isKindOfClass:[RemoteUser class]]) {
		RemoteUser *remUser = (RemoteUser *)value;
		User *user = [[User alloc] init];
		user.name = remUser.name;
		user.email = remUser.email;
		user.fullName = remUser.fullname;
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:user];
		}
		return;
	}
	
	//group
	if ([value isKindOfClass:[RemoteGroup class]]) {

		RemoteGroup *remGroup = (RemoteGroup *)value;
		Group *group = [[Group alloc] init];
		ArrayOf_tns1_RemoteUser *remUsers = remGroup.users;
		for (RemoteUser *remUser in remUsers)
		{
			User *userTemp = [[User alloc]init];
			userTemp.name=remUser.name;
			userTemp.fullName=remUser.fullname;
			userTemp.email=remUser.email;
			userTemp.server=[User loggedInUser].server;
			[group.users addObject:userTemp];
			[userTemp release];
		}
		group.name=remGroup.name;
		group.server=[User loggedInUser].server;
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:group];
		}
		return;
	}
	if ([value isKindOfClass:[ArrayOf_tns1_RemoteFilter class]]){
		ArrayOf_tns1_RemoteFilter *remFilters = (ArrayOf_tns1_RemoteFilter *)value;
			NSMutableArray *filters = [NSMutableArray array];
		for (RemoteFilter *remFilter in remFilters) {
			Filter *filter = [[Filter alloc] init];
			filter.ID=remFilter._id;
			NSLog(@"Filter: %@", remFilter._id);
			filter.name=remFilter.name;
			filter.description=remFilter.description;
			filter.author=remFilter.author;
			filter.server=[[User loggedInUser] server];
			[filters addObject:filter];
			[filter release];
		}
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:filters];
		}
		return;
	}	
		//Array of comments
	//TODO: create comment fetching screen in Issue Details
	if ([value isKindOfClass:[ArrayOf_tns1_RemoteComment class]]) {
		ArrayOf_tns1_RemoteComment *remComments = (ArrayOf_tns1_RemoteComment *)value;
		NSMutableArray *comments = [NSMutableArray array];
		for (RemoteComment *remComment in remComments) {
			Comment *comment = [Comment alloc];
			comment.Id=remComment._id;
			comment.author=remComment.author;
			comment.body=remComment.body;
			comment.updated=remComment.updated;
			comment.created=remComment.created;
			[comments addObject:comment];
			[comment release];
		}
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:comments];
		}
		return;				
	}
	//Comment
	//apparently doesn't work - some problem with comment class (or remote comment). 
	/*	if ([value isKindOfClass:[RemoteComment class]])
	{
		RemoteComment *remComment = (RemoteComment *)value;
		Comment *comment = [[Comment alloc] init];
		comment.Id=remComment._id;
		comment.author=remComment.author;
		comment.body=remComment.body;
		comment.updated=remComment.updated;
		comment.created=remComment.created;
		if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
			[delegate didReceiveData:comment];
		}
		return;	
	} */
	 
	//TODO implement versions parsing.
	if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
		[delegate didReceiveData:value];
	}

}

- (void) onerror: (NSError*) error {
	if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
		[delegate didFailWithError:error];
	}
}
- (void) onfault: (SoapFault*) fault {
	if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
		[delegate didFailWithError: fault];
	}
}

#pragma mark special handlers
- (void) loginHandler: (id) value {
	
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"error at login: %@", value);
		if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
			[delegate didFailWithError:value];
		}
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"soap fault at login: %@", value);
		if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
			[delegate didFailWithError:value];
		}		
		return;
	}

	// Auth token received 
	NSString* _token = (NSString*)value;
	if (token) {
		[token release];
		token = nil;
	}
	token = [_token retain];
	
	// Report to delegate about successful login
	if ([delegate respondsToSelector: @selector(didReceiveData:)]) {
		[delegate didReceiveData: token];
	}
}

- (void)logoutHandler:(id)value {
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"error at login: %@", value);
		if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
			[delegate didFailWithError:value];
		}
		return;
	}
	
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"soap fault at login: %@", value);
		if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
			[delegate didFailWithError:value];
		}		
		return;
	}
	
	// logout result
	if ([delegate respondsToSelector:@selector(didReceiveData:)]) {
		[delegate didReceiveData: value];
	}
}
#pragma mark -
#pragma mark Class methods

static Connector *SHARED_CONNECTOR = nil;

+ (id)sharedConnector {
	if (!SHARED_CONNECTOR) {
		SHARED_CONNECTOR = [[Connector alloc] init];
	}
	return SHARED_CONNECTOR;
}
@end
