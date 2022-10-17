//
//  BreedImagesTableViewController.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/10/22.
//

import UIKit

class BreedImagesTableViewController: UITableViewController {
    
     var imagesListForBreed: [String] = []
     var breed: String!
     var subBreed: String?
    private var favouritList: [String]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favouritList = ManageFavourites.shared.favouriteItems.map {$0.fileURL ?? ""}
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imagesListForBreed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = K.Id.Cell.breedImageCell
        tableView.register(UINib(nibName: "BreedImageViewCell", bundle: .main), forCellReuseIdentifier: cellIdentifier )
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? BreedImageViewCell else{
            return UITableViewCell()
        }
        let fileURL = imagesListForBreed[indexPath.row]
        let breed = Breed(url: fileURL, breed: breed, subBreed: subBreed)
        if let favouritList = favouritList {
            cell.isFavourite = favouritList.contains(fileURL)
        }
        cell.setup(breed,showLabels: false)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
}

