/*
	JIPRemotePermissionMapping.h
	The interface definition of properties and methods for the JIPRemotePermissionMapping object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
@class JIPRemotePermission;
@class JIPArrayOf_tns1_RemoteEntity;

@interface JIPRemotePermissionMapping : SoapObject
{
	JIPRemotePermission* _permission;
	JIPArrayOf_tns1_RemoteEntity* _remoteEntities;
	
}
		
	@property (retain, nonatomic) JIPRemotePermission* permission;
	@property (retain, nonatomic) JIPArrayOf_tns1_RemoteEntity* remoteEntities;

	+ (JIPRemotePermissionMapping*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
