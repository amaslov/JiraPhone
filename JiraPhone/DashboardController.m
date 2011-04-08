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
#import "Priority.h"
#import "Filter.h"
#import "IssuesController.h"
#import "ProjectsController.h"
#import "ActivityController.h"
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
	
	// Set the view's title
	self.title = [NSString stringWithFormat:@"Dashboard"];
	
	// Create a logout button and push
	// it to the navigation controller
	UIButton *backButtonInternal = [[UIButton alloc] initWithFrame:CGRectMake(0,0,54,30)];
	[backButtonInternal setTitle:@"Logout" forState:UIControlStateNormal];
	[backButtonInternal.titleLabel setFont : [UIFont boldSystemFontOfSize:12]];
	[backButtonInternal setBackgroundImage:[UIImage imageNamed:@"red_square_button1.png"] forState:UIControlStateNormal];
	[backButtonInternal addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButtonInternal];   
	[backButtonInternal release];
	[[self navigationItem] setLeftBarButtonItem:backBarButton];
	[backBarButton release];
	
	// If there are no issues loaded, initialize the issue list
	if (!issues) {
		issues = [[NSMutableArray alloc] init];
	}

	// If there are no filters loaded, initialize the filter list
	if (!filters) {
		filters = [[NSMutableArray alloc] init];
	}
	
	// Sync with server
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	// Get a list of issues assigned to the user
	[connector getIssuesForDashboard:[User loggedInUser]];
	
	// If there are no cached issues, show wait spinner
	if (!issues.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	// Get a list of the user's filters
	[connector getFavouriteFilters];
	
	// If there are no cached filters, show wait spinner
	if (!filters.count) {
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Only first category has 6 items, the last two have 2 items in each
	switch (section) {
		case 0:
			return [issues count];
		case 1:
			return 3;
		case 2:
			return [filters count];
		case 3:
			return 1;
		default:
			return 3;
	}

}

- (UIImage *)getImageByPriority:(Priority *)priority {
	// Given the priority of an issue, return the appropriate priority image
	switch (priority.number) {
		case 1:
			return [UIImage imageNamed:@"priority_blocker.gif"];
		case 2:
			return [UIImage imageNamed:@"priority_critical.gif"];
		case 3:
			return [UIImage imageNamed:@"priority_major.gif"];
		case 4:
			return [UIImage imageNamed:@"priority_minor.gif"];
		case 5:
			return [UIImage imageNamed:@"priority_trivial.gif"];
		default:
			return nil;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// If we are in the issues section of the dashboard...
	if (indexPath.section == 0)
	{
		// Make sure there are issues before trying to populate cells
		if (issues.count >= indexPath.row + 1) {
			// Get the issue at the current row
			Issue *issue = [issues objectAtIndex:indexPath.row];
			
			// Set the cell details according to the issue
			cell.textLabel.text = issue.key;
			cell.detailTextLabel.text = issue.summary;
			cell.imageView.image = [self getImageByPriority:issue.priority];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			cell.textLabel.text = @"Issue";
		}
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
	// If we are in the filters section...
	else if (indexPath.section == 2)
	{
		// Make sure there are enough filters to populate the cell
		if (filters.count >= indexPath.row + 1)
		{
			// Get the filter at the current row
			Filter *filter = [filters objectAtIndex:indexPath.row];
			
			// Initialize the cell for the given filter
			cell.textLabel.text = [NSString stringWithFormat:@"%@",filter.name];
			cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",filter.description];
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		}
		else {
			cell.textLabel.text = [NSString stringWithFormat:@"Filter"];
			cell.detailTextLabel.text = nil;
			cell.accessoryType = UITableViewCellAccessoryNone;
		}

		// Don't display any extra details
		cell.imageView.image = nil;
	}
	else if (indexPath.section == 3)
	{
		// Create a cell for users to go to the activity stream
		cell.textLabel.text = [NSString stringWithFormat:@"View Activity Stream"];
		cell.detailTextLabel.text = nil;
		cell.imageView.image = nil;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
    return cell;
}

- (void)showActivityScreen {
	// Show the rss activity stream for the dashboard
	ActivityController *activityController = [ActivityController alloc];
	[self.navigationController pushViewController:activityController animated:YES];
	[activityController release];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// If the user selects an issue, push the issue details screen
	switch (indexPath.section) {
		case 0:
			if ([issues count] >= indexPath.row + 1) {
			IssueDetailsController *issueDetailsController = [[IssueDetailsController alloc] initForIssue:[issues objectAtIndex:indexPath.row]];
			[self.navigationController pushViewController:issueDetailsController animated:YES];
			[issueDetailsController release];
			}
			break;
		case 1:
			if (indexPath.row == 0) {
				// show projects
				ProjectsController *projController = [[ProjectsController alloc] initWithNibName:@"ProjectsController" bundle:nil];
				[self.navigationController pushViewController:projController animated:YES];
				[projController release];
			}
			break;
		case 2:
			// If the user selects a filter,
			// display issues returned by filter
			if ([filters count] >= indexPath.row + 1) {
				IssuesController *issuesController = [[IssuesController alloc] initForFilter:[filters objectAtIndex:indexPath.row]];
				[self.navigationController pushViewController:issuesController animated:YES];
				[issuesController release];
			}
			break;
		case 3:
			// Show the activity stream
			[self showActivityScreen];
			break;
		default:
			break;
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
		case 3:
			return [NSString stringWithFormat:@"Activity Stream:"];
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
	// Stop showing the wait spinner
	[activityIndicator stopAnimating];
	// Check if the data received is an array
	if ([result isKindOfClass:[NSArray class]]) {
		// Check if the array is full of filters
		if ([[result objectAtIndex:0] isKindOfClass:[Filter class]]) {
			[filters release];
			// Chop off the first issue, since it is just junk
			result = [result subarrayWithRange:NSMakeRange(1, [result count]-1)];
			filters = [result retain];
			[self.tableView reloadData];
		}
		// Otherwise, we received issues
		else {
			// Store the issues that were returned
			[issues release];
			issues = [result retain];
			[self.tableView reloadData];
		}
	}
}

- (void)didFailWithError:(NSError *)error {
	// Show an error if the connector fails to download data
	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)backButtonPressed {
	// If the user wishes to log out, log the user out,
	// then push the login screen.
	LoginController *lc = [self.navigationController.viewControllers objectAtIndex:0];
	[self.navigationController popViewControllerAnimated:YES];
	[lc logoutAction];
}
@end
