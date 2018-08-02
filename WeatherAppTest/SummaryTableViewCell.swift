//
//  SummaryTableViewCell.swift
//  WeatherAppTest
//
//  Created by Vinay on 8/2/18.
//  Copyright © 2018 iOSApp. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var aImageView: UIImageView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgView.layer.cornerRadius  = 10.0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellWithData(dict: Article)  {
        title.text = dict.title
        guard let urlString = dict.urlToImage else {
            return
        }
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Failed fetching image:", error?.localizedDescription ?? "")
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Not a proper HTTPURLResponse or statusCode")
                return
            }
            
            DispatchQueue.main.async {
                self.aImageView.image = UIImage(data: data!)
            }
            }.resume()
    }
    
    
}
