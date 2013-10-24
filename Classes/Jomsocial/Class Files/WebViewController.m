//
//  WebViewController.m
//  iJoomer
//
//  Created by tailored on 9/28/12.
//
//

#import "WebViewController.h"
#import "AppConstantsList.h"
#import "ApplicationData.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize isTV;

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
    webView.delegate = self;
    
    [spinner startAnimating];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [webView release];
    webView = nil;
    [super viewDidUnload];
}

- (void)webView:(UIWebView *)webview didFailLoadWithError:(NSError *)error {
    
    [webView loadHTMLString:[NSString stringWithFormat:@"<h1>%@</h1>", error] baseURL:[NSURL URLWithString:[ApplicationData sharedInstance].website]];
       
}

-(void)viewWillAppear:(BOOL)animated {
    [spinner setBackgroundColor:[ApplicationData sharedInstance].textcolor];
//    spinner.layer.cornerRadius = 4;
//    spinner.layer.masksToBounds = YES;
    self.title = @"";
    DLog(@"link : %@",[ApplicationData sharedInstance].website);
        if ([[ApplicationData sharedInstance].website length] > 0) {
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[ApplicationData sharedInstance].website]]];
        } else {
            [spinner stopAnimating];
        }
//    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [spinner stopAnimating];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    webView.delegate = nil;
    [super dealloc];
}

@end
