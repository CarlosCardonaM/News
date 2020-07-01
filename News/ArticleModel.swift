//
//  ArticleModel.swift
//  News
//
//  Created by Carlos Cardona on 20/05/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import Foundation

protocol ArticleModelProtocol {
    
    
    func articlesRetrieved(_ articles: [Article])
}

class ArticleModel {
    
    var delegate:ArticleModelProtocol?
    func getArticles() {
        
        // Fire off the request to the API
        
        // Create a string URL
        let stringUrl = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c04dfa394724416192b3af7ab0629a30"
        
        // Create a URL object
        
        let url = URL(string: stringUrl)
        
        // Check that it isn't nil
        guard url != nil else {
            print("Couldn't create the url object")
            return
        }
        
        // Get the URL session
        
        let session = URLSession.shared
        
        // Create the data task
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check if there is not error and there is data
            
            if error == nil && data != nil {
                
                // Attempt to parse the JSON
                let decoder = JSONDecoder()
                
                do {
                    
                    // Parse the JSON into Article Service
                    let articlesService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Get the articles
                    let articles = articlesService.articles!
                    
                    // Pass it back to main view controller in the main thread
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articles)
                    }
                }
                catch {
                    
                    print("Error parsing the JSON")
                }// End do - catch
                
            }// End if
            
        }// End dataTask
        
        // Start the data task
        dataTask.resume()
    }
}
