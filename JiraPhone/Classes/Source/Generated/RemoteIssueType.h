/*
	RemoteIssueType.h
	The interface definition of properties and methods for the RemoteIssueType object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "AbstractRemoteConstant.h"
@class AbstractRemoteConstant;


@interface RemoteIssueType : AbstractRemoteConstant
{
	BOOL _subTask;
	
}
		
	@property BOOL subTask;

	+ (RemoteIssueType*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
