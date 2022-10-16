//
//  FavouriteBreedsTableViewController.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/16/22.
//

import UIKit

class FavouriteBreedsTableViewController: UITableViewController {
    
    private var favouriteItems: [Favourite]?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouriteItems = ManageFavourites.shared.favouriteItems
        tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (favouriteItems != nil) ? favouriteItems!.count : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "BreedImageViewCell", bundle: .main), forCellReuseIdentifier: K.Id.Cell.breedImageCell)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Id.Cell.breedImageCell, for: indexPath) as? BreedImageViewCell, let favouriteItems = favouriteItems else {
            
            return UITableViewCell()
        }
        let favourite = favouriteItems[indexPath.row]
        if let url = favourite.fileURL, let breed = favourite.breed {
            let breed = Breed(url: url, breed: breed, subBreed: favourite.subBreed)
            cell.isFavourite = true
            cell.setup(breed)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}
