//
//  SummaryViewController.swift
//  WeatherAppTest
//
//  Created by Vinay on 8/2/18.
//  Copyright © 2018 iOSApp. All rights reserved.
//

import UIKit

let API_KEY = "62940f70a6af49f8ad5e32c251078976"
public typealias CompletionResponseDict = (_ responseDict: [AnyHashable: Any]?,  _ error: Error?) -> Void

class SummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var articlesList = [Article]()
    @IBOutlet weak var aTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherApiCall { (parsedData, error) in
            let articles = parsedData?["articles"] as? [NSDictionary]
            for aDict in articles! {
                let article = Article.init(dict: aDict as? [AnyHashable : Any])
                self.articlesList.append(article)
            }
            DispatchQueue.main.async {
                self.aTableView.reloadData()
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func weatherApiCall(completion result: @escaping CompletionResponseDict) {
        let urlSring = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_KEY)"
        let myUrl = URL.init(string: urlSring)
        let request = NSMutableURLRequest(url: myUrl!,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error ?? "")
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: []) as! [AnyHashable:Any]
                    print(parsedData["articles"] ?? "")
                    result(parsedData, error)
                } catch let error as NSError {
                    print(error)
                }
            }
        })
        dataTask.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath as IndexPath) as? SummaryTableViewCell
        cell?.updateCellWithData(dict: articlesList[indexPath.row])
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let urlPath  = articlesList[indexPath.row].url
        self.performSegue(withIdentifier: "DetailSegueID", sender: urlPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  "DetailSegueID"{
            let destVC = segue.destination as? DetailViewController
            destVC?.urlPath = sender as? String
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}
