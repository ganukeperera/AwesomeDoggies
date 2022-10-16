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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return imagesListForBreed.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "BreedImageViewCell", bundle: .main), forCellReuseIdentifier:  K.Id.Cell.breedImageCell)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.Id.Cell.breedImageCell, for: indexPath) as? BreedImageViewCell else{
            return UITableViewCell()
        }
        let breed = Breed(url: imagesListForBreed[indexPath.row], breed: breed, subBreed: subBreed)
        cell.setup(breed)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}

