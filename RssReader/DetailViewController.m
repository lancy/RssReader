//
//  DetailViewController.m
//  RssReader
//
//  Created by Lancy on 11/9/12.
//  Copyright (c) 2012 Lancy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;
@end

@implementation DetailViewController
@synthesize contentWebView;

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
    
    [self loadFeedItemContent];
}

- (void)viewDidUnload
{
    [self setContentWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.item = nil;
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - load feed methods

- (void)loadFeedItemContent
{
    NSString *htmlString = self.item.summary;
    NSError *error;
    NSString *fullPath = [[NSBundle mainBundle] pathForResource:@"Clearness" ofType:@"css"];
    NSString *cssString = [NSString stringWithContentsOfFile:fullPath encoding:NSUTF8StringEncoding error:&error];
    htmlString = [cssString stringByAppendingString:htmlString];
    NSLog(@"after = %@", htmlString);
    
    [self.contentWebView loadHTMLString:htmlString baseURL:[NSURL URLWithString:self.item.link]];
}

@end
