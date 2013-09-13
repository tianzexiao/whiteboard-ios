//
//  WBTabBarController.m
//  whiteboard
//
//  Created by lnf-fueled on 9/13/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBTabBarController.h"

@interface WBTabBarController ()

@end

@implementation WBTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  [self setUpTabBarBackground];
  [self setUpHomeViewController];
  [self setUpActivityViewController];
  
  self.viewControllers = @[self.homeNavigationController, self.activityNavigationController];
  
}

- (void)setUpTabBarBackground {
  [[self tabBar] setBackgroundImage:[UIImage imageNamed:@"backgroundTabBar.png"]];
  [[self tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"backgroundTabBarItemSelected.png"]];
}

- (void)setUpHomeViewController {
  MainFeedViewController *homeViewController = [[MainFeedViewController alloc] initWithNibName:NSStringFromClass([MainFeedViewController class]) bundle:nil];
  UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
  [homeTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"iconHomeSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"iconHome.png"]];
  [homeTabBarItem setTitleTextAttributes: @{ UITextAttributeTextColor: [UIColor colorWithRed:86.0f/255.0f green:55.0f/255.0f blue:42.0f/255.0f alpha:1.0f] } forState:UIControlStateNormal];
  [homeTabBarItem setTitleTextAttributes: @{ UITextAttributeTextColor: [UIColor colorWithRed:129.0f/255.0f green:99.0f/255.0f blue:69.0f/255.0f alpha:1.0f] } forState:UIControlStateSelected];
  self.homeNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
  [self.homeNavigationController setTabBarItem:homeTabBarItem];
}

- (void)setUpActivityViewController {
#warning Change this to an activity view controller when it is implemented
  UIViewController *activityViewController = [[UIViewController alloc] init];
  UITabBarItem *activityTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Activity" image:nil tag:0];
  [activityTabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"iconTimelineSelected.png"] withFinishedUnselectedImage:[UIImage imageNamed:@"iconTimeline.png"]];
  [activityTabBarItem setTitleTextAttributes: @{ UITextAttributeTextColor: [UIColor colorWithRed:86.0f/255.0f green:55.0f/255.0f blue:42.0f/255.0f alpha:1.0f] } forState:UIControlStateNormal];
  [activityTabBarItem setTitleTextAttributes: @{ UITextAttributeTextColor: [UIColor colorWithRed:129.0f/255.0f green:99.0f/255.0f blue:69.0f/255.0f alpha:1.0f] } forState:UIControlStateSelected];
  self.activityNavigationController = [[UINavigationController alloc] initWithRootViewController:activityViewController];
  [self.activityNavigationController setTabBarItem:activityTabBarItem];
}

#pragma mark - UITabBarController

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
  [super setViewControllers:viewControllers animated:animated];
  
  UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
  cameraButton.frame = CGRectMake( 94.0f, 0.0f, 131.0f, self.tabBar.bounds.size.height);
  [cameraButton setImage:[UIImage imageNamed:@"buttonCamera.png"] forState:UIControlStateNormal];
  [cameraButton setImage:[UIImage imageNamed:@"buttonCameraSelected.png"] forState:UIControlStateHighlighted];
  [cameraButton addTarget:self action:@selector(photoCaptureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.tabBar addSubview:cameraButton];
  
  UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
  [swipeUpGestureRecognizer setDirection:UISwipeGestureRecognizerDirectionUp];
  [swipeUpGestureRecognizer setNumberOfTouchesRequired:1];
  [cameraButton addGestureRecognizer:swipeUpGestureRecognizer];
}


#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ()

- (BOOL)shouldPresentPhotoCaptureController {
  BOOL presentedPhotoCaptureController = [self shouldStartCameraController];
  
  if (!presentedPhotoCaptureController) {
    presentedPhotoCaptureController = [self shouldStartPhotoLibraryPickerController];
  }
  
  return presentedPhotoCaptureController;
}

- (void)photoCaptureButtonAction:(id)sender {
  BOOL cameraDeviceAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
  BOOL photoLibraryAvailable = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
  
  if (cameraDeviceAvailable && photoLibraryAvailable) {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose Photo", nil];
    [actionSheet showFromTabBar:self.tabBar];
  } else {
    // if we don't have at least two options, we automatically show whichever is available (camera or roll)
    [self shouldPresentPhotoCaptureController];
  }
}


- (BOOL)shouldStartCameraController {
  
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
    return NO;
  }
  
  UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
  
//  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
//      && [[UIImagePickerController availableMediaTypesForSourceType:
//           UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
//    
//    cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
//    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
//      cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
//    } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
//      cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//    }
//    
//  } else {
//    return NO;
//  }
  
  cameraUI.allowsEditing = YES;
  cameraUI.showsCameraControls = YES;
  cameraUI.delegate = self;
  
  [self presentViewController:cameraUI animated:YES completion:nil];
  
  return YES;
}


- (BOOL)shouldStartPhotoLibraryPickerController {
  if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] == NO
       && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)) {
    return NO;
  }
  
  UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
//  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]
//      && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary] containsObject:(NSString *)kUTTypeImage]) {
//    
//    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
//    
//  } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]
//             && [[UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum] containsObject:(NSString *)kUTTypeImage]) {
//    
//    cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
//    
//  } else {
//    return NO;
//  }
  
  cameraUI.allowsEditing = YES;
  cameraUI.delegate = self;
  
  [self presentViewController:cameraUI animated:YES completion:nil];
  
  return YES;
}

- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizer {
  [self shouldPresentPhotoCaptureController];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
