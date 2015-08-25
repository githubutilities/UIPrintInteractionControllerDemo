//
//  ViewController.m
//  RemoteController
//
//  Created by will on 8/25/15.
//  Copyright © 2015 githubutilities. All rights reserved.
//

#import "ViewController.h"
#import "HelloPrintPageRenderer.h"

@interface ViewController () <UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.view.backgroundColor = [UIColor colorWithRed: 244/255.0 green: 244/255.0 blue: 244/255.0 alpha: 1.0];
    self.view.backgroundColor = [UIColor colorWithRed: 244/255.0 green: 244/255.0 blue: 244/255.0 alpha: 1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)click:(id)sender {
    
    [self.navigationController setDelegate:self];
    UIPrintInteractionController *printCtl = [UIPrintInteractionController sharedPrintController];
    printCtl.delegate = self;
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    printInfo.jobName = @"desktop";
    printInfo.duplex = UIPrintInfoDuplexLongEdge;
    printInfo.outputType = UIPrintInfoOutputGeneral;
    
    printCtl.printInfo = printInfo;
    printCtl.showsNumberOfCopies = YES;
    printCtl.showsPageRange = YES;
    printCtl.showsPaperSelectionForLoadedPapers = YES;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"hello" ofType:@"pdf"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    if ([UIPrintInteractionController canPrintData:data]) {
//        printCtl.printingItem = data;
        printCtl.printPageRenderer = [[HelloPrintPageRenderer alloc] init];
        
        [printCtl presentAnimated:YES completionHandler:nil];
    }
}

#pragma mark - UIPrintInteractionControllerDelegate

- (UIViewController *)printInteractionControllerParentViewController:(UIPrintInteractionController *)printInteractionController {
    return self.navigationController;
}

#pragma mark - NavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // UIPrintInteractionController internal ViewController api --UIPrintPanelTableViewController
    if ([viewController isKindOfClass:NSClassFromString(@"UIPrintPanelTableViewController")]) {
        [viewController.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

@end
