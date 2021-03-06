//
//  ProjectsController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/15/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "ProjectsController.h"
#import "Project.h"
#import "Connector.h"
#import "ActivityController.h"
#import "IssuesController.h"
#import "SearchController.h"
#import "LoginController.h"
#import "ProjectDashboardController.h"


@implementation ProjectsController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Set the title
	self.title = @"Projects";
	
	// get list of cashed projects
	if (!projects) {
		projects = [[NSMutableArray alloc] init];
	}

	// Get cached projects from the local database
	[Project getCachedProjects:projects];
	
	// if there are no cashed projects show wait spinner
	if (!projects.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}

	// Reload data in the table
	[self.tableView reloadData];

	// sync with server for list of projects
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	// Get projects from the server
	[connector getProjects];
	
	// add search navigation button
	UIBarButtonItem *searchButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(showSearchController)];
	self.navigationItem.rightBarButtonItem = searchButton;
	[searchButton release];	
}


/*
//do something with all these methods?
 - (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return projects.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	// Make a cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	Project *proj = [projects objectAtIndex:indexPath.row];
    cell.textLabel.text = proj.name;
	cell.detailTextLabel.text=proj.key;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Uncomment this section to get old issue list back
	
	/* IssuesController *issuesController = [[IssuesController alloc] initForProject:[projects objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:issuesController animated:YES];
	[issuesController release]; */
	
	
	ProjectDashboardController *projectDashboardController = [[ProjectDashboardController alloc] initForProject:[projects objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:projectDashboardController animated:YES];
	[projectDashboardController release];
	 
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
}


- (void)dealloc {
	// Free up memory
	if (projects){[projects release]; projects = nil;}
    [super dealloc];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	// Stop the activity indicator
	[activityIndicator stopAnimating];
	// Store the list of projects
	if ([result isKindOfClass:[NSArray class]]) {
		[Project cacheProjects:(NSArray *)result];
		[projects release];
		projects = [result retain];
		// Reload the data in the table
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	// Stop the activity indicator
	[activityIndicator stopAnimating];
	
	// Display an error to the user
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void)showSearchController {
	// Present the Search screen to the user
	SearchController *searchController = [[SearchController alloc] initForProject: nil];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchController];
	navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[self presentModalViewController:navController animated:YES];
	[navController release];
	[searchController release];
}

@end

