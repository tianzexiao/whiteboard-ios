//
//  WBPhoto.h
//  whiteboard
//
//  Created by Sacha Durand Saint Omer on 9/13/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBUser.h"

@interface WBPhoto : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) WBUser *author;

//@property (nonatomic, strong) NSURL *url;

//
//imageURL : NSURL
//thumbnailURL : NSURL
//user : id<User>
//createdAt : NSDate
//updatedAt : NSDate
//text: NSString
//usersWhoLiked : NSArray

@end