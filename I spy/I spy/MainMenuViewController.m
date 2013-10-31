//
//  MainMenuViewController.m
//  I spy
//
//  Created by Julian Profas on 10/22/13.
//  Copyright (c) 2013 hhs. All rights reserved.
//

#import "MainMenuViewController.h"
#import "SinglePlayerViewController.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize takePictureButton;
@synthesize capturedImage;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Image Picker Controller Delegate Methods

-(void)ImagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    
    capturedImage = [self imageWithImage:chosenImage scaledToSize:CGSizeMake(320, 480)];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self performSegueWithIdentifier:@"gameSegue" sender:self];
    }];
}

#pragma mark - Action Methods

- (IBAction)takePicture:(id)sender {
    UIImage *chosenImage =  [self imageWithImage:[UIImage imageNamed:@"holi-colors_hd.jpg"] scaledToSize:CGSizeMake(320, 480)];// info[UIImagePickerControllerOriginalImage];//info[UIImagePickerControllerOriginalImage];
    capturedImage = chosenImage;
    [self performSegueWithIdentifier:@"gameSegue" sender:self];
    //[self startCameraControllerFromViewController: self usingDelegate: self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = delegate;
    
    [controller presentViewController:cameraUI animated:YES completion:^{ }];
    
    return YES;
}

- (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - Segue Methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"gameSegue"]) {
        SinglePlayerViewController *destinationViewController = segue.destinationViewController;
        destinationViewController.capturedImage = capturedImage;
    }
}

@end
