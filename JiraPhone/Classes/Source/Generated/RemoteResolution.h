/*
	RemoteResolution.h
	The interface definition of properties and methods for the RemoteResolution object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "AbstractRemoteConstant.h"
@class AbstractRemoteConstant;


@interface RemoteResolution : AbstractRemoteConstant
{
	
}
		

	+ (RemoteResolution*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
