//
//  XMLParseModel.m
//  TLS
//
//  Created by 屠淋 on 15/8/21.
//  Copyright (c) 2015年 tulin. All rights reserved.
//

#import "XMLParseModel.h"
#import "GDataXMLNode.h"

@implementation XMLParseModel

+ (NSArray *)XMlElmentWithData:(NSData*)data andElementName:(NSString*)elementname{
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc]initWithHTMLData:data error:nil];

    GDataXMLElement *root = document.rootElement;
    
    NSArray *elements = [root elementsForName:elementname];
    
    return elements;
}

+ (NSArray *)parseProductsWithData:(NSData*)data andName:(NSString*)name{

       NSArray *elemets = [XMLParseModel XMlElmentWithData:data andElementName:name];
    NSMutableArray *array = [NSMutableArray array];
    
    for (GDataXMLElement *ele in elemets) {
        
        DataItemInfo *itemInfo = [[DataItemInfo alloc]init];
        itemInfo.entity_id = [ele attributeForName:@"entity_id"].stringValue;
        itemInfo.type_id = [ele attributeForName:@"type_id"].stringValue;
        itemInfo.sku = [ele attributeForName:@"sku"].stringValue;
        itemInfo.descriptio = [ele attributeForName:@"description"].stringValue;
        itemInfo.short_description = [ele attributeForName:@"short_description"].stringValue;
        itemInfo.name = [ele attributeForName:@"name"].stringValue;
        itemInfo.camera_technology = [ele attributeForName:@"camera_technology"].stringValue;
        itemInfo.camera_housing = [ele attributeForName:@"camera_housing"].stringValue;
        itemInfo.camera_resolution = [ele attributeForName:@"camera_resolution"].stringValue;
        itemInfo.camera_series = [ele attributeForName:@"camera_series"].stringValue;
        itemInfo.regular_price_with_tax = [ele attributeForName:@"regular_price_with_tax"].stringValue;
        itemInfo.regular_price_without_tax = [ele attributeForName:@"regular_price_without_tax"].stringValue;
        itemInfo.final_price_with_tax = [ele attributeForName:@"final_price_with_tax"].stringValue;
        itemInfo.final_price_without_tax = [ele attributeForName:@"final_price_without_tax"].stringValue;
        itemInfo.is_saleable = [ele attributeForName:@"is_saleable"].stringValue;
        
    }
    return array;
}

@end
