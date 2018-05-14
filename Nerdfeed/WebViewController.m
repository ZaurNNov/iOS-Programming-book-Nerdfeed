//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Zaur Giyasov on 14/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic) UIWebView *webView;
@property (nonatomic) UIToolbar *toolBar;
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
        _toolBar = [[UIToolbar alloc] init];
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
    
    CGRect frame = self.view.frame;
    CGRect naviFrame = self.navigationController.navigationBar.frame;
    CGRect topFrame = CGRectMake(0, naviFrame.size.height + 20, frame.size.width, 50);
    
    self.toolBar.frame = topFrame;
    UIBarButtonItem *emptiLarge = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.back.enabled = NO;
    self.forward.enabled = NO;
    
    [self.toolBar setItems:@[self.back, emptiLarge, self.forward]];
    
    CGRect webViewFrame = CGRectMake(0, 70 + naviFrame.size.height, frame.size.width, frame.size.height - 70 - naviFrame.size.height);
    self.webView.frame = webViewFrame;
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.webView];
}

// WebDelegate
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.back setEnabled:[webView canGoBack]];
    [self.forward setEnabled:[webView canGoForward]];
}

-(void)setURLz:(NSURL *)URLz {
    _URLz = URLz;
    if (_URLz) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URLz];
        //[(UIWebView *)self.view loadRequest:req];
        [self.webView loadRequest:req];
    }
}



@end
