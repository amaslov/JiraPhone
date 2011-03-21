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
#import "ProjectActivityController.h"
#import "IssuesController.h"
#import "SearchController.h"
#import "LoginController.h"
#import "ProjectDashboardController.h"


@implementation ProjectsController

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Projects";
	
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
	if (!projects) {
		projects = [[NSMutableArray alloc] init];
	}

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

	[self.tableView reloadData];

	// sync with server for list of projects
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
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
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	Project *proj = [projects objectAtIndex:indexPath.row];
    cell.textLabel.text = proj.name;
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
	/* 
	IssuesController *issuesController = [[IssuesController alloc] initForProject:[projects objectAtIndex:indexPath.row]];
	[self.navigationController pushViewController:issuesController animated:YES];
	[issuesController release];
	*/
	
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
	[projects release];
    [super dealloc];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if ([result isKindOfClass:[NSArray class]]) {
		[Project cacheProjects:(NSArray *)result];
		[projects release];
		projects = [result retain];
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: [error localizedDescription] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark Actions
- (IBAction)backButtonPressed {
	LoginController *lc = [self.navigationController.viewControllers objectAtIndex:0];
	[self.navigationController popViewControllerAnimated:YES];
	[lc logoutAction];
}

- (void)showSearchController {
	SearchController *searchController = [[SearchController alloc] initForProject: nil];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchController];
	navController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
	[self presentModalViewController:navController animated:YES];
	[navController release];
	[searchController release];
}

@end

