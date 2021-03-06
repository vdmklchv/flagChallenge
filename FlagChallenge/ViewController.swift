//
//  ViewController.swift
//  FlagChallenge
//
//  Created by Vadim Colcev on 11/19/20.
//

import UIKit

class flagCell: UITableViewCell {
    @IBOutlet weak var flaglistPicture: UIImageView!
    @IBOutlet weak var flaglistLabel: UILabel!
}

class ViewController: UITableViewController {
    
    var countryImages = Array<String>()
    var countryNames = Array<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flag images"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        countryImages = try! fm.contentsOfDirectory(atPath: path)
        countryImages = countryImages.filter {$0.hasSuffix("png")}
        for image in countryImages {
            let name = String(image.split(separator: "@")[0].uppercased())
            countryNames.append(name)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryImages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "flaglistItem", for: indexPath) as? flagCell else {
            return UITableViewCell()
        }
        cell.flaglistLabel?.text = String(countryNames[indexPath.row])
        cell.flaglistPicture?.image = UIImage(named: countryImages[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as! DetailViewController
        if let image = UIImage(named: countryImages[indexPath.row]) {
            vc.flagImage = image
        }
        vc.countryName = countryNames[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }


}

