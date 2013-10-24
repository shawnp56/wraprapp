//
//  WebViewController.h
//  iJoomer
//
//  Created by tailored on 9/28/12.
//
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
    IBOutlet UIActivityIndicatorView *spinner;
}
@property(nonatomic, readwrite)BOOL isTV;

@end
