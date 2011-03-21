//
//  ProjectDashboardController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 3/19/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "ProjectDashboardController.h"
#import "Connector.h"
#import "Project.h"
#import "Issue.h"
#import "IssueDetailsController.h"
#import "ProjectActivityController.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"
#import "JiraPhoneAppDelegate.h"

@implementation ProjectDashboardController
@synthesize project;

- (id)initForProject:(Project *)_project {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.project = _project;
	}
	return self;
}

- (void)showProjectActivityScreen {
	ProjectActivityController *projectActivityController = [[ProjectActivityController alloc] initForProject:project];
	[self.navigationController pushViewController:projectActivityController animated:YES];
	[projectActivityController release];
}

- (void)getUnresolvedIssuesByUser:(NSMutableArray *)_unresolvedIssues ofProject:(Project *)_proj {
	
	NSString *queryString = [NSString stringWithFormat:@"select u.name AS userName, count(*) AS numIssues from issues i, users u where i.project = \"%@\" and u.name = i.assignee GROUP BY u.name", _proj.key];
	
	FMDatabase *db = [JiraPhoneAppDelegate sharedDB];
	FMResultSet *rs = [db executeQuery:queryString];
	while ([rs next])
	{
		NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
		NSString *userName = [rs stringForColumn:@"userName"];
		NSInteger numIssues = [[rs stringForColumn:@"numIssues"] intValue];
		NSLog(@"%@ : %d", userName, numIssues);
		[item setObject:userName forKey:@"userName"];
		[item setObject:[NSNumber numberWithInt:numIssues] forKey:@"numIssues"];
		[unresolvedIssues addObject:item];
		[item release];
	}
	[rs close];
	
	queryString = [NSString stringWithFormat:@"select key, assignee from issues where project = \"%@\"", project.key];
	rs = [db executeQuery:queryString];
	while ([rs next]) {
		NSLog(@"Issue: %@ Assignee: %@", [rs stringForColumn:@"key"], [rs stringForColumn:@"assignee"] );
	}
	[rs close];
	if ([db hadError]) {
		NSLog(@"db error: %@", [db lastErrorMessage]);
	}
	[self.tableView reloadData];
	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = project.name;

	// Initialize list of due issues
	if (!dueIssues) {
		dueIssues = [[NSMutableArray alloc] init];
	}
	
	// Initialize list of recent issues
	if (!recentIssues) {
		recentIssues = [[NSMutableArray alloc] init];
	}
	
	// Initialize the count of unresolved issues
	if (!unresolvedIssues) {
		unresolvedIssues = [[NSMutableArray alloc] init];
	}
	
	// sync with server for list of projects
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	[connector getDueIssuesForProject:project];
	
	// if there are no cashed projects show wait spinner
	if (!dueIssues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	[connector getRecentIssuesForProject:project];
	if (!recentIssues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	[self getUnresolvedIssuesByUser:unresolvedIssues ofProject:project];
	// Add a + button to view activity stream
	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showProjectActivityScreen)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// only first category has 6 items, the last two have 2 items in each
	if (section == 0) {
		return [dueIssues count];
	}
	else if (section == 1) {
		return [recentIssues count];
	}
	else {
		return [unresolvedIssues count];
	}

	
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
    }
	
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM/dd/yyyy"];
	
	if (indexPath.section == 0) {
		if (dueIssues.count >= indexPath.row+1) {
			Issue *issue = [dueIssues objectAtIndex:indexPath.row];
			NSString *dueDate = [dateFormat stringFromDate:issue.duedate];
			cell.textLabel.text = [NSString stringWithFormat:@"%@ Due: %@", issue.key, dueDate];
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Loading..."];
		}

	}
	else if (indexPath.section == 1) {
		if (recentIssues.count >= indexPath.row+1) {
			Issue *issue = [recentIssues objectAtIndex:indexPath.row];
			NSString *updatedDate = [dateFormat stringFromDate:issue.updated];
			cell.textLabel.text = [NSString stringWithFormat:@"%@ Updated: %@", issue.key, updatedDate];
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Loading..."];
		}

	}
	else {
		NSString *name = [[unresolvedIssues objectAtIndex:indexPath.row] objectForKey:@"userName"];
		NSInteger numIssues = [[[unresolvedIssues objectAtIndex:indexPath.row] valueForKey:@"numIssues"] integerValue];
		cell.textLabel.text = [NSString stringWithFormat:@"%@: %d",name, numIssues];
	}

	[dateFormat release];

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	IssueDetailsController *issueDetailsController = [IssueDetailsController alloc];
	switch (indexPath.section) {
		case 0:
			[issueDetailsController initForIssue:[dueIssues objectAtIndex:indexPath.row]];
			break;
		case 1:
			[issueDetailsController initForIssue:[recentIssues objectAtIndex:indexPath.row]];
			break;
		default:
			break;
	}
	[self.navigationController pushViewController:issueDetailsController animated:YES];
	[issueDetailsController release];

}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [NSString stringWithFormat:@"Issues: Due"];
		case 1:
			return [NSString stringWithFormat:@"Issues: Updated recently"];
		case 2:
			return [NSString stringWithFormat:@"Unresolved: By Assignee"];
		default:
			return [NSString stringWithFormat:@"Category %d", section+1];
	}
}
#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
	[super viewDidLoad];
}


- (void)dealloc {
	if(dueIssues){[dueIssues release]; dueIssues = nil;}
	if(recentIssues){[recentIssues release]; recentIssues = nil;}
    [super dealloc];
}

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if (!dueIssues.count) {
		if ([result isKindOfClass:[NSArray class]]) {
			[dueIssues release];
			dueIssues = [result retain];
			[self.tableView reloadData];
		}
	}
	else {
		if ([result isKindOfClass:[NSArray class]]) {
			[recentIssues release];
			recentIssues = [result retain];
			[self.tableView reloadData];
		}
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
