//
// MSViewController.m
//
// Created by Maksym Shcheglov on 2014-01-23.
//
// The MIT License (MIT)
// Copyright (c) 2015 Maksym Shcheglov
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "MSViewController.h"

@interface MSViewController () <UIPopoverPresentationControllerDelegate, MSColorSelectionViewControllerDelegate>

@end

@implementation MSViewController

- (void)viewDidLoad {
    [self.button setImage:[UIImage imageNamed:@"colorpicker"] forState:UIControlStateNormal];
    self.button.layer.cornerRadius = 45 / 2;
    self.button.layer.borderWidth = 1;
    self.button.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.button.clipsToBounds = YES;
}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"showPopover"]) {
//        UINavigationController *destNav = segue.destinationViewController;
//        destNav.preferredContentSize = [[destNav visibleViewController].view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        destNav.popoverPresentationController.delegate = self;
//        MSColorSelectionViewController *colorSelectionController = (MSColorSelectionViewController *)destNav.visibleViewController;
//        colorSelectionController.delegate = self;
//        colorSelectionController.color = self.view.backgroundColor;
//
//        if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
//            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", ) style:UIBarButtonItemStyleDone target:self action:@selector(ms_dismissViewController:)];
//            colorSelectionController.navigationItem.rightBarButtonItem = doneBtn;
//        }
//    }
//}

- (IBAction)onButtonTap:(UIButton *)button
{
    MSColorSelectionViewController *colorSelectionController = [[MSColorSelectionViewController alloc] init];
//    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:colorSelectionController];

    colorSelectionController.modalPresentationStyle = UIModalPresentationPopover;
    colorSelectionController.popoverPresentationController.delegate = self;
    colorSelectionController.popoverPresentationController.sourceView = button;
    colorSelectionController.popoverPresentationController.sourceRect = button.bounds;
    //colorSelectionController.preferredContentSize = [colorSelectionController.view systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    colorSelectionController.preferredContentSize = CGSizeMake(233, 233);

    colorSelectionController.delegate = self;
    colorSelectionController.color = self.view.backgroundColor;
    
    [self.button setImage:nil forState:UIControlStateNormal];
    self.button.backgroundColor = self.view.backgroundColor;

//    if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact) {
//        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", ) style:UIBarButtonItemStyleDone target:self action:@selector(ms_dismissViewController:)];
//        colorSelectionController.navigationItem.rightBarButtonItem = doneBtn;
//    }

    [self presentViewController:colorSelectionController animated:YES completion:nil];
}

#pragma mark - MSColorViewDelegate

- (void)colorViewController:(MSColorSelectionViewController *)colorViewCntroller didChangeColorContinious:(UIColor *)color
{
    self.button.backgroundColor = color;
    //NSLog(@"didChangeColorContinious");
}

- (void)colorViewController:(MSColorSelectionViewController *)colorViewCntroller didChangeColorFinal:(UIColor *)color
{
    self.button.backgroundColor = color;
    self.view.backgroundColor = color;
    //NSLog(@"didChangeColorFinal");
}

- (void)colorViewControllerDidFinish:(MSColorSelectionViewController *)colorViewCntroller {
    [self.button setImage:[UIImage imageNamed:@"colorpicker"] forState:UIControlStateNormal];
}


#pragma mark - UIAdaptivePresentationControllerDelegate methods

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller
{
    return UIModalPresentationNone;
}

//#pragma mark - Private
//
//- (void)ms_dismissViewController:(id)sender
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

@end
