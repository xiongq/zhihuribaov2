//
//  afnGETPOST.m
//  luyouqi
//
//  Created by xiong on 15/11/6.
//  Copyright © 2015年 xiong. All rights reserved.
//

#import "afnGETPOST.h"



@implementation afnGETPOST
+(void)GETURL:(NSString *)url prames:(NSDictionary *)prames Reques:(typeof(RequesSerializerTYPE))Reques Response:(typeof(ResponseSerializerTYPE))Response success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    switch (Reques) {
        case Requesjson:
            manger.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
            
        default:
            break;
    }
    [manger GET:url parameters:prames success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];



}



+(void)POSTURL:(NSString *)url prames:(NSDictionary *)prames Reques:(typeof(RequesSerializerTYPE))Reques Response:(typeof(ResponseSerializerTYPE))Response success:(void (^)(id))success failure:(void (^)(NSError *))failure{
     AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    switch (Reques) {
        case Requesjson:
            manger.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
            
        default:
            break;
    }
    [manger POST:url parameters:prames success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)GETURL:(NSString *)url prames:(NSDictionary *)prames success:(void (^)(id))success failure:(void (^)(NSError *))failure{
         AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    [manger GET:url parameters:prames success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
+(void)POSTURL:(NSString *)url prames:(NSDictionary *)prames success:(void (^)(id))success failure:(void (^)(NSError *))failure{
         AFHTTPRequestOperationManager *manger = [[AFHTTPRequestOperationManager alloc] init];
    [manger POST:url parameters:prames success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
@end
