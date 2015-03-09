

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "TDReachability.h"
#import "TDMBProgressHUDManager.h"

#define TB_DOMAIN @"TB_DOMAIN"

#define CallAPI_WITHURL_WHITTYPEAPI_WITHPARAMS_WITHCOMPLETED(url,typeAPI,params,block) [TBServices callAPIWithUrl : url TypeAPI : typeAPI withParams : params completed : block]

typedef void (^CompleteAPIBlock)(id result, NSError *error);
typedef enum : NSUInteger {
    POST = 0,
    GET  = 1,
    PUT  = 2,
    DELETE = 3,
} TypeAPI;

@interface TBServices : NSObject

#pragma mark - Private
/**
 *  success
 *
 *  @param responseObject id
 *  @param block          CompleteAPIBlock
 */
+ (void)success:(id)responseObject completeAPIBlock:(CompleteAPIBlock)block;

/**
 *  failure
 *
 *  @param error NSError
 *  @param block CompleteAPIBlock
 */
+ (void)failure:(NSError *)error completeAPIBlock:(CompleteAPIBlock)block;

#pragma mark - Utils

/**
 *  checkConnection
 *
 *  @return BOOL
 */
+ (BOOL )checkConnection;

/**
 *  supportHTTPS
 *
 *  @param manager AFHTTPRequestOperationManager
 */
+ (void)supportHTTPS:(AFHTTPRequestOperationManager *)manager;

#pragma mark - Call API

/**
 *  callAPIWithUrl
 *
 *  @param url        NSString
 *  @param type       TypeAPI
 *  @param dictParams NSMutableDictionary
 *  @param block      CompleteAPIBlock
 */
+ (void)callAPIWithUrl:(NSString *)url withTypeAPI:(TypeAPI)type withParams:(NSMutableDictionary *)dictParams completed:(CompleteAPIBlock)block;

#pragma mark - UPDATE AVATAR

/**
 *  uploadAvatarBase64WithUrl
 *  Base 64
 *
 *  @param url          NSString
 *  @param param        NSMutableDictionary
 *  @param contentImage UIImage
 *  @param block        CompleteAPIBlock
 */
+ (void)uploadAvatarBase64WithUrl:(NSString *)url param:(NSMutableDictionary*)param content:(UIImage*)contentImage completed:(CompleteAPIBlock)block;


/**
 *  uploadAvatarWithURL
 *  image data
 *
 *  @param url   NSString
 *  @param image UIImage
 *  @param param NSMutableDictionary
 *  @param block CompleteAPIBlock
 */
+ (void)uploadAvatarWithURL:(NSString *)url withImage:(UIImage*)image param:(NSMutableDictionary*)param completed:(CompleteAPIBlock)block;

@end
