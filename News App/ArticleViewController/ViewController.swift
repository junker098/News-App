//
//  ViewController.swift
//  News App
//
//  Created by Юрий Могорита on 26.10.2020.
//  Copyright © 2020 Yuri Mogorita. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Properties
    
    private let searchBarController = UISearchController(searchResultsController: nil)
    private var articles: [Articles]?
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    //MARK: - Setup search-bar
    
    func setupSearchBar() {
        navigationItem.searchController = searchBarController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBarController.searchBar.delegate = self
        searchBarController.obscuresBackgroundDuringPresentation = false
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
        activityIndicator.isHidden = true
    }
}

//MARK: - Extension UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:TableViewCell.self), for: indexPath) as? TableViewCell else { return UITableViewCell()}
        guard let article = articles?[indexPath.row] else { return UITableViewCell() }
        cell.articleTitleLabel.text = article.title
        cell.articleDescriptionLabel.text = article.description
        guard let url = URL(string: article.urlToImage ) else { return UITableViewCell()}
        cell.articleImage.af.setImage(withURL: url)
        return cell
    }
}

//MARK: - Extension UITableViewDelegate

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please enter text in search bar..."
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return articles?.count ?? 0 > 0 ? 0 : 250
    }
    
    //navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let article = articles?[indexPath.row] else { return }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "detailVC") as DetailViewController
        vc.article = article
        navigationController?.show(vc, sender: self)
    }
}

//MARK: - Extension UISearchBarDelegate

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    self.activityIndicator.startAnimating()
    self.activityIndicator.hidesWhenStopped = true
        NetworkManager.shared.sendRequest(searchText: searchBar.text) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.articles = result.articles
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            case .failure(let message):
                self.showAlert(message: message.rawValue)
            }
//            self.activityIndicator.stopAnimating()
        }
    }
}
