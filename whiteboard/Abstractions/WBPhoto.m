//
//  WBPhoto.m
//  whiteboard
//
//  Created by Sacha Durand Saint Omer on 9/13/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBPhoto.h"

@implementation WBPhoto

- (NSString *)description {
  NSMutableString *description = [@"" mutableCopy];
  [description appendFormat:@"WBPhoto "];
  [description appendFormat:@"User : %@", self.author]; // ad author desc.
  [description appendFormat:@"Created at : %@", self.createdAt];
  return description;
}

@end
