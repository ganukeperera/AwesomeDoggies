//
//  BreedsTableViewController.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/9/22.
//

import UIKit

class BreedsTableViewController: UITableViewController {

    var breeds: [String] = []
    var imagesListForBreed: [String] = []
    var selectedBreed: String?
    var selectedSubBreed: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("BreedListCTRL.Title", comment: "Doggies")
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return breeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let CellIdentifier = K.Id.Cell.breedCell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier, for: indexPath)
//        cell.textLabel?.text = breeds[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = breeds[indexPath.row].capitalized
        content.textProperties.color = .black
        if let font =  UIFont(name: "Helvetica", size: 20.0) {
            content.textProperties.font = font
        }
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedBreed = breeds[indexPath.row]
        guard let selectedBreed = selectedBreed else {
            return
        }
        let endpoint = DogEndpoint.getAllImages(breed: selectedBreed)
        NetworkEngine.request(endPoint: endpoint) { (result: Result<ImageResponse,Error>) in
            switch result {
            case .success(let success):
                self.imagesListForBreed = success.message
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: K.Id.Segue.toBreedImageList, sender: self)
                }
            case .failure(let failure):
                print("Error while getting image paths. Error = \(failure.localizedDescription)")
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let imageListView = segue.destination as? BreedImagesTableViewController{
            imageListView.imagesListForBreed = imagesListForBreed
            imageListView.breed = selectedBreed
            imageListView.subBreed = selectedSubBreed
        }
    }

}


