//
//  CacheManager.swift
//  News
//
//  Created by Carlos Cardona on 22/05/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import Foundation


class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveData(_ url:String, _ imageData:Data) {
        
        // Save the image data along with the URL
        imageDictionary[url] = imageData
    }
    
    static func retrievedData(_ url:String) -> Data? {
        
        // Return the saved image data or nil
        return imageDictionary[url]
    }
}
