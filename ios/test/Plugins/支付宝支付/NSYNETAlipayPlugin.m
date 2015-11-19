//
//  NSYNETAlipayPlugin.m
//  Hello World
//
//  Created by wujiang on 15/10/22.
//
//

#import "NSYNETAlipayPlugin.h"
#import <AlipaySDK/AlipaySDK.h>

@interface NSYNETAlipayPlugin () 


@property (nonatomic,copy) NSString * callBackIdString;

@property (nonatomic, retain) NSDictionary * parametersDict;
@property (nonatomic, copy) NSString * urlString;
@property (nonatomic, copy) NSString * contentType;

@property (nonatomic, copy) NSString * PartnerID;
@property (nonatomic, copy) NSString * SellerID;
@property (nonatomic, copy) NSString * orderSN;

@end


@implementation NSYNETAlipayPlugin
- (void)AliPay:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options{
    if(arguments.count > 0)
    {
        self.callBackIdString = [arguments objectAtIndex:0];
        self.parametersDict =   [arguments objectAtIndex:1];
        self.urlString =        [arguments objectAtIndex:2];
        self.contentType =      [arguments objectAtIndex:3];
//        self.PartnerID =        [arguments objectAtIndex:4];
//        self.SellerID =         [arguments objectAtIndex:5];
//        self.orderSN =          [arguments objectAtIndex:6];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:self.contentType]; //@"text/html"
        
        
//        self.dict = @{@"partner":self.PartnerID,
//                      @"seller_id":self.SellerID,
//                      @"out_trade_no":@"",
//                      @"subject":@"",
//                      @"body":@"",
//                      @"total_fee":@"",
//                      @"notify_url":@"",
//                      @"service":@"",
//                      @"payment_type":@"",
//                      @"_input_charset":@"",
//                      @"it_b_pay":@"",
//                      @"show_url":@"",
//                      @"sign_date":@"",
//                      @"app_id":@"",
//                      }
//        
        
        
        [manager POST:self.urlString parameters:self.parametersDict success:^(AFHTTPRequestOperation *operation, NSDictionary *  responseObject) {
            NSLog(@"JSON:%@", responseObject);
            
            NSString *signedStr = responseObject[@"sign"];
            NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"", [self.parametersDict description], signedStr, @"RSA"];
            
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"00" callback:^(NSDictionary *resultDic) {
                [self AlipayResult:resultDic];
                
            }];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            CDVPluginResult *result = nil;
            result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error description]];
            [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
        }];
        
    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"参数错误"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
    }
}

-(void)AlipayResult:(NSDictionary *)result{
    
    if(result && ([result[@"resultStatus"] isEqualToString:@"9000"]||[result[@"resultStatus"] isEqualToString:@"8000"])){
       
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"支付成功"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];

    }else{
        
        CDVPluginResult *result = nil;
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"支付失败"];
        [self.commandDelegate sendPluginResult:result callbackId:self.callBackIdString];
    }

}
@end
