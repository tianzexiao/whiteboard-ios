
//  WBDataSource.m
//  whiteboard
//
//  Created by sad-fueled on 9/10/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBDataSource.h"

@implementation WBDataSource

static Class DataSourceSubclass = nil;

+ (WBDataSource *)sharedInstance {
  static WBDataSource *sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[DataSourceSubclass alloc] init];
  });
  return sharedInstance;
}


+ (void)setDataSourceSubclass:(Class)dataSourceSubclass {
  DataSourceSubclass = dataSourceSubclass;
}

+ (WBUser *)currentUser {
  return [[[self class] sharedInstance] currentUser];
}

- (WBUser *)currentUser {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
  return nil;
}

+ (WBUser *)createUser {
 return [[[self class] sharedInstance] createUser];
}

- (WBUser *)createUser {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
  return nil;
}

- (void)saveUser:(WBUser *)user
         success:(void(^)(void))success
         failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)setUpWithLauchOptions:(NSDictionary *)launchOptions {
    [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

+ (WBPhoto *)createPhoto {
  return [[[self class] sharedInstance] createPhoto];
}

- (WBPhoto *)createPhoto {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
  return nil;
}

#pragma mark - Photos

- (NSInteger)photoLimit {
  if(_photoLimit == 0){
    return 10;
  }
  
  return _photoLimit;
}

- (void)uploadPhoto:(WBPhoto *)photo
            success:(void(^)(void))success
            failure:(void(^)(NSError *error))failure
           progress:(void(^)(int percentDone))progress {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)latestPhotos:(void(^)(NSArray *photos))success
             failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)latestPhotosWithOffset:(int)offset
                       success:(void(^)(NSArray *photos))success
                       failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)photosForUser:(WBUser *)wbUser
           withOffset:(int)offset
              success:(void(^)(NSArray *photos))success
              failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)likePhoto:(WBPhoto *)photo
         withUser:(WBUser *)user
          success:(void(^)(void))success
          failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)unlikePhoto:(WBPhoto *)photo
           withUser:(WBUser *)user
            success:(void(^)(void))success
            failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)isFollowed:(WBUser *)user
           success:(void(^)(BOOL isFollowed))success
           failure:(void(^)(NSError *error))failure {
    [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)fetchPhoto:(WBPhoto *)photo
           success:(void(^)(WBPhoto *fetchedPhoto))success
           failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)deletePhoto:(WBPhoto *)photo
            success:(void(^)(void))success
            failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

#pragma mark - Comments 

- (void)addComment:(NSString *)comment
           onPhoto:(WBPhoto *)photo
           success:(void(^)(void))success
           failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

#pragma mark - Follow

- (void)suggestedUsers:(void(^)(NSArray *users))success
               failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)toggleFollowForUser:(WBUser *)user
                    success:(void(^)(void))success
                    failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)followUsers:(NSArray *)wbUsers
            success:(void(^)(void))success
            failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)unFollowUsers:(NSArray *)wbUsers
              success:(void(^)(void))success
              failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

#pragma mark - Profile

- (void)numberOfPhotosForUser:(WBUser *)user
                      success:(void(^)(int numberOfPhotos))success
                      failure:(void(^)(NSError *error))failure {
    [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)numberOfFollowersForUser:(WBUser *)user
                         success:(void(^)(int numberOfFollowers))success
                         failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)numberOfFollowingsForUser:(WBUser *)user
                          success:(void(^)(int numberOfFollowings))success
                          failure:(void(^)(NSError *error))failure {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

#pragma mark - Activity feed

- (void)recentActivities:(void(^)(NSArray *activities))success
                 failure:(void(^)(NSError *error))failure {
    [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  [NSException raise:@"You should override in a WBDataSource subclass" format:nil];
}

@end
