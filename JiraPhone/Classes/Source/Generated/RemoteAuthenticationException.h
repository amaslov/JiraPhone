/*
	RemoteAuthenticationException.h
	The interface definition of properties and methods for the RemoteAuthenticationException object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "RemoteException.h"
@class RemoteException;


@interface RemoteAuthenticationException : RemoteException
{
	
}
		

	+ (RemoteAuthenticationException*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
