//
//  DashboardController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 2/26/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "DashboardController.h"
#import "Project.h"
#import "Issue.h"
#import "IssuesController.h"
#import "ProjectsController.h"
#import "IssueDetailsController.h"
#import "CreateIssueController.h"
#import "LoginController.h"
#import "Connector.h"
#import "User.h"

@implementation DashboardController
@synthesize currentUser;

- (id)initForUser:(User *)_user {
	if (self = [super initWithNibName:@"DashboardController" bundle:nil]) {
		currentUser = [_user retain];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = [NSString stringWithFormat:@"Welcome"];
	
	// set custom back button
	UIButton *backButtonInternal = [[UIButton alloc] initWithFrame:CGRectMake(0,0,54,30)];
	[backButtonInternal setTitle:@"Logout" forState:UIControlStateNormal];
	[backButtonInternal.titleLabel setFont : [UIFont boldSystemFontOfSize:12]];
	[backButtonInternal setBackgroundImage:[UIImage imageNamed:@"red_square_button1.png"] forState:UIControlStateNormal];
	[backButtonInternal addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonInternal];   
	[backButtonInternal release];
	[[self navigationItem] setLeftBarButtonItem:backBarButton];
	[backBarButton release];
	
	// get list of cashed projects
	if (!issues) {
		issues = [[NSMutableArray alloc] init];
	}
	
	//[Issue getCachedIssuesForUser:issues];
	//[self.tableView reloadData];
	
	// sync with server for list of projects
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	[connector getIssuesForDashboard:[User loggedInUser]];
	
	// if there are no cashed projects show wait spinner
	if (!issues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// only first category has 6 items, the last two have 2 items in each
	if (section == 0) {
		return [issues count];
	}
	else {
		return 3;
	}

}

- (NSString *)titleForCellAtIndexPath:(NSIndexPath *)indexPath {
	NSString *ret = nil;
    if (indexPath.section == 0) {
		ret = @"Issue:";
	}
	else if (indexPath.section == 1) {
		switch (indexPath.row) {
			case 0:
				ret = @"Project: ";
				break;
			case 1:
				ret = @"Issue List";
				break;
			case 2:
				ret = @"Create Issue";
			default:
				break;
		}
	}
	else if (indexPath.section == 2)
	{
		ret = @"Filters";
	}
	return ret;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
    }
    
    // Configure the cell...
	NSMutableString *str = [NSMutableString string];
	[str appendString: [self titleForCellAtIndexPath:indexPath]];
	
	if (issues.count >= indexPath.row+1)
	{
		Issue *issue = [issues objectAtIndex:indexPath.row];
		
		if (indexPath.section == 0) {
			cell.textLabel.text = issue.key;
			cell.detailTextLabel.text = issue.summary;
			switch (issue.priority.number) {
				case 1:
					cell.imageView.image = [UIImage imageNamed:@"priority_blocker.gif"];
					break;
				case 2:
					cell.imageView.image = [UIImage imageNamed:@"priority_critical.gif"];
					break;
				case 3:
					cell.imageView.image = [UIImage imageNamed:@"priority_major.gif"];
					break;
				case 4:
					cell.imageView.image = [UIImage imageNamed:@"priority_minor.gif"];
					break;
				case 5:
					cell.imageView.image = [UIImage imageNamed:@"priority_trivial.gif"];
					break;
			}
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
		}
		else if (indexPath.section == 1) {
			switch (indexPath.row) {
				case 0:
					cell.textLabel.text = [NSString stringWithFormat:@"Projects"];
					break;
				case 1:
					cell.textLabel.text = [NSString stringWithFormat:@"Issue List"];				
					break;
				case 2:
					cell.textLabel.text = [NSString stringWithFormat:@"Create issue"];
					break;
				default:
					break;
			}
		}
		else if (indexPath.section == 2)
		{
			cell.textLabel.text = [NSString stringWithFormat:@"Filter"];
		}
	}
	else {
		//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [NSString stringWithFormat:@"Not enough issues: %d issues.",issues.count] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alert show];
		//[alert release];
		[str appendFormat:@"HELLO"];
		//cell.textLabel.text = str;
	}
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0)
	{
		IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:[issues objectAtIndex:indexPath.row]];
		[self.navigationController pushViewController:issueDetailsController animated:YES];
		[issueDetailsController release];
	}
	else if (indexPath.section == 1)
	{
		if (indexPath.row == 0)
		{
			// show projects
			ProjectsController *projController = [[ProjectsController alloc] initWithNibName:@"ProjectsController" bundle:nil];
			[self.navigationController pushViewController:projController animated:YES];
			[projController release];
		}
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	switch (section) {
		case 0:
			return [NSString stringWithFormat:@"Assigned To Me:"];
		case 1:
			return [NSString stringWithFormat:@"Project:"];
		case 2:
			return [NSString stringWithFormat:@"Filters:"];
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
	if(issues){[issues release]; issues = nil;}
    [super dealloc];
}

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if ([result isKindOfClass:[NSArray class]]) {
		[issues release];
		issues = [result retain];
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)backButtonPressed {
	LoginController *lc = [self.navigationController.viewControllers objectAtIndex:0];
	[self.navigationController popViewControllerAnimated:YES];
	[lc logoutAction];
}
@end
