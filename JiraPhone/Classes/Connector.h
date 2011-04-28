//
//  Connector.h
//  JiraPhone
//
//  Created by Aleksey Maslov on 11/20/10.
//  Copyright 2010 AMaslov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectorDelegate.h"

#import "JiraSoapServiceService.h"

#define CONNECTOR_FAULT_MESSAGE	@"faultMessage"

@class Project;
@class Issue;
@class User;
@class Filter;
@interface Connector : NSObject <SoapDelegate> {

	// delegate, to which to tell results of connecting to jira server
	id<ConnectorDelegate> delegate;
	
	// jira auth token
	NSString *token;
	
	// jira soap service
	JiraSoapServiceService *jira;
}
@property (nonatomic, assign) id<ConnectorDelegate> delegate;

// try to login
- (void)loginToServer:(NSString *)_server withName:(NSString *)_name andPassword:(NSString *)_password;

// logout
- (void)logout;

// request projects from server
- (void)getProjects;

// request issues of _project
- (void)getIssuesOfProject:(Project *)_project;

// get issues to be displayed on dashboard
- (void)getIssuesForDashboard:(User *)_user;

// get unresolved, due issues for project
- (void)getDueIssuesForProject:(Project *)_project;

//
-(void)getRecentIssuesForProject:(Project *)_project;

// search _project for _word
- (void)getIssuesOfProject:(Project *)_project fromTextSearch:(NSString *)_word;

// request details of _issues
- (void)getDetailsOfIssue:(Issue *)_issue;

// create new issue
- (void)createIssue:(Issue *)_issue;

// get issues from filter
- (void)getIssuesFromFilter:(NSString *)_id;

// get favorite filters
- (void)getFavouriteFilters;

// get issues from jql
- (void)getIssuesFromJql:(NSString *)_jql;

// get the user from JIRA
- (void)getUser:(NSString *)_username;

// returns singleton Connector object
+ (Connector *)sharedConnector;

@end
