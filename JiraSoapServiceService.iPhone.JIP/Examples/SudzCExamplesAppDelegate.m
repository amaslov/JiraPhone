
#import "SudzCExamplesAppDelegate.h"
#import "JIPJiraSoapServiceServiceExample.h"


@implementation SudzCExamplesAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application {

JIPJiraSoapServiceServiceExample* example1 = [[[JIPJiraSoapServiceServiceExample alloc] init] autorelease];
		[example1 run];


	[window makeKeyAndVisible];
}

- (void)dealloc {
	[window release];
	[super dealloc];
}

@end
			