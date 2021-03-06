//
//  WBPhotoTimelineSectionHeaderView.m
//  whiteboard
//
//  Created by prs-fueled on 9/9/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBPhotoTimelineSectionHeaderView.h"
#import "UIImageView+RoundedCorners.h"
#import "FormatterKit/TTTTimeIntervalFormatter.h"

@interface WBPhotoTimelineSectionHeaderView() <WBPhotoTimelineSectionHeaderButtonDelegate>
@property (nonatomic, weak) IBOutlet UILabel *displayNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet WBPhotoTimelineSectionHeaderButton *commentButton;
@end

@implementation WBPhotoTimelineSectionHeaderView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  [self setupView];
}

#pragma mark - Setup
- (void)setupView {
  // Defaults
  [self.profilePictureImageView roundedCornersWithRadius:3.f];
  
  // Like button
  [self setUpLikeButton];

  // Comment button
  [self setUpCommentButton];

  self.likeButton.hidden = YES;

  // Display name label
  self.displayNameLabel.textColor = [[WBTheme sharedTheme] sectionDisplayNameFontColor];
  self.displayNameLabel.font = [[WBTheme sharedTheme] sectionDisplayNameFont];
  
  // Date label
  self.dateLabel.font = [[WBTheme sharedTheme] sectionDateNameFont];
  self.dateLabel.textColor = [[WBTheme sharedTheme] sectionDateNameFontColor];
  
  UITapGestureRecognizer *reconizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wbPhotoTimelineSectionHeaderTap)];
  reconizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:reconizer];
  
}

- (void)setUpCommentButton {
  self.commentButton.numberLabel.font = [[WBTheme sharedTheme] sectionCommentFont];
  self.commentButton.numberLabel.textColor = [[WBTheme sharedTheme] sectionCommentFontColor];
  self.commentButton.hidden = YES;
  
  self.commentButton.normalImage = [self commentButtonImage];
  self.commentButton.highlightedImage = [self commentButtonImageHighlighted];
  self.commentButton.selectedImage = [self commentButtonImageSelected];
}

- (void)setUpLikeButton {
  // Like button
  if (self.isLiked) {
    self.likeButton.numberLabel.textColor = [[WBTheme sharedTheme] sectionLikeFontColor];
    self.likeButton.normalImage = [self likeButtonImageHighlighted];
    self.likeButton.highlightedImage = [self likeButtonImageHighlighted];
    self.likeButton.selectedImage = [self likeButtonImageSelected];
  } else {
    self.likeButton.normalImage = [self likeButtonImage];
    self.likeButton.highlightedImage = [self likeButtonImageHighlighted];
    self.likeButton.selectedImage = [self likeButtonImageSelected];
  }
  self.likeButton.numberLabel.font = [[WBTheme sharedTheme] sectionLikeFont];
}

#pragma mark - Config
- (UIImage *)likeButtonImage {
  return [[WBTheme sharedTheme] sectionLikeButtonNormalImage];
}

- (UIImage *)likeButtonImageHighlighted {
  return [[WBTheme sharedTheme] sectionLikeButtonSelectedImage];
}

- (UIImage *)likeButtonImageSelected {
  return [[WBTheme sharedTheme] sectionLikeButtonSelectedImage];
}

- (UIImage *)commentButtonImage {
  return [[WBTheme sharedTheme] sectionCommentButtonNormalImage];
}

- (UIImage *)commentButtonImageHighlighted {
  return [[WBTheme sharedTheme] sectionCommentButtonNormalImage];
}

- (UIImage *)commentButtonImageSelected {
  return [[WBTheme sharedTheme] sectionCommentButtonNormalImage];
}

- (UIFont *)displayNameFont {
  return [[WBTheme sharedTheme] sectionDisplayNameFont];
}

#pragma mark - Accessors
- (WBPhotoTimelineSectionHeaderButton *)likeButton {
  _likeButton.delegate = self;
  
  return _likeButton;
}

- (WBPhotoTimelineSectionHeaderButton *)commentButton {
  _commentButton.delegate = self;
  
  return _commentButton;
}

#pragma mark - Setters
- (void)setAuthor:(WBUser *)author {
  _author = author;
  self.displayNameLabel.text = _author.displayName;
}

- (void)setDate:(NSDate *)date {
  _date = date;
  
  TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
  self.dateLabel.text = [timeIntervalFormatter stringForTimeIntervalFromDate:[NSDate date] toDate:date];
}

- (void)setNumberOfLikes:(NSNumber *)numberOfLikes {
  _numberOfLikes = numberOfLikes;
  
  self.likeButton.hidden = NO;
  self.likeButton.numberLabel.text = [NSString stringWithFormat:@"%d", numberOfLikes.intValue];
  self.displayNameLabel.frame = CGRectMake(48, 7, 144, 21);
}

- (void)setNumberOfComments:(NSNumber *)numberOfComments {
  _numberOfComments = numberOfComments;

  self.commentButton.hidden = NO;
  self.commentButton.numberLabel.text = [NSString stringWithFormat:@"%d", numberOfComments.intValue];
}

- (void)setIsLiked:(BOOL)isLiked {
  _isLiked = isLiked;
  [self setUpLikeButton];
}

#pragma mark - IBActions
- (void)wbPhotoTimelineSectionHeaderTap {
  if ([_delegate respondsToSelector:@selector(sectionHeaderPressed:)]) {
    [self.delegate sectionHeaderPressed:_author];
  }
}

- (void)wbPhotoTimelineSectionHeaderButtonPressed:(WBPhotoTimelineSectionHeaderButton *)button {
  if(button == self.likeButton){
    if([self.delegate respondsToSelector:@selector(sectionHeaderLikesButtonPressed:)]){
      [self.delegate sectionHeaderLikesButtonPressed:self];
    }
  }else if(button == self.commentButton){
    if([self.delegate respondsToSelector:@selector(sectionHeaderCommentsButtonPressed:)]){
      [self.delegate sectionHeaderCommentsButtonPressed:self];
    }
  }
}

@end
