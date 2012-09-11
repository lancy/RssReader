//
//  FeedListViewController.m
//  RssReader
//
//  Created by Lancy on 11/9/12.
//  Copyright (c) 2012 Lancy. All rights reserved.
//

#import "FeedListViewController.h"
#import "MWFeedParser.h"

@interface FeedListViewController () <MWFeedParserDelegate>
@property (nonatomic, strong) MWFeedParser *feedParser;
@property (nonatomic, strong) NSMutableArray *feedItemArray;

@end

@implementation FeedListViewController

- (NSMutableArray *)feedItemArray
{
    if (!_feedItemArray) {
        _feedItemArray = [NSMutableArray array];
    }
    return _feedItemArray;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initParser];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.feedParser = nil;
    self.feedItemArray = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - parser methods
- (void)refresh
{
    [self.feedParser stopParsing];
    [self.feedItemArray removeAllObjects];
    [self.feedParser parse];
}

- (void)initParser
{
    NSURL *feedUrl = [NSURL URLWithString:@"feed://www.applesysu.com/rss"];
    self.feedParser = [[MWFeedParser alloc]initWithFeedURL:feedUrl];
    [self.feedParser setDelegate:self];
    [self.feedParser setFeedParseType:ParseTypeFull];
    [self.feedParser setConnectionType:ConnectionTypeAsynchronously];
    [self.feedParser parse];
}
- (void)feedParserDidStart:(MWFeedParser *)parser
{
    NSLog(@"FeedParser: %@ did start.", parser);
    
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedInfo:(MWFeedInfo *)info
{
    NSLog(@"FeedParser: %@ did Parse Feed Info: %@", parser, info);
    self.title = info.title;
}
- (void)feedParser:(MWFeedParser *)parser didParseFeedItem:(MWFeedItem *)item
{
    NSLog(@"FeedParser: %@ did parse feed item: %@", parser, item);
    [self.feedItemArray addObject:item];
}
- (void)feedParserDidFinish:(MWFeedParser *)parser
{
    NSLog(@"FeedParser: %@ did finish", parser);
    [self.tableView reloadData];
    
}
- (void)feedParser:(MWFeedParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"FeedParser: %@ did fail with error: %@",parser, error);
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSLog(@"%@", self.feedItemArray);

    return [self.feedItemArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    // Configure the cell...
    MWFeedItem *item = [self.feedItemArray objectAtIndex:indexPath.row];
    [cell.textLabel setText:[item title]];
    NSLog(@"%@", item);
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
