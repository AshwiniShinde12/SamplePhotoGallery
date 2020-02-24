//
//  ViewController.swift
//  SamplePhotoGallery
//
//  Created by Ashwini on 23/02/20.
//  Copyright © 2020 Ashwini. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var gridCollectionView: UICollectionView!
    var gridLayout: GridLayout!
    var fullImageView: UIImageView!
    var imageArr = ["building","books","mag","nose","Nature"]
    var imgInfo : PhotoInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        gridLayout = GridLayout()
        gridCollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: gridLayout)
        gridCollectionView.backgroundColor = UIColor.white
        gridCollectionView.showsVerticalScrollIndicator = false
        gridCollectionView.showsHorizontalScrollIndicator = false
        gridCollectionView.dataSource = self
        gridCollectionView.delegate = self
        gridCollectionView!.register(ImageCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(gridCollectionView)
        fullImageView = UIImageView()
        fullImageView.contentMode = .scaleAspectFit
        fullImageView.backgroundColor = UIColor.lightGray
        fullImageView.isUserInteractionEnabled = true
        fullImageView.alpha = 0
        self.view.addSubview(fullImageView)
        
        let dismissWihtTap = UITapGestureRecognizer(target: self, action: #selector(hideFullImage))
        fullImageView.addGestureRecognizer(dismissWihtTap)
        fetchPhotos()

    }
    
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var frame = gridCollectionView.frame
        frame.size.height = self.view.frame.size.height
        frame.size.width = self.view.frame.size.width
        frame.origin.x = 0
        frame.origin.y = 0
        gridCollectionView.frame = frame
        fullImageView.frame = gridCollectionView.frame
    }
    
    func showFullImage(of image:UIImage) {
        
        fullImageView.transform = CGAffineTransform(scaleX: 0, y: 0)
        fullImageView.contentMode = .scaleAspectFit

        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations:{[unowned self] in
            
            self.fullImageView.image = image
            self.fullImageView.alpha = 1
            self.fullImageView.transform = CGAffineTransform(scaleX: 1, y: 1)

        }, completion: nil)
    }
    
    @objc func hideFullImage() {

        UIView.animate(withDuration: 0.5, delay: 0, options: [], animations:{[unowned self] in
            self.fullImageView.alpha = 0
        }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   func fetchPhotos() {
     if Reachability.isConnectedToNetwork() == true {
        print(true)
      let url = URL(string: "https://picsum.photos/list")!

      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
     do{
        let data = data
        self.imgInfo = try JSONDecoder().decode(PhotoInfo.self, from: data!)
      
        DispatchQueue.main.async {
            self.gridCollectionView.reloadData()
        }
        
        }catch{
            print("Failed")
        }
      })
      task.resume()
    }
    else{
      print("Please check internet connection")
    }
}
    
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgInfo?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        cell.backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.6392156863, blue: 0.7843137255, alpha: 1)
        let id = imgInfo?[indexPath.row].id ?? 0
        let imageUrl = "https://i.picsum.photos/id/\(id)/300/300.jpg"
       // let imageName = imageArr[indexPath.row]
        ImageLoader.sharedInstance.imageForUrl(urlString: imageUrl, completionHandler: { (image, url) in
            if image != nil {
                //self.imageView.image = image
                cell.imageView.image = image
            }
        })
        cell.label.text = imgInfo?[indexPath.row].author ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        
        if let image = cell.imageView.image {
            self.showFullImage(of: image)
        } else {
            print("no photo")
        }
    }
    
}
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }

        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}










