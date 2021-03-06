/*
	JIPRemotePermission.h
	The interface definition of properties and methods for the JIPRemotePermission object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface JIPRemotePermission : SoapObject
{
	NSString* _name;
	long _permission;
	
}
		
	@property (retain, nonatomic) NSString* name;
	@property long permission;

	+ (JIPRemotePermission*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
