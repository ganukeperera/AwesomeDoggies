//
//  FavouriteBreedsTableViewController.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/16/22.
//

import UIKit

class FavouriteBreedsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    private var favouriteItems: [Favourite]?

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = NSLocalizedString("FavouritesCTRL.SearchBar.Placeholder", comment: "search by breed")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteItems = ManageFavourites.shared.favouriteItems
        tableView.reloadData()
    }
    
    func loadAllFavourites() {
        favouriteItems = ManageFavourites.shared.favouriteItems
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (favouriteItems != nil) ? favouriteItems!.count : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = K.Id.Cell.breedImageCell
        
        tableView.register(UINib(nibName: "BreedImageViewCell", bundle: .main), forCellReuseIdentifier: cellIdentifier)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BreedImageViewCell, let favouriteItems = favouriteItems else {
            
            return UITableViewCell()
        }
        let favourite = favouriteItems[indexPath.row]
        if let url = favourite.fileURL, let breed = favourite.breed {
            let breed = Breed(url: url, breed: breed, subBreed: favourite.subBreed)
            cell.isFavourite = true
            cell.setup(breed, showLabels: true)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}

extension FavouriteBreedsTableViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            let items = ManageFavourites.shared.getSearchResults(searchText: searchText)
            if items.count > 0 {
                favouriteItems = items
                tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        loadAllFavourites()
        searchBar.searchTextField.resignFirstResponder()
    }
}

extension FavouriteBreedsTableViewController: UITextFieldDelegate{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        loadAllFavourites()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.searchBar.resignFirstResponder()
        }
        return true
    }
}
