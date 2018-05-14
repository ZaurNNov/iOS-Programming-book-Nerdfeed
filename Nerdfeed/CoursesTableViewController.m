//
//  CoursesTableViewController.m
//  Nerdfeed
//
//  Created by Zaur Giyasov on 14/05/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "CoursesTableViewController.h"
#import "WebViewController.h"

@interface CoursesTableViewController () <NSURLSessionDelegate>

@property (nonatomic) NSURLSession *session;
@property (nonatomic, copy) NSArray *courses;

@end

@implementation CoursesTableViewController

-(void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didReceiveChallenge:(nonnull NSURLAuthenticationChallenge *)challenge completionHandler:(nonnull void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSURLCredential *cred =
    [NSURLCredential credentialWithUser:@"BigNerdRanch"
                               password:@"AchieveNerdvana"
                            persistence:NSURLCredentialPersistenceForSession];
    completionHandler(NSURLSessionAuthChallengeUseCredential, cred);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *course = self.courses[indexPath.row];
    NSURL *URL = [NSURL URLWithString:course[@"url"]];
    self.webViewController.title = course[@"title"];
    self.webViewController.URLz = URL;
    [self.navigationController pushViewController:self.webViewController animated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return 0;
    return [self.courses count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //return nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];    
    return cell;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

-(instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.navigationItem.title = @"Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        //_session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        [self fetchFeed];
    }
    
    return self;
}

-(void)fetchFeed {
    //NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSString *requestString = @"https://bookapi.bignerdranch.com/private/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:request
                                                     completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                         //NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                         NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                         //NSLog(@"%@", jsonDictionary);
                                                         self.courses = jsonDictionary[@"courses"];
                                                         NSLog(@"%@", self.courses);
                                                         
                                                         dispatch_async(dispatch_get_main_queue(), ^{
                                                             [self.tableView reloadData];
                                                         });
                                                     }];
    [dataTask resume];
}


@end
