//
//  UserController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 4/8/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "UserController.h"
#import "Connector.h"
#import "IssuesController.h"

@implementation UserController
@synthesize user;
@synthesize username;

#pragma mark -
#pragma mark View lifecycle

- (id)initForUsername:(NSString *)_username {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		self.username = _username;
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"User Profile";
	
	if (!user) {
		user = [[User alloc] init];
	}
	
	// Sync with server
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	NSLog(@"Attempting to get user with username: %@", self.username);
	[connector getUser:self.username];
	
	if (!activityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
		[self.view addSubview:activityIndicator];
		[activityIndicator release];
	}
	[activityIndicator startAnimating];

}

/*
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
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    switch (section) {
		case 0:
			return 3;
			break;
		case 1:
			return 2;
			break;
		default:
			return 3;
			break;
	}
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    switch (indexPath.section) {
		case 0:
			cell.accessoryType = UITableViewCellAccessoryNone;
			switch (indexPath.row)
			{
				case 0:
					cell.textLabel.text = [NSString stringWithFormat:@"Full Name: %@", user.fullName];
					break;
				case 1:
					cell.textLabel.text = [NSString stringWithFormat:@"Username: %@", user.name];
					break;
				case 2:
					cell.textLabel.text = [NSString stringWithFormat:@"Email: %@", user.email];
					break;
				default:
					break;
			}
			break;
		case 1:
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			switch (indexPath.row)
			{
				case 0:
					cell.textLabel.text = [NSString stringWithFormat:@"View issues assigned to %@", username];
					break;
				case 1:
					cell.textLabel.text = [NSString stringWithFormat:@"View issues reported by %@", username];
					break;
			}
			break;
	}
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
	if (indexPath.section == 1) {
		switch (indexPath.row) {
			case 0:
			{
				IssuesController *issuesController = [[IssuesController alloc] initForJql:[NSString stringWithFormat:@"assignee = %@",username]];
				[self.navigationController pushViewController:issuesController animated:YES];
				[issuesController release];
				break;
			}
			case 1:
			{
				IssuesController *issuesController = [[IssuesController alloc] initForJql:[NSString stringWithFormat:@"reporter = %@", username]];
				[self.navigationController pushViewController:issuesController animated:YES];
				[issuesController release];
				break;
			}
			default:
				break;
		}
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
}


- (void)dealloc {
    [super dealloc];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {
	[activityIndicator stopAnimating];
	if ([result isKindOfClass:[User class]]) {
		[user release];
		user = [result retain];
		[self.tableView reloadData];
	}
}

- (void)didFailWithError:(NSError *)error {
	[activityIndicator stopAnimating];
}


@end

