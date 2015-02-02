

#import "TBServices.h"
#import "NSData+Base64.h"

@implementation TBServices

#pragma mark - Utils
/**
 *  checkConnection
 *
 *  @return BOOL
 */
+ (BOOL )checkConnection
{
    if ( ![TDReachability connectedToNetwork] )
    {
        //can't connect to internet
        return NO;
    }
    return YES;
}

/**
 *  supportHTTPS
 *
 *  @param manager AFHTTPRequestOperationManager
 */
+ (void)supportHTTPS:(AFHTTPRequestOperationManager *)manager
{
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
}

#pragma mark - Private
/**
 *  success
 *
 *  @param responseObject id
 *  @param block          CompleteAPIBlock
 */
+ (void)success:(id)responseObject completeAPIBlock:(CompleteAPIBlock)block
{
    
}

/**
 *  failure
 *
 *  @param error NSError
 *  @param block CompleteAPIBlock
 */
+ (void)failure:(NSError *)error completeAPIBlock:(CompleteAPIBlock)block
{
    
}

#pragma mark - Call API
/**
 *  callAPIWithUrl
 *
 *  @param url        NSString
 *  @param type       TypeAPI
 *  @param dictParams NSMutableDictionary
 *  @param block      CompleteAPIBlock
 */
+ (void)callAPIWithUrl:(NSString *)url withTypeAPI:(TypeAPI)type withParams:(NSMutableDictionary *)dictParams completed:(CompleteAPIBlock)block
{
    // Check network
    if ( [self checkConnection] )
    {
        // Use AFHTTPRequestOperationManager
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:TB_DOMAIN]];
        
        //https support
        [self supportHTTPS:manager];
        
        // Request API
        //POST
        if (type == POST) {
            [manager POST:[TB_DOMAIN stringByAppendingString:url] parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 // Success
                 [self success:responseObject completeAPIBlock:block];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 // Fails
                 [self failure:error completeAPIBlock:block];
             }];
            
        }
        else if (type == GET)
        {
            [manager GET:[TB_DOMAIN stringByAppendingString:url] parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 // Success
                 [self success:responseObject completeAPIBlock:block];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 //fails
                 [self failure:error completeAPIBlock:block];
             }];
        }
        else if (type == DELETE)
        {
            [manager DELETE:url parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 // Success
                 [self success:responseObject completeAPIBlock:block];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 //fails
                 [self failure:error completeAPIBlock:block];
             }];
        }
        else if (type == PUT)
        {
            [manager PUT:url parameters:dictParams success:^(AFHTTPRequestOperation *operation, id responseObject)
             {
                 // Success
                 [self success:responseObject completeAPIBlock:block];
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error)
             {
                 //fails
                 [self failure:error completeAPIBlock:block];
             }];
        }
    }
    else
    {
        //No internet connection
    }
}

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
+ (void)uploadAvatarBase64WithUrl:(NSString *)url  param:(NSMutableDictionary*)param   content:(UIImage*)contentImage completed:(CompleteAPIBlock)block {
    
    // Check network
    if ( [self checkConnection] )
    {
        //encode image to base 64 string
        NSData *data = UIImagePNGRepresentation(contentImage);
        NSString *str = [data base64EncodedString];
        [param setValue:str forKey:@"content"];
        
        //use AFHTTPRequestOperationManager
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        //request api
        [manager POST:[TB_DOMAIN stringByAppendingString:url] parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject)
         {
             //success
             [self success:responseObject completeAPIBlock:block];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error)
         {
             //fails
             [self failure:error completeAPIBlock:block];
         }];
    }
    else
    {
        
    }
}

/**
 *  uploadAvatarWithURL
 *  image data
 *
 *  @param url   NSString
 *  @param image UIImage
 *  @param param NSMutableDictionary
 *  @param block CompleteAPIBlock
 */
+ (void)uploadAvatarWithURL:(NSString *)url withImage:(UIImage*)image param:(NSMutableDictionary*)param completed:(CompleteAPIBlock)block
{
    // Check network
    if ( [self checkConnection] )
    {
        AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:TB_DOMAIN]];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 1);
        
        AFHTTPRequestOperation *op = [manager POST:[TB_DOMAIN stringByAppendingString:url]
                                        parameters:param
                         constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                      {
                                          
                                          [formData appendPartWithFileData:imageData name:@"avatar_file" fileName:@"photo.jpg" mimeType:@"image/jpeg"];
                                          
                                      } success:^(AFHTTPRequestOperation *operation, id responseObject)
                                      {
                                          //success
                                          [self success:responseObject completeAPIBlock:block];
                                      }
                                           failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                      {
                                          //fails
                                          [self failure:error completeAPIBlock:block];
                                      }];
        [op start];
    }
    else
    {
        
    }
}

@end
