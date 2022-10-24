//
//  BreedTableViewCell.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/20/22.
//

import UIKit

class BreedTableViewCell: UITableViewCell {

    @IBOutlet weak var breedImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(with breed:String){
        
        if !self.breedImageView.cachedImageAvailableFor(key: breed){
            let thubnailImage = UIImage(named: "placeholder")
            let randomImageUrl = ""
            self.breedImageView.loadImageFrom(randomImageUrl, thubnailImage, breed)
        }else{
            self.breedImageView.image = UIImage(named: "placeholder")
            let endpoint = DogEndpoint.getRandomImage(breed: breed)
            NetworkEngine.request(endPoint: endpoint) { (result: Result<RandomImageResponse,Error>) in
                switch result {
                case .success(let success):
                    let thubnailImage = UIImage(named: "placeholder")
                    let randomImageUrl = success.message
                    self.breedImageView.loadImageFrom(randomImageUrl, thubnailImage, breed)
                    
                case .failure(let failure):
                    assertionFailure("Error while getting random image url for \(breed), error \(failure.localizedDescription)")
                }
            }
        }
        nameLabel.text = breed.capitalized
    }
    
}
