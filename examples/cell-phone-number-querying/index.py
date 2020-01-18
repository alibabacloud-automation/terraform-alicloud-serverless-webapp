# -*- coding: utf-8 -*-
import logging
import urllib, urllib2, sys
import ssl
import json
def handler(event, context):
    ct = json.loads(event)
    mob = ct['queryParameters']['mob']
    #return ct
    host = 'http://imobile.market.alicloudapi.com' #market aliyun provider
    path = '/mobile/query'
    method = 'GET'
    appcode = ct['queryParameters']['appcode']
    querys = "number="+ mob
    bodys = {}
    url = host + path + '?' + querys
    request = urllib2.Request(url)
    request.add_header('Authorization', 'APPCODE ' + appcode)
    response = urllib2.urlopen(request)
    content = response.read()
    rep = {
        "isBase64Encoded": "false",
        "statusCode": "200",
        "headers": {
            "x-custom-header": "no"
        },
        "body": content
    }
    return json.dumps(rep)
