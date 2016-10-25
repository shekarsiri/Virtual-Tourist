//
//  FlickrConstant.swift
//  Virtual Tourist
//
//  Created by Tobias Helmrich on 26.10.16.
//  Copyright © 2016 Tobias Helmrich. All rights reserved.
//

import Foundation

struct FlickrConstant {
    struct Url {
        static let scheme = "https"
        static let host = "api.flickr.com"
        static let restApiPath = "/services/rest/"
    }
    
    struct Method {
        static let photosSearch = "photos.search"
    }
    
    struct ParameterKey {
        static let apiKey = "api_key"
        static let format = "format"
        static let lat = "lat"
        static let lon = "lon"
        static let radius = "radius"
    }
    
    struct ParameterValue {
        static let apiKey = "b845f56811c9165e8ecbf44032a85a04"
        static let jsonFormat = "json"
    }
}
