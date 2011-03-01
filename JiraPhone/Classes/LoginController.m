//
//  LoginController.m
//  JiraPhone
//
//  Created by Aleksey Maslov on 12/15/10.
//  Copyright 2010 AMaslov. All rights reserved.
//
#import "LoginController.h"
#import "Connector.h"
#import "ProjectsController.h"
#import "DashboardController.h"
#import "User.h"

#define SETTINGS_SAVE_CREDENTIALS		@"settingsSaveKey"
#define SETTINGS_LOGIN					@"loginKey"
#define SETTINGS_PASSWORD				@"passwordKey"
#define SETTINGS_SERVER					@"serverKey"

@implementation LoginController
@synthesize nameField, passwordField, serverField;
@synthesize switchControl;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	// see user settings
	NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    BOOL b = [ud boolForKey:@"hadBeen"];
	if (!b) {
		// it was first time,
		[ud setBool:YES forKey:@"hadBeen"];
		// so set initial settings
		[ud setBool:switchControl.on forKey:SETTINGS_SAVE_CREDENTIALS];
		[ud synchronize];
	}
	else {
		BOOL s = [ud boolForKey:SETTINGS_SAVE_CREDENTIALS];
		switchControl.on = s;
		
		if (switchControl.on) {
			nameField.text = [ud objectForKey:SETTINGS_LOGIN];
			passwordField.text = [ud objectForKey:SETTINGS_PASSWORD];
			serverField.text = [ud objectForKey:SETTINGS_SERVER];			
		}
	}
	
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	self.nameField = nil;
	self.passwordField = nil;
	self.serverField = nil;
	self.switchControl = nil;
}

- (void)dealloc {
	[switchControl release];
	[nameField release];
	[passwordField release];
	[serverField release];
    [super dealloc];
}

#pragma mark -
#pragma mark Connector delegate

- (void)didReceiveData:(id)result {

	if ([result isKindOfClass:[NSString class]]) {
		// Successful login
		
		User *user = [[User alloc] init];
		user.name = nameField.text;
		user.server = serverField.text;
		[User setLoggedInUser:user];
		[user release];
		
		// save credentials for autocomplete
		NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
		if (!switchControl.on) {
			nameField.text = @"";
			passwordField.text = @"";
			serverField.text = @"";
		}
		[ud setObject:nameField.text forKey:SETTINGS_LOGIN];
		[ud setObject:passwordField.text forKey:SETTINGS_PASSWORD];
		[ud setObject:serverField.text forKey:SETTINGS_SERVER];
		[ud synchronize];
		
		// show projects
		ProjectsController *projController = [[ProjectsController alloc] initWithNibName:@"ProjectsController" bundle:nil];
		[self.navigationController pushViewController:projController animated:YES];
		[projController release];
		
		// Show dashboard
		//DashboardController *dashController = [[DashboardController alloc] initWithNibName:@"DashboardController" bundle:nil];
		//[self.navigationController pushViewController:dashController animated:YES];
		//[dashController release];
	}
	else {
		// logout
		[User setLoggedInUser:nil];
	}
	[activityIndicator stopAnimating];
}

- (void)didFailWithError:(id)error {
	// Problems with login

	// alert user
	NSString *msg = nil;
	if ([error isKindOfClass:[SoapFault class]]) {
		SoapFault *sf = (SoapFault *)error;
		msg = sf.faultString;
	}
	else if ([error isKindOfClass:[NSError class]]) {
		NSError *err = (NSError *)error;
		msg = [err localizedDescription];
	} else {
		NSAssert(NO, @"Unknown error type!");
	}

	[activityIndicator stopAnimating];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message: msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

#pragma mark -
#pragma mark actions
- (IBAction)loginAction {
	NSString *server = serverField.text,
	*name = nameField.text,
	*password = passwordField.text;

	// add http:// if it's missed there	
	if (![server hasPrefix:@"http://"]) {
		server = [NSString stringWithFormat:@"http://%@", server];
	}
	// show wait spinner
	if (!activityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
		[self.view addSubview:activityIndicator];
		[activityIndicator release];
	}
	[activityIndicator startAnimating];
	
	// login
	[Connector sharedConnector].delegate = self;
	[[Connector sharedConnector] loginToServer:server withName:name andPassword:password];	
}

- (IBAction)logoutAction {
	// show wait spinner
	if (!activityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		activityIndicator.center = CGPointMake(self.view.bounds.size.width/2., self.view.bounds.size.height/2.);
		[self.view addSubview:activityIndicator];
		[activityIndicator release];
	}
	[activityIndicator startAnimating];
	
	// logout
	[Connector sharedConnector].delegate = self;
	[[Connector sharedConnector] logout];
	
}
- (IBAction)bgClick {
	[serverField resignFirstResponder];
	[nameField resignFirstResponder];
	[passwordField resignFirstResponder];
}

- (IBAction)switchAction {
	[[NSUserDefaults standardUserDefaults] setBool:switchControl.on forKey:SETTINGS_SAVE_CREDENTIALS];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


@end
