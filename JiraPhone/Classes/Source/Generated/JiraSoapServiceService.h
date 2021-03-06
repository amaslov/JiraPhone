/*
	JiraSoapServiceService.h
	The interface definition of classes and methods for the JiraSoapServiceService web service.
	Generated by SudzC.com
*/
				
#import "Soap.h"
	
/* Add class references */
				
#import "RemoteEntity.h"
#import "RemoteComponent.h"
#import "RemoteNamedObject.h"
#import "RemoteResolution.h"
#import "RemoteStatus.h"
#import "RemoteField.h"
#import "RemoteException.h"
#import "RemotePermissionException.h"
#import "RemoteAuthenticationException.h"
#import "RemoteValidationException.h"
#import "ArrayOf_tns1_RemoteUser.h"
#import "ArrayOf_tns1_RemoteVersion.h"
#import "ArrayOf_xsd_string.h"
#import "ArrayOf_tns1_RemoteComponent.h"
#import "ArrayOf_tns1_RemoteCustomFieldValue.h"
#import "ArrayOf_tns1_RemoteFieldValue.h"
#import "ArrayOf_tns1_RemoteNamedObject.h"
#import "ArrayOf_tns1_RemoteIssueType.h"
#import "ArrayOf_tns1_RemoteEntity.h"
#import "ArrayOf_tns1_RemotePermissionMapping.h"
#import "ArrayOf_tns1_RemotePriority.h"
#import "ArrayOf_tns1_RemoteResolution.h"
#import "ArrayOf_tns1_RemoteStatus.h"
#import "ArrayOf_tns1_RemoteProjectRole.h"
#import "ArrayOf_tns1_RemoteRoleActor.h"
#import "ArrayOf_tns1_RemoteScheme.h"
#import "ArrayOf_tns1_RemoteField.h"
#import "ArrayOf_tns1_RemoteComment.h"
#import "ArrayOf_tns1_RemoteFilter.h"
#import "ArrayOf_tns1_RemoteSecurityLevel.h"
#import "ArrayOf_tns1_RemoteAvatar.h"
#import "ArrayOf_tns1_RemotePermissionScheme.h"
#import "ArrayOf_tns1_RemotePermission.h"
#import "ArrayOf_xsd_base64Binary.h"
#import "ArrayOf_tns1_RemoteAttachment.h"
#import "ArrayOf_tns1_RemoteWorklog.h"
#import "ArrayOf_tns1_RemoteIssue.h"
#import "ArrayOf_tns1_RemoteProject.h"
#import "AbstractRemoteEntity.h"
#import "AbstractNamedRemoteEntity.h"
#import "RemoteIssueType.h"
#import "RemotePermissionScheme.h"
#import "RemotePriority.h"
#import "RemoteProjectRoleActors.h"
#import "RemoteSecurityLevel.h"
#import "RemoteConfiguration.h"
#import "RemoteWorklog.h"
#import "RemoteGroup.h"
#import "RemoteTimeInfo.h"
#import "RemoteFieldValue.h"
#import "AbstractRemoteConstant.h"
#import "RemotePermission.h"
#import "RemotePermissionMapping.h"
#import "RemoteIssue.h"
#import "RemoteUser.h"
#import "RemoteCustomFieldValue.h"
#import "RemoteProjectRole.h"
#import "RemoteRoleActors.h"
#import "RemoteVersion.h"
#import "RemoteScheme.h"
#import "RemoteFilter.h"
#import "RemoteRoleActor.h"
#import "RemoteAttachment.h"
#import "RemoteServerInfo.h"
#import "RemoteAvatar.h"
#import "RemoteComment.h"
#import "RemoteProject.h"

/* Interface for the service */
				
@interface JiraSoapServiceService : SoapService
		
	/* Returns RemoteComment*.  */
	- (SoapRequest*) getComment: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (long) in1;
	- (SoapRequest*) getComment: (id) target action: (SEL) action in0: (NSString*) in0 in1: (long) in1;

	/* Returns RemoteGroup*.  */
	- (SoapRequest*) createGroup: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteUser*) in2;
	- (SoapRequest*) createGroup: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteUser*) in2;

	/* Returns RemoteServerInfo*.  */
	- (SoapRequest*) getServerInfo: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getServerInfo: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns RemoteGroup*.  */
	- (SoapRequest*) getGroup: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getGroup: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns NSString*.  */
	- (SoapRequest*) login: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) login: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteUser*.  */
	- (SoapRequest*) getUser: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getUser: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteIssue*.  */
	- (SoapRequest*) getIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteVersion*.  */
	- (SoapRequest*) getVersions: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getVersions: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteComponent*.  */
	- (SoapRequest*) getComponents: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getComponents: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteUser*.  */
	- (SoapRequest*) createUser: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (NSString*) in3 in4: (NSString*) in4;
	- (SoapRequest*) createUser: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (NSString*) in3 in4: (NSString*) in4;

	/* Returns RemoteIssue*.  */
	- (SoapRequest*) createIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteIssue*) in1;
	- (SoapRequest*) createIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteIssue*) in1;

	/* Returns RemoteIssue*.  */
	- (SoapRequest*) updateIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (ArrayOf_tns1_RemoteFieldValue*) in2;
	- (SoapRequest*) updateIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (ArrayOf_tns1_RemoteFieldValue*) in2;

	/* Returns .  */
	- (SoapRequest*) deleteIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) deleteIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteNamedObject*.  */
	- (SoapRequest*) getAvailableActions: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getAvailableActions: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteIssueType*.  */
	- (SoapRequest*) getSubTaskIssueTypes: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getSubTaskIssueTypes: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns RemoteConfiguration*.  */
	- (SoapRequest*) getConfiguration: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getConfiguration: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns RemoteProject*.  */
	- (SoapRequest*) createProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (NSString*) in3 in4: (NSString*) in4 in5: (NSString*) in5 in6: (RemotePermissionScheme*) in6 in7: (RemoteScheme*) in7 in8: (RemoteScheme*) in8;
	- (SoapRequest*) createProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (NSString*) in3 in4: (NSString*) in4 in5: (NSString*) in5 in6: (RemotePermissionScheme*) in6 in7: (RemoteScheme*) in7 in8: (RemoteScheme*) in8;

	/* Returns RemoteProject*.  */
	- (SoapRequest*) updateProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProject*) in1;
	- (SoapRequest*) updateProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProject*) in1;

	/* Returns RemoteProject*.  */
	- (SoapRequest*) getProjectByKey: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getProjectByKey: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns .  */
	- (SoapRequest*) removeAllRoleActorsByProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProject*) in1;
	- (SoapRequest*) removeAllRoleActorsByProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProject*) in1;

	/* Returns ArrayOf_tns1_RemotePriority*.  */
	- (SoapRequest*) getPriorities: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getPriorities: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemoteResolution*.  */
	- (SoapRequest*) getResolutions: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getResolutions: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemoteIssueType*.  */
	- (SoapRequest*) getIssueTypes: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getIssueTypes: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemoteStatus*.  */
	- (SoapRequest*) getStatuses: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getStatuses: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemoteIssueType*.  */
	- (SoapRequest*) getIssueTypesForProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getIssueTypesForProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteProjectRole*.  */
	- (SoapRequest*) getProjectRoles: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getProjectRoles: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns RemoteProjectRole*.  */
	- (SoapRequest*) getProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (long) in1;
	- (SoapRequest*) getProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (long) in1;

	/* Returns RemoteProjectRoleActors*.  */
	- (SoapRequest*) getProjectRoleActors: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1 in2: (RemoteProject*) in2;
	- (SoapRequest*) getProjectRoleActors: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1 in2: (RemoteProject*) in2;

	/* Returns RemoteRoleActors*.  */
	- (SoapRequest*) getDefaultRoleActors: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;
	- (SoapRequest*) getDefaultRoleActors: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;

	/* Returns .  */
	- (SoapRequest*) removeAllRoleActorsByNameAndType: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;
	- (SoapRequest*) removeAllRoleActorsByNameAndType: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;

	/* Returns .  */
	- (SoapRequest*) deleteProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1 in2: (BOOL) in2;
	- (SoapRequest*) deleteProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1 in2: (BOOL) in2;

	/* Returns .  */
	- (SoapRequest*) updateProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;
	- (SoapRequest*) updateProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;

	/* Returns RemoteProjectRole*.  */
	- (SoapRequest*) createProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;
	- (SoapRequest*) createProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;

	/* Returns BOOL.  */
	- (SoapRequest*) isProjectRoleNameUnique: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) isProjectRoleNameUnique: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns .  */
	- (SoapRequest*) addActorsToProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (RemoteProject*) in3 in4: (NSString*) in4;
	- (SoapRequest*) addActorsToProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (RemoteProject*) in3 in4: (NSString*) in4;

	/* Returns .  */
	- (SoapRequest*) removeActorsFromProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (RemoteProject*) in3 in4: (NSString*) in4;
	- (SoapRequest*) removeActorsFromProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (RemoteProject*) in3 in4: (NSString*) in4;

	/* Returns .  */
	- (SoapRequest*) addDefaultActorsToProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (NSString*) in3;
	- (SoapRequest*) addDefaultActorsToProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (NSString*) in3;

	/* Returns .  */
	- (SoapRequest*) removeDefaultActorsFromProjectRole: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (NSString*) in3;
	- (SoapRequest*) removeDefaultActorsFromProjectRole: (id) target action: (SEL) action in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (RemoteProjectRole*) in2 in3: (NSString*) in3;

	/* Returns ArrayOf_tns1_RemoteScheme*.  */
	- (SoapRequest*) getAssociatedNotificationSchemes: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;
	- (SoapRequest*) getAssociatedNotificationSchemes: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;

	/* Returns ArrayOf_tns1_RemoteScheme*.  */
	- (SoapRequest*) getAssociatedPermissionSchemes: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;
	- (SoapRequest*) getAssociatedPermissionSchemes: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProjectRole*) in1;

	/* Returns .  */
	- (SoapRequest*) deleteProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) deleteProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteProject*.  */
	- (SoapRequest*) getProjectById: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (long) in1;
	- (SoapRequest*) getProjectById: (id) target action: (SEL) action in0: (NSString*) in0 in1: (long) in1;

	/* Returns ArrayOf_tns1_RemoteField*.  */
	- (SoapRequest*) getCustomFields: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getCustomFields: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemoteComment*.  */
	- (SoapRequest*) getComments: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getComments: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteFilter*.  */
	- (SoapRequest*) getFavouriteFilters: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getFavouriteFilters: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns .  */
	- (SoapRequest*) releaseVersion: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteVersion*) in2;
	- (SoapRequest*) releaseVersion: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteVersion*) in2;

	/* Returns .  */
	- (SoapRequest*) archiveVersion: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (BOOL) in3;
	- (SoapRequest*) archiveVersion: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (BOOL) in3;

	/* Returns ArrayOf_tns1_RemoteField*.  */
	- (SoapRequest*) getFieldsForEdit: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getFieldsForEdit: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteIssueType*.  */
	- (SoapRequest*) getSubTaskIssueTypesForProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getSubTaskIssueTypesForProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns .  */
	- (SoapRequest*) addUserToGroup: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteGroup*) in1 in2: (RemoteUser*) in2;
	- (SoapRequest*) addUserToGroup: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteGroup*) in1 in2: (RemoteUser*) in2;

	/* Returns .  */
	- (SoapRequest*) removeUserFromGroup: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteGroup*) in1 in2: (RemoteUser*) in2;
	- (SoapRequest*) removeUserFromGroup: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteGroup*) in1 in2: (RemoteUser*) in2;

	/* Returns RemoteSecurityLevel*.  */
	- (SoapRequest*) getSecurityLevel: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getSecurityLevel: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns BOOL.  */
	- (SoapRequest*) logout: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) logout: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns .  */
	- (SoapRequest*) addComment: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteComment*) in2;
	- (SoapRequest*) addComment: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteComment*) in2;

	/* Returns RemoteProject*.  */
	- (SoapRequest*) getProjectWithSchemesById: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (long) in1;
	- (SoapRequest*) getProjectWithSchemesById: (id) target action: (SEL) action in0: (NSString*) in0 in1: (long) in1;

	/* Returns ArrayOf_tns1_RemoteSecurityLevel*.  */
	- (SoapRequest*) getSecurityLevels: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getSecurityLevels: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteAvatar*.  */
	- (SoapRequest*) getProjectAvatars: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (BOOL) in2;
	- (SoapRequest*) getProjectAvatars: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (BOOL) in2;

	/* Returns .  */
	- (SoapRequest*) setProjectAvatar: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (long) in2;
	- (SoapRequest*) setProjectAvatar: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (long) in2;

	/* Returns RemoteAvatar*.  */
	- (SoapRequest*) getProjectAvatar: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getProjectAvatar: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns .  */
	- (SoapRequest*) deleteProjectAvatar: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (long) in1;
	- (SoapRequest*) deleteProjectAvatar: (id) target action: (SEL) action in0: (NSString*) in0 in1: (long) in1;

	/* Returns ArrayOf_tns1_RemoteScheme*.  */
	- (SoapRequest*) getNotificationSchemes: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getNotificationSchemes: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemotePermissionScheme*.  */
	- (SoapRequest*) getPermissionSchemes: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getPermissionSchemes: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemotePermission*.  */
	- (SoapRequest*) getAllPermissions: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getAllPermissions: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns RemotePermissionScheme*.  */
	- (SoapRequest*) createPermissionScheme: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;
	- (SoapRequest*) createPermissionScheme: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;

	/* Returns RemotePermissionScheme*.  */
	- (SoapRequest*) addPermissionTo: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemotePermissionScheme*) in1 in2: (RemotePermission*) in2 in3: (RemoteEntity*) in3;
	- (SoapRequest*) addPermissionTo: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemotePermissionScheme*) in1 in2: (RemotePermission*) in2 in3: (RemoteEntity*) in3;

	/* Returns RemotePermissionScheme*.  */
	- (SoapRequest*) deletePermissionFrom: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemotePermissionScheme*) in1 in2: (RemotePermission*) in2 in3: (RemoteEntity*) in3;
	- (SoapRequest*) deletePermissionFrom: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemotePermissionScheme*) in1 in2: (RemotePermission*) in2 in3: (RemoteEntity*) in3;

	/* Returns .  */
	- (SoapRequest*) deletePermissionScheme: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) deletePermissionScheme: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteIssue*.  */
	- (SoapRequest*) createIssueWithSecurityLevel: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteIssue*) in1 in2: (long) in2;
	- (SoapRequest*) createIssueWithSecurityLevel: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteIssue*) in1 in2: (long) in2;

	/* Returns BOOL.  */
	- (SoapRequest*) addAttachmentsToIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (ArrayOf_xsd_string*) in2 in3: (ArrayOf_xsd_base64Binary*) in3;
	- (SoapRequest*) addAttachmentsToIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (ArrayOf_xsd_string*) in2 in3: (ArrayOf_xsd_base64Binary*) in3;

	/* Returns ArrayOf_tns1_RemoteAttachment*.  */
	- (SoapRequest*) getAttachmentsFromIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getAttachmentsFromIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns BOOL.  */
	- (SoapRequest*) hasPermissionToEditComment: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteComment*) in1;
	- (SoapRequest*) hasPermissionToEditComment: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteComment*) in1;

	/* Returns RemoteComment*.  */
	- (SoapRequest*) editComment: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteComment*) in1;
	- (SoapRequest*) editComment: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteComment*) in1;

	/* Returns ArrayOf_tns1_RemoteField*.  */
	- (SoapRequest*) getFieldsForAction: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;
	- (SoapRequest*) getFieldsForAction: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;

	/* Returns RemoteIssue*.  */
	- (SoapRequest*) progressWorkflowAction: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (ArrayOf_tns1_RemoteFieldValue*) in3;
	- (SoapRequest*) progressWorkflowAction: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (ArrayOf_tns1_RemoteFieldValue*) in3;

	/* Returns RemoteIssue*.  */
	- (SoapRequest*) getIssueById: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getIssueById: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteWorklog*.  */
	- (SoapRequest*) addWorklogWithNewRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteWorklog*) in2 in3: (NSString*) in3;
	- (SoapRequest*) addWorklogWithNewRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteWorklog*) in2 in3: (NSString*) in3;

	/* Returns RemoteWorklog*.  */
	- (SoapRequest*) addWorklogAndAutoAdjustRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteWorklog*) in2;
	- (SoapRequest*) addWorklogAndAutoAdjustRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteWorklog*) in2;

	/* Returns RemoteWorklog*.  */
	- (SoapRequest*) addWorklogAndRetainRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteWorklog*) in2;
	- (SoapRequest*) addWorklogAndRetainRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteWorklog*) in2;

	/* Returns .  */
	- (SoapRequest*) deleteWorklogWithNewRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;
	- (SoapRequest*) deleteWorklogWithNewRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;

	/* Returns .  */
	- (SoapRequest*) deleteWorklogAndAutoAdjustRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) deleteWorklogAndAutoAdjustRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns .  */
	- (SoapRequest*) deleteWorklogAndRetainRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) deleteWorklogAndRetainRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns .  */
	- (SoapRequest*) updateWorklogWithNewRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteWorklog*) in1 in2: (NSString*) in2;
	- (SoapRequest*) updateWorklogWithNewRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteWorklog*) in1 in2: (NSString*) in2;

	/* Returns .  */
	- (SoapRequest*) updateWorklogAndAutoAdjustRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteWorklog*) in1;
	- (SoapRequest*) updateWorklogAndAutoAdjustRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteWorklog*) in1;

	/* Returns .  */
	- (SoapRequest*) updateWorklogAndRetainRemainingEstimate: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteWorklog*) in1;
	- (SoapRequest*) updateWorklogAndRetainRemainingEstimate: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteWorklog*) in1;

	/* Returns ArrayOf_tns1_RemoteWorklog*.  */
	- (SoapRequest*) getWorklogs: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getWorklogs: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns BOOL.  */
	- (SoapRequest*) hasPermissionToCreateWorklog: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) hasPermissionToCreateWorklog: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns BOOL.  */
	- (SoapRequest*) hasPermissionToDeleteWorklog: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) hasPermissionToDeleteWorklog: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns BOOL.  */
	- (SoapRequest*) hasPermissionToUpdateWorklog: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) hasPermissionToUpdateWorklog: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns NSDate*.  */
	- (SoapRequest*) getResolutionDateByKey: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getResolutionDateByKey: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns NSDate*.  */
	- (SoapRequest*) getResolutionDateById: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (long) in1;
	- (SoapRequest*) getResolutionDateById: (id) target action: (SEL) action in0: (NSString*) in0 in1: (long) in1;

	/* Returns long.  */
	- (SoapRequest*) getIssueCountForFilter: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getIssueCountForFilter: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteIssue*.  */
	- (SoapRequest*) getIssuesFromTextSearch: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getIssuesFromTextSearch: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteIssue*.  */
	- (SoapRequest*) getIssuesFromTextSearchWithProject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (NSString*) in2 in3: (int) in3;
	- (SoapRequest*) getIssuesFromTextSearchWithProject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (ArrayOf_xsd_string*) in1 in2: (NSString*) in2 in3: (int) in3;

	/* Returns ArrayOf_tns1_RemoteIssue*.  */
	- (SoapRequest*) getIssuesFromJqlSearch: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (int) in2;
	- (SoapRequest*) getIssuesFromJqlSearch: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (int) in2;

	/* Returns .  */
	- (SoapRequest*) deleteUser: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) deleteUser: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns RemoteGroup*.  */
	- (SoapRequest*) updateGroup: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteGroup*) in1;
	- (SoapRequest*) updateGroup: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteGroup*) in1;

	/* Returns .  */
	- (SoapRequest*) deleteGroup: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;
	- (SoapRequest*) deleteGroup: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2;

	/* Returns .  */
	- (SoapRequest*) refreshCustomFields: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) refreshCustomFields: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns ArrayOf_tns1_RemoteFilter*.  */
	- (SoapRequest*) getSavedFilters: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getSavedFilters: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns BOOL.  */
	- (SoapRequest*) addBase64EncodedAttachmentsToIssue: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (ArrayOf_xsd_string*) in2 in3: (ArrayOf_xsd_string*) in3;
	- (SoapRequest*) addBase64EncodedAttachmentsToIssue: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (ArrayOf_xsd_string*) in2 in3: (ArrayOf_xsd_string*) in3;

	/* Returns RemoteProject*.  */
	- (SoapRequest*) createProjectFromObject: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (RemoteProject*) in1;
	- (SoapRequest*) createProjectFromObject: (id) target action: (SEL) action in0: (NSString*) in0 in1: (RemoteProject*) in1;

	/* Returns ArrayOf_tns1_RemoteScheme*.  */
	- (SoapRequest*) getSecuritySchemes: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getSecuritySchemes: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns RemoteVersion*.  */
	- (SoapRequest*) addVersion: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteVersion*) in2;
	- (SoapRequest*) addVersion: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (RemoteVersion*) in2;

	/* Returns ArrayOf_tns1_RemoteIssue*.  */
	- (SoapRequest*) getIssuesFromFilter: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1;
	- (SoapRequest*) getIssuesFromFilter: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1;

	/* Returns ArrayOf_tns1_RemoteIssue*.  */
	- (SoapRequest*) getIssuesFromFilterWithLimit: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (int) in2 in3: (int) in3;
	- (SoapRequest*) getIssuesFromFilterWithLimit: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (int) in2 in3: (int) in3;

	/* Returns ArrayOf_tns1_RemoteIssue*.  */
	- (SoapRequest*) getIssuesFromTextSearchWithLimit: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (int) in2 in3: (int) in3;
	- (SoapRequest*) getIssuesFromTextSearchWithLimit: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (int) in2 in3: (int) in3;

	/* Returns ArrayOf_tns1_RemoteProject*.  */
	- (SoapRequest*) getProjectsNoSchemes: (id <SoapDelegate>) handler in0: (NSString*) in0;
	- (SoapRequest*) getProjectsNoSchemes: (id) target action: (SEL) action in0: (NSString*) in0;

	/* Returns .  */
	- (SoapRequest*) setNewProjectAvatar: (id <SoapDelegate>) handler in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (NSString*) in3;
	- (SoapRequest*) setNewProjectAvatar: (id) target action: (SEL) action in0: (NSString*) in0 in1: (NSString*) in1 in2: (NSString*) in2 in3: (NSString*) in3;

		
	+ (JiraSoapServiceService*) service;
	+ (JiraSoapServiceService*) serviceWithUsername: (NSString*) username andPassword: (NSString*) password;

@end
	