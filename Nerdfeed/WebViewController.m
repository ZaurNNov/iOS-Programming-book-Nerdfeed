//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Zaur Giyasov on 14/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate> 

//@property (nonatomic) UIToolbar *toolBar;
@property (nonatomic) UIBarButtonItem *back;
@property (nonatomic) UIBarButtonItem *forward;

-(void)goForward:(id)sender;
-(void)goBack:(id)sender;

@end

@implementation WebViewController

-(instancetype) init {
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
        [_webView sizeToFit];
        //_toolBar = [[UIToolbar alloc] init];
        _back = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(goBack:)];
        _forward = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(goForward:)];
    }
    return self;
}

-(void)goForward:(id)sender {
    NSLog(@"goForward");
    [self.webView goForward];
}

-(void)goBack:(id)sender {
    NSLog(@"goBackwardNow");
    [self.webView goBack];
}


-(void)loadView {
    CGRect mainFrame = [[UIScreen mainScreen] bounds];
    self.view = [[UIView alloc] initWithFrame:mainFrame];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *emptiLarge = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.back.enabled = NO;
    self.forward.enabled = NO;

    if (self.navigationController.navigationBar) {
        CGRect naviFrame = self.navigationController.navigationBar.frame;
        self.navigationController.navigationBar.topItem.rightBarButtonItem = self.forward;
        self.navigationController.navigationBar.topItem.leftBarButtonItem = self.back;

        CGRect webViewFrame = CGRectMake(0, 0, naviFrame.size.width, self.view.frame.size.height);
        self.webView.frame = webViewFrame;
    } else {
        self.webView.frame = self.view.frame;
    }
    
    //self.webView.frame = self.view.frame;
    
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    [self.view addSubview:self.webView];
}

// WebDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.back setEnabled:[webView canGoBack]];
    [self.forward setEnabled:[webView canGoForward]];
}

-(void)setUrl:(NSURL *)URLz {
    _url = URLz;
    if (_url) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_url];
        //[(UIWebView *)self.view loadRequest:req];
        [self.webView loadRequest:req];
    }
}

// SplitDelegate
-(void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc {
    // if barButton title nil?
    barButtonItem.title = @"New Title";
    self.navigationItem.leftBarButtonItem = barButtonItem;
}

-(void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    // remove barButton item from NC
    if (barButtonItem == self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = nil;
    }
}



@end
