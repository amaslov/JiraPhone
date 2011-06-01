//
//  CommentsController.m
//  JiraPhone
//
//  Created by Matthew Gerrior on 5/24/11.
//  Copyright 2011 AMaslov. All rights reserved.
//

#import "CommentsController.h"
#import "Comment.h"
#import "Issue.h"
#import "Connector.h"

@implementation CommentsController
@synthesize issue;

- (id)initForIssue:(Issue *)_issue {
	// Initialize this screen for the given issue
	if (self = [super initWithNibName:@"CommentsController" bundle:nil]) {
		issue = [_issue retain];
	}
	return self;
}
#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = [NSString stringWithFormat:@"Comments"];
	
	// If there are no comments, initialize the array
	if (!comments) {
		comments = [[NSMutableArray alloc] init];
	}
	
	// if there's no cached comments show wait spinner
	if (!comments.count) {
		if (!activityIndicator) {
			activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
			activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
			[self.view addSubview:activityIndicator];
			[activityIndicator release];
		}
		[activityIndicator startAnimating];		
	}
	
	// Sync with server
	Connector *connector = [Connector sharedConnector];
	connector.delegate = self;
	
	// Get comments for this issue
	[connector getCommentsOfIssue:self.issue];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return comments.count ? comments.count : 1;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		
		// Set the properties for the title text (user and date)
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
		
		// Set the properties for the comment text
		cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.detailTextLabel.numberOfLines = 0;
		cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
    }
    
	// If there are comments, show them
	if (comments.count >= indexPath.row+1)
	{
		// Get the comment for this cell
		Comment *comment = [comments objectAtIndex:indexPath.row];
		
		// Create a formatter to produce a human readable
		// date at which the comment was created.
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
		
		// Get the body of the comment
		NSString *commentText = comment.body;
		
		// Format the date that the comment was created
		NSString *dateText = [dateFormat stringFromDate:comment.created];
		
		// Format the title
		NSString *titleText = [NSString stringWithFormat:@"%@ added a comment on %@", comment.author, dateText];	
		
		// Set the cell text
		cell.textLabel.text = titleText;
		cell.detailTextLabel.text = commentText;
		
		// Clean up memory
		[dateFormat release];
	}
	// Otherwise, display a message
	else {
		// Set the cell text
		cell.textLabel.text = [NSString stringWithFormat:@"No comments available."];
		cell.detailTextLabel.text = nil;
	}
	
    return cell;
}

- (int)heightOfCellWithTitle:(NSString *)titleText andDetails:(NSString *)detailText {
	CGSize titleSize = {0, 0};
	CGSize detailSize = {0, 0};
	
	// Get the size needed to display the title
	if (titleText && ![titleText isEqualToString:@""]) {
		titleSize = [titleText sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(270.0f, 4000) lineBreakMode:UILineBreakModeWordWrap];
	}
	// Get the size needed to display the comment
	if (detailText && ![detailText isEqualToString:@""]) {
		detailSize = [detailText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(270.0f, 4000) lineBreakMode:UILineBreakModeWordWrap];
	}
	
	// Return the height needed to display the text, and 10px buffer
	return titleSize.height + detailSize.height + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Get the height of the cell if it contains a comment
	if ([comments count] >= indexPath.row + 1) {
		// Get the comment that needs to be displayed
		Comment *comment = [comments objectAtIndex:indexPath.row];
		
		// Make a formatter to format the creation date of the comment
		NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
		[dateFormat setDateFormat:@"yyyy-MM-dd 'at' HH:mm"];
		
		// Get the text of the comment
		NSString *commentText = comment.body;
		
		// Format the creation date
		NSString *dateText = [dateFormat stringFromDate:comment.created];
		
		// Create the title to be displayed
		NSString *titleText = [NSString stringWithFormat:@"%@ added a comment on %@", comment.author, dateText];
		
		// Get the height needed to display the text
		int height = [self heightOfCellWithTitle:titleText andDetails:commentText];

		// Clean up the memory
		[dateFormat release];
		
		// Return the height needed to display the text, or
		// a minimum of 44 pixels.
		return (height < 44 ? 44.0f : height);
	}
	// Return the default cell height
	return 44.0f;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
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
#pragma mark Connector Delegate

- (void)didReceiveData:(id)result {
	// Stop the activity indicator
	[activityIndicator stopAnimating];
	
	// Store comments returned from connector
	if ([result isKindOfClass:[NSArray class]]) {
		[comments release];
		// Chop off the first comment, since it is just junk
		result = [result subarrayWithRange:NSMakeRange(1, [result count]-1)];
		// Need to make a mutable copy so that we can sort
		comments = [result mutableCopy];
		// Sort the comments in ascending order based on
		// creation date
		[comments sortUsingSelector:@selector(compareCreatedDate:)];
		// Reload data in the table
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


@end

