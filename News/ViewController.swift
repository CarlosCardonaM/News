//
//  ViewController.swift
//  News
//
//  Created by Carlos Cardona on 20/05/20.
//  Copyright © 2020 D O G. All rights reserved.
//

import UIKit

class ViewController: UIViewController  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var model = ArticleModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view controller as the data source and delegate of the table view
        tableView.delegate = self
        tableView.dataSource = self
        // Get the articles from the article model
        model.delegate = self
        model.getArticles()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Detect the indexpath the user selected
        let indexpath = tableView.indexPathForSelectedRow
        
        guard indexpath != nil else {
            // The user hasn't selected anything
            return
        }
        
        // Get the article that the user tapped on
        let article = articles[indexpath!.row]
        
        // Get a reference to the deatil view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass the article url to the deatl view controller
        detailVC.articleUrl = article.url!
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Delegate and data source methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Get a cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        // Get the article that the table view is asking about
        let article = articles[indexPath.row]
        
        // TODO: Customize it
        cell.displayArticle(article)
        
        // return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articlesRetrieved(_ articles: [Article]) {
        
        // Set the articles property of the view controller to the articles passed back from the model
        self.articles = articles
        
        // Refresh the table view
        tableView.reloadData()
    }
    
}



