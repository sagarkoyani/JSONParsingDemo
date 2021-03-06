//
//  ViewController.m
//  JsonParsingDemo
//
//  Created by Apple on 25/03/19.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dicJson=[[NSMutableDictionary alloc]init];
    
    NSString *urlAsString = [NSString stringWithFormat:@"https://www.cricbuzz.com/match-api/livematches.json"];
    /*
    Sample APIS for Practice:
    1.https://cricketapi-icc.pulselive.com/fixtures/8175/scoring
    2.https://cricketapi-icc.pulselive.com/fixtures?tournamentTypes=I,WI&startDate=2019-02-20&endDate=2019-02-24&pageSize=50&sort=desc
    3.https://cricketapi-icc.pulselive.com/fixtures/8792/scoring
    4.https://cricketapi-icc.pulselive.com/fixtures/10876/scoring
    
    */
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlAsString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                
                NSLog(@"RESPONSE: %@",response);
                NSLog(@"DATA: %@",data);
                
                if (!error) {
                    // Success
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        self->dicJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        if (jsonError) {
                            // Error Parsing JSON
                            
                        } else {
                            // Success Parsing JSON
                            // Log NSDictionary response:
                            NSLog(@"%@",self->dicJson);
                        }
                    }  else {
                        //Web server is returning an error
                    }
                } else {
                    // Fail
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}


@end
