//
//  WBPhoto+PFObject.h
//  whiteboard
//
//  Created by Lauren Frazier | Fueled on 9/23/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBPhoto.h"
#import <Parse/Parse.h>

@interface WBPhoto (PFObject)

- (PFObject *)PFObject;

@end