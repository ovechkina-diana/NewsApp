//
//  NewsTableViewController.swift
//  NewsApp
//
//  Created by Diana Ovechkina on 20.01.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var article: Article?
    private var allNews: [New] = []
    private var searchController = UISearchController(searchResultsController: nil)
    private var filteredNews: [New] = []
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchController()
        fetchData(from: Link.NewsApi.rawValue)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // isFiltering ? filteredNews.count : allNews.count
       isFiltering ? filteredNews.count : article?.articles.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
//      let url = Link.NewsApi.rawValue
//      let new = isFiltering ? filteredNews[indexPath.row] : allNews[indexPath.row]
        
        let new = isFiltering ? filteredNews[indexPath.row] : article?.articles[indexPath.row]

    
//        NetworkManager.shared.fetchData(from: url) { result in
//            switch result {
//            case .success(let new):
//                self.allNews.append(new)
//                content.text = new.title
//                cell.contentConfiguration = content
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        content.text = new?.title

        
       // content.text = new.title
        cell.contentConfiguration = content
        
        return cell
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
       let new = isFiltering ? filteredNews[indexPath.row] : article?.articles[indexPath.row]
     //   let new = isFiltering ? filteredNews[indexPath.row] : allNews[indexPath.row]
        guard let detailVC = segue.destination as? NewDetailsViewController else { return }
        detailVC.newInfo = new
    }
    
    
    // MARK: - Private methods
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { new in
            self.article = new
            self.tableView.reloadData()
        }
    }

}

// MARK: - UISearchResultsUpdating
extension NewsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredNews = article?.articles.filter { new in
            new.title.lowercased().contains(searchText.lowercased())
        } ?? []
//        filteredNews = allNews.filter { new in
//            new.title.lowercased().contains(searchText.lowercased())
//        }
        tableView.reloadData()
    }
    
}
