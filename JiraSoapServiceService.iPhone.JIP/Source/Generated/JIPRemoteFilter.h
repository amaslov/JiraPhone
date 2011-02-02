/*
	JIPRemoteFilter.h
	The interface definition of properties and methods for the JIPRemoteFilter object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "JIPAbstractNamedRemoteEntity.h"
@class JIPAbstractNamedRemoteEntity;


@interface JIPRemoteFilter : JIPAbstractNamedRemoteEntity
{
	NSString* _author;
	NSString* _description;
	NSString* _project;
	NSString* _xml;
	
}
		
	@property (retain, nonatomic) NSString* author;
	@property (retain, nonatomic) NSString* description;
	@property (retain, nonatomic) NSString* project;
	@property (retain, nonatomic) NSString* xml;

	+ (JIPRemoteFilter*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
