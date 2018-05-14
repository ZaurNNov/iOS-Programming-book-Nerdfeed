//
//  WebViewController.m
//  Nerdfeed
//
//  Created by Zaur Giyasov on 14/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc] init];
    webView.scalesPageToFit = YES;
    self.view = webView;
}

-(void)setURLz:(NSURL *)URLz {
    _URLz = URLz;
    if (_URLz) {
        NSURLRequest *req = [NSURLRequest requestWithURL:_URLz];
        [(UIWebView *)self.view loadRequest:req];
        
    }
}



@end
