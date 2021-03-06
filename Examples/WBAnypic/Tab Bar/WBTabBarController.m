//
//  WBTabBarController.m
//  whiteboard
//
//  Created by lnf-fueled on 9/13/13.
//  Copyright (c) 2013 Fueled. All rights reserved.
//

#import "WBTabBarController.h"
#import "Whiteboard.h"

@interface WBTabBarController ()

@end

@implementation WBTabBarController

static int kCameraIndex = 0;
static int kLibraryIndex = 1;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setUpTabBarBackground];
  [self setUpHomeViewController];
  [self setUpEmptyMiddleViewController];
  [self setUpActivityViewController];
  
  self.viewControllers = @[self.homeNavigationController, self.emptyMiddleNavigationController, self.activityNavigationController];
  
}

- (void)setUpTabBarBackground {
  [[self tabBar] setBackgroundImage:[[WBTheme sharedTheme] tabBarBackgroundImage]];
  [[self tabBar] setSelectionIndicatorImage:[[WBTheme sharedTheme] tabBarSelectedItemImage]];
}

- (void)setUpHomeViewController {
  MainFeedViewController *homeViewController = [[MainFeedViewController alloc] initWithNibName:NSStringFromClass([MainFeedViewController class]) bundle:nil];
  UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"HomeTabTitle", @"Home") image:[[WBTheme sharedTheme] tabBarHomeButtonNormalImage] selectedImage:[[WBTheme sharedTheme] tabBarHomeButtonSelectedImage]];
  
  [homeTabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: [[WBTheme sharedTheme] tabBarNormalFontColor] } forState:UIControlStateNormal];
  [homeTabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: [[WBTheme sharedTheme] tabBarSelectedFontColor] } forState:UIControlStateSelected];
  self.homeNavigationController = [[WBNavigationController alloc] initWithRootViewController:homeViewController];
  [self.homeNavigationController setTabBarItem:homeTabBarItem];
}

- (void)setUpEmptyMiddleViewController {
  self.emptyMiddleNavigationController = [[WBNavigationController alloc] init];
  UITabBarItem *emptyItem = [[UITabBarItem alloc] init];
  emptyItem.enabled = NO;
  [self.emptyMiddleNavigationController setTabBarItem:emptyItem];
}

- (void)setUpActivityViewController {
  ActivityViewController *activityViewController = [[ActivityViewController alloc] init];
  UITabBarItem *activityTabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"ActivityTabTitle", @"Activity") image:[[WBTheme sharedTheme] tabBarActivityButtonNormalImage] selectedImage:[[WBTheme sharedTheme] tabBarActivityButtonSelectedImage]];
  
  [activityTabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: [[WBTheme sharedTheme] tabBarNormalFontColor] } forState:UIControlStateNormal];
  [activityTabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: [[WBTheme sharedTheme] tabBarSelectedFontColor] } forState:UIControlStateSelected];
  self.activityNavigationController = [[WBNavigationController alloc] initWithRootViewController:activityViewController];
  [self.activityNavigationController setTabBarItem:activityTabBarItem];
}

#pragma mark - UITabBarController

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
  [super setViewControllers:viewControllers animated:animated];
  
  UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
  cameraButton.frame = CGRectMake( 94.0f, 0.0f, 131.0f, self.tabBar.bounds.size.height);
  [cameraButton setImage:[[WBTheme sharedTheme] tabBarCameraButtonNormalImage] forState:UIControlStateNormal];
  [cameraButton setImage:[[WBTheme sharedTheme] tabBarCameraButtonSelectedImage] forState:UIControlStateHighlighted];
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

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
  WBPhoto *wbPhoto = [WBDataSource createPhoto];
  wbPhoto.image = [self resizeImageWithImage:originalImage];
  wbPhoto.author = [WBDataSource currentUser];
  [[WBDataSource sharedInstance] uploadPhoto:wbPhoto
    success:^{
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Suceeeded" message:@"Photo upload succeeded" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [alert show];
  } failure:^(NSError *error) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failed" message:[error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
  } progress:^(int percentDone) {
   
  }];
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == kCameraIndex) {
    [self shouldStartCameraController];
  } else if (buttonIndex == kLibraryIndex) {
    [self shouldStartPhotoLibraryPickerController];
  }
}

#pragma mark - ()

-(UIImage*)resizeImageWithImage:(UIImage*)image {
  CGSize size;
  if (image.imageOrientation == UIImageOrientationUp || image.imageOrientation == UIImageOrientationDown){
    size = CGSizeMake(800, 600);
  }
  else {
    size = CGSizeMake(600, 800);
  }
  UIGraphicsBeginImageContext(size);
  [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  UIImage *resizeImage = [UIImage imageWithData:UIImageJPEGRepresentation(newImage, 0.8)];
  
  return resizeImage;
}

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
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:NSLocalizedString(@"TakePhoto", @"Take Photo"), NSLocalizedString(@"ChoosePhoto", @"Choose Photo"), nil];
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
  
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
      cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
      cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
  } else {
    return NO;
  }
  
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
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
    cameraUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  } else if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
    cameraUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
  } else {
    return NO;
  }
  
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
