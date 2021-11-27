//
//  ViewController.swift
//  cryptoTrack
//
//  Created by Yu Jin on 11/27/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        if let symbol = textField.text {
            getData(symbol : symbol)
        
        }
    }
    

    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
    
    func getData(symbol : String) {
        
        url = "\(url)&fsym=\(symbol)"
        
        guard let url = URL(string: url) else {return}
            
        let task = URLSession.shared.dataTask(with: url) { [self] data, _, error in
            
            guard let data = data, error == nil else {return}
            
            print("Data Received")
            
            do{
            
            let Result = try JSONDecoder().decode(APIResponse.self, from: data)
                print(Result.USD)
                
                DispatchQueue.main.async {
                    self.outputLabel.text = "\(Result.USD)"
                }
                
                
            }
            
            catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    struct APIResponse : Codable {
        
        let USD : Float
        
    }
}



