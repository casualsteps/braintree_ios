#import <Foundation/Foundation.h>

/// An error domain for 3D Secure errors
///
/// @see BTThreeDSecure
extern NSString * const BTThreeDSecureErrorDomain;
extern NSString * const BTThreeDSecureInfoKey;
extern NSString * const BTThreeDSecureValidationErrorsKey;

 /// Error codes that describe errors that occur during 3D Secure
typedef NS_ENUM(NSInteger, BTThreeDSecureErrorType){
    /// An unknown error related to 3D Secure occured.
    BTThreeDSecureErrorTypeUnknown = 0,
    /// 3D Secure failed during the backend card lookup phase; please retry.
    BTThreeDSecureErrorTypeFailedLookup,
    /// 3D Secure failed during the user-facing authentication phase; please retry.
    BTThreeDSecureErrorTypeFailedAuthentication,
    /// Braintree SDK is integrated incorrectly
    BTThreeDSecureErrorTypeIntegration,
};
