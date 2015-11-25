//
//  afnGETPOST.h
//  luyouqi
//
//  Created by xiong on 15/11/6.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
typedef enum RequesSerializer{
    Requesjson,
}RequesSerializerTYPE;

typedef enum ResponseSerializer{
    Responsejson,
}ResponseSerializerTYPE;

@interface afnGETPOST : NSObject

+ (void)GETURL:(NSString *)url prames:(NSDictionary *)prames Reques:(typeof(RequesSerializerTYPE))Reques Response:(typeof(ResponseSerializerTYPE))Response success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)POSTURL:(NSString *)url prames:(NSDictionary *)prames Reques:(typeof(RequesSerializerTYPE))Reques Response:(typeof(ResponseSerializerTYPE))Response success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)GETURL:(NSString *)url prames:(NSDictionary *)prames success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
+ (void)POSTURL:(NSString *)url prames:(NSDictionary *)prames success:(void (^)(id json))success failure:(void (^)(NSError *error))failure;
@end
