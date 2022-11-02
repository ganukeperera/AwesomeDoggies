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

    }
    
    func setupCell(with breed:String){
        
        let defaults = UserDefaults.standard
        
        if let urlString = defaults.string(forKey: breed){
            
            let thubnailImage = UIImage(named: "placeholder")
            self.breedImageView.loadImageFrom(urlString, thubnailImage)
            
        }else{
            
            self.breedImageView.image = UIImage(named: "placeholder")
            let endpoint = DogEndpoint.getRandomImage(breed: breed)
            
            NetworkEngine.request(endPoint: endpoint) { (result: Result<RandomImageResponse,Error>) in
                
                switch result {
                    
                case .success(let success):
                    
                    let thubnailImage = UIImage(named: "placeholder")
                    let randomImageUrl = success.message
                    defaults.set(randomImageUrl, forKey: breed)
                    self.breedImageView.loadImageFrom(randomImageUrl, thubnailImage)
                    
                case .failure(let failure):
                    
                    assertionFailure("Error while getting random image url for \(breed), error \(failure.localizedDescription)")
                }
            }
        }
        nameLabel.text = breed.capitalized
    }
    
}
