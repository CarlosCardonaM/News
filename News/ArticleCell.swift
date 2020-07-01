//
//  ArticleCell.swift
//  News
//
//  Created by Carlos Cardona on 22/05/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay:Article?
    
    func displayArticle(_ article:Article) {
        
        // Clean up the cell before desplaying the next article
        articleImageView.image = nil
        articleImageView.alpha = 0
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        
        
        // Keep a reference to the article
        articleToDisplay = article
        
        // Set the headline
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the label into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
            
            self.headlineLabel.alpha = 1
            
        }, completion: nil)
        
        // Download and display the image
        
        // Check that the article actually has an image
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Create the url string
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the CacheManager before downloading any image data
        if let imagedata = CacheManager.retrievedData(urlString) {
            
            // there is image data, set the imageview and return
            articleImageView.image = UIImage(data: imagedata)
            
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                
                self.articleImageView.alpha = 1
                
            }, completion: nil)
            
            return
        }
        
        // Create a url object
        let url = URL(string: urlString)
        
        // Check that the url isn't nill
        guard url != nil else {
            print("Couldn't create you url object")
            return
        }
        
        // get a url session
        let session = URLSession.shared
        
        // Create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            // Check that there were no errors
            if error == nil && data != nil {
                
                // save the data into cache
                CacheManager.saveData(urlString, data!)
                
                if self.articleToDisplay?.urlToImage == urlString {
                    
                    // Check if the url string that the data task went off to download matches the article this cell is set to display
                    DispatchQueue.main.async {
                        // Display the image data in the imageview
                        self.articleImageView.image = UIImage(data: data!)
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut, animations: {
                            
                            self.articleImageView.alpha = 1
                            
                        }, completion: nil)
                        
                    }

                }
                
                                
            }
            
        }
        
        // Kick off the data task
        dataTask.resume()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
