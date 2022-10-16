//
//  ViewController.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/9/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var alertView: UIAlertController?
    var breeds: BreedResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
}

//MARK: - Action Outlets
extension WelcomeViewController{
    @IBAction func loadBreadsClicked(_ sender: Any) {
        addLoadingView()
        
        let endpoint = DogEndpoint.getAllBreeds
        NetworkEngine.request(endPoint: endpoint) { (result: Result<BreedResponse,Error>) in
            switch result {
            case .success(let success):
                self.breeds = success
                DispatchQueue.main.async {
                    self.alertView?.dismiss(animated: false, completion: {
                        self.performSegue(withIdentifier: K.Id.Segue.toBreedList, sender: self)
                    })
                    
                }
            case .failure(let failure):
                DispatchQueue.main.async {
                    self.removeLoadinView()
                }
                print("Error has occurred while fetching dogs\(failure.localizedDescription)")
            }
        }
    }
}

//MARK: - Supporting Methods
extension WelcomeViewController{
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.Id.Segue.toBreedList{
            if let breedCTRL = segue.destination as? BreedsTableViewController {
                let array = breeds?.message.map{$0.key}.sorted()
                if let array = array {
                    breedCTRL.breeds = array
                }
            }
        }
    }
    
    private func addLoadingView(){
        alertView = UIAlertController(title: nil, message: NSLocalizedString("WelcomeCTRL.Alert.Wait", comment: "Please wait.."), preferredStyle: .alert)
        let loadView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadView.hidesWhenStopped = true
        loadView.startAnimating()
        loadView.style = UIActivityIndicatorView.Style.medium
        alertView?.view.addSubview(loadView)
        present(alertView!, animated: true, completion: nil)
    }
    
    private func removeLoadinView(){
        alertView?.dismiss(animated: false, completion: nil)
    }
}

