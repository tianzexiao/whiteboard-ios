//
//  WBTheme.m
//  whiteboard
//
//  Created by lnf-fueled on 9/12/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBTheme.h"
#import "UIColor+Hex.h"

@interface WBTheme()

/**
	Dictionary to store the contents of the plist so the file contents only need to be loaded once.
 */
@property (nonatomic, strong) NSDictionary *themeDict;


@end

@implementation WBTheme

+ (WBTheme *)sharedTheme {
  static WBTheme *sharedTheme = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedTheme = [[self alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"WBTheme" ofType:@"plist"];
    sharedTheme.themeDict = [NSDictionary dictionaryWithContentsOfFile:path];
  });
  return sharedTheme;
}

- (UIImage *)backgroundImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"backgroundImage"]];
}

- (UIImage *)sectionLikeButtonNormalImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"SECTION_likeButtonImage-Normal"]];
}

- (UIImage *)sectionLikeButtonSelectedImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"SECTION_likeButtonImage-Selected"]];
}

- (UIImage *)sectionCommentButtonNormalImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"SECTION_commentButtonImage-Normal"]];
}

- (UIFont *)sectionDisplayNameFont {
  return [UIFont fontWithName:[self.themeDict objectForKey:@"SECTION_displayNameFont"] size:[[self.themeDict objectForKey:@"SECTION_displayNameFontSize"] floatValue]];
}

- (UIColor *)sectionDisplayNameFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"SECTION_displayNameFontColor"]];
}

- (UIFont *)sectionDateNameFont {
  return [UIFont fontWithName:[self.themeDict objectForKey:@"SECTION_dateFont"] size:[[self.themeDict objectForKey:@"SECTION_dateFontSize"] floatValue]];
}

- (UIColor *)sectionDateNameFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"SECTION_dateFontColor"]];
}

- (UIFont *)sectionLikeFont {
  return [UIFont fontWithName:[self.themeDict objectForKey:@"SECTION_likeFont"] size:[[self.themeDict objectForKey:@"SECTION_likeFontSize"] floatValue]];
}

- (UIColor *)sectionLikeFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"SECTION_likeFontColor"]];
}
- (UIColor *)sectionLikeHighlightedFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"SECTION_likeHighlightedFontColor"]];
}

- (UIFont *)sectionCommentFont {
  return [UIFont fontWithName:[self.themeDict objectForKey:@"SECTION_commentFont"] size:[[self.themeDict objectForKey:@"SECTION_commentFontSize"] floatValue]];
}

- (UIColor *)sectionCommentFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"SECTION_commentFontColor"]];
}
  
- (UIImage *)feedLoadMoreSeperatorTopImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"FEED_loadMoreSeperatorTopImage"]];
}

- (UIImage *)feedLoadMoreImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"FEED_loadMoreImage"]];

}

- (UIImage *)tabBarHomeButtonNormalImage {
  UIImage *image = [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_homeButtonImage-Normal"]];
  return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)tabBarHomeButtonSelectedImage {
  UIImage *image = [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_homeButtonImage-Selected"]];
  return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)tabBarActivityButtonNormalImage {
  UIImage *image = [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_activityButtonImage-Normal"]];
  return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)tabBarActivityButtonSelectedImage {
  UIImage *image = [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_activityButtonImage-Selected"]];
  return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *)tabBarBackgroundImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_backgroundImage"]];
}

- (UIImage *)tabBarSelectedItemImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_selectedItemImage"]];
}

- (UIImage *)tabBarCameraButtonNormalImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_cameraButtonImage-Normal"]];
}

- (UIImage *)tabBarCameraButtonSelectedImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"TABBAR_cameraButtonImage-Selected"]];
}

- (UIColor *)tabBarNormalFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"TABBAR_textColor-Normal"]];
}

- (UIColor *)tabBarSelectedFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"TABBAR_textColor-Selected"]];
}

- (UIImage *)navBarBackgroundImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"NAVBAR_backgroundImage"]];
}

- (UIImage *)navBarSettingsButtonBackgroundImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"NAVBAR_settingsButtonBackgroundImage"]];
}

- (UIImage *)navBarSettingsButtonImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"NAVBAR_settingsButtonImage"]];
}

- (UIImage *)navBarSettingsButtonHighlightedImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"NAVBAR_settingsButtonHighlightedImage"]];
}

- (UIFont *)navBarTitleFont {
  return [UIFont fontWithName:[self.themeDict objectForKey:@"NAVBAR_titleFont"]
                         size:[[self.themeDict objectForKey:@"NAVBAR_titleFontSize"] floatValue]];
}

- (UIColor *)navBarTitleFontColor {
  return [UIColor colorWithHex:[self.themeDict objectForKey:@"NAVBAR_titleFontColor"]];
}

- (UIImage *)feedPlaceholderImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"FEED_placeholderImage"]];
}

- (UIImage *)findFriendsCellBackgroundImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"FINDFRIENDS_cellBackgroundImage"]];
}

- (UIFont *)findFriendsNameFont {
  return [UIFont fontWithName:self.themeDict[@"FINDFRIENDS_nameFont"]
                         size:[self.themeDict[@"FINDFRIENDS_nameFontSize"] floatValue]];
}

- (UIColor *)findFriendsNameFontColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_nameFontColor"]];
}

- (UIColor *)findFriendsNameShadowColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_nameShadowColor"]];
}

- (UIFont *)findFriendsNumPhotosFont {
  return [UIFont fontWithName:self.themeDict[@"FINDFRIENDS_numPhotosFont"]
                         size:[self.themeDict[@"FINDFRIENDS_numPhotosFontSize"] floatValue]];
}

- (UIColor *)findFriendsNumPhotosFontColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_numPhotosFontColor"]];
}

- (UIColor *)findFriendsNumPhotosShadowColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_numPhotosShadowColor"]
                      andAlpha:[self.themeDict[@"FINDFRIENDS_numPhotosShadowAlpha"] floatValue]];
}

- (UIFont *)findFriendsFollowButtonFont {
  return [UIFont fontWithName:self.themeDict[@"FINDFRIENDS_followButtonFont"]
                         size:[self.themeDict[@"FINDFRIENDS_followButtonFontSize"] floatValue]];
}

- (UIColor *)findFriendsFollowButtonNormalFontColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_followButtonNormalFontColor"]];
}

- (UIColor *)findFriendsFollowButtonSelectedFontColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_followButtonSelectedFontColor"]];
}

- (UIColor *)findFriendsFollowButtonNormalShadowColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_followButtonNormalShadowColor"]];
}

- (UIColor *)findFriendsFollowButtonSelectedShadowColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_followButtonSelectedShadowColor"]];
}

- (UIImage *)findFriendsFollowButtonNormalBackgroundImage {
  return [UIImage imageNamed:self.themeDict[@"FINDFRIENDS_followButtonNormalBackgroundImage"]];
}

- (UIImage *)findFriendsFollowButtonSelectedBackgroundImage {
  return [UIImage imageNamed:self.themeDict[@"FINDFRIENDS_followButtonSelectedBackgroundImage"]];
}

- (UIImage *)findFriendsFollowButtonSelectedImage {
  return [UIImage imageNamed:self.themeDict[@"FINDFRIENDS_followButtonSelectedImage"]];
}

- (UIFont *)findFriendsInviteFriendsFont {
  return [UIFont fontWithName:self.themeDict[@"FINDFRIENDS_inviteFriendsFont"] size:[self.themeDict[@"FINDFRIENDS_inviteFriendsFontSize"] floatValue]];
}

- (UIColor *)findFriendsInviteFriendsFontColor {
  return [UIColor colorWithHex:self.themeDict[@"FINDFRIENDS_inviteFriendsFontColor"]];
}

- (UIImage *)findFriendsTitleImage {
  return [UIImage imageNamed:self.themeDict[@"FINDFRIENDS_titleImage"]];
}

- (UIImage *)strokeProfilePictureImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"profilePictureStroke"]];
}

- (UIImage *)pictoPhotoImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"pictoPhotoImage"]];
}

- (UIImage *)pictoFollowImage {
  return [UIImage imageNamed:[self.themeDict objectForKey:@"pictoFollowImage"]];
}

#pragma mark - Details
- (UIImage *)detailsTextfieldBackgroundImage {
  return [UIImage imageNamed:self.themeDict[@"DETAILS_textfieldBackgroundImage"]];
}

- (UIImage *)detailsAddCommentIconImage {
  return [UIImage imageNamed:self.themeDict[@"DETAILS_addCommentIconImage"]];
}

- (UIImage *)detailsCommentsSeperatorImage {
  return [UIImage imageNamed:self.themeDict[@"DETAILS_commentsSeperatorImage"]];
}

- (UIFont *)detailsCommentsNameFont {
  return [UIFont fontWithName:self.themeDict[@"DETAILS_commentNameFont"]
                         size:[self.themeDict[@"DETAILS_commentNameFontSize"] floatValue]];
}

- (UIColor *)detailsCommentsNameFontColor {
  return [UIColor colorWithHex:self.themeDict[@"DETAILS_commentNameFontColor"]];
}

- (UIFont *)detailsCommentsMessageFont {
  return [UIFont fontWithName:self.themeDict[@"DETAILS_commentMessageFont"]
                         size:[self.themeDict[@"DETAILS_commentMessageFontSize"] floatValue]];
}

- (UIColor *)detailsCommentsMessageFontColor {
  return [UIColor colorWithHex:self.themeDict[@"DETAILS_commentMessageFontColor"]];
}

- (UIFont *)detailsCommentsDateFont {
  return [UIFont fontWithName:self.themeDict[@"DETAILS_commentDateFont"]
                         size:[self.themeDict[@"DETAILS_commentDateFontSize"] floatValue]];
}

- (UIColor *)detailsCommentsDateFontColor {
  return [UIColor colorWithHex:self.themeDict[@"DETAILS_commentDateFontColor"]];
}

@end