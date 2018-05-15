//
//  WebViewController.h
//  Nerdfeed
//
//  Created by Zaur Giyasov on 14/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UISplitViewControllerDelegate>

@property (nonatomic) NSURL *url;
@property (nonatomic) UIWebView *webView;

@end
