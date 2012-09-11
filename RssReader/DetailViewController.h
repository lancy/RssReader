//
//  DetailViewController.h
//  RssReader
//
//  Created by Lancy on 11/9/12.
//  Copyright (c) 2012 Lancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MWFeedParser.h"


@interface DetailViewController : UIViewController

@property (nonatomic, strong) MWFeedItem *item;

@end
