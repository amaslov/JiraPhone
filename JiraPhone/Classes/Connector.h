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

// search _project for _word
- (void)getIssuesOfProject:(Project *)_project fromTextSearch:(NSString *)_word;

// request details of _issues
- (void)getDetailsOfIssue:(Issue *)_issue;

// create new issue
- (void)createIssue:(Issue *)_issue;

// returns singletone Connector object
+ (Connector *)sharedConnector;

@end
