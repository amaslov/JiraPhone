/*
	JIPRemoteResolution.h
	The interface definition of properties and methods for the JIPRemoteResolution object.
	Generated by SudzC.com
*/

#import "Soap.h"
	
#import "JIPAbstractRemoteConstant.h"
@class JIPAbstractRemoteConstant;


@interface JIPRemoteResolution : JIPAbstractRemoteConstant
{
	
}
		

	+ (JIPRemoteResolution*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
