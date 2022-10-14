//
//  ViewController.swift
//  FilmMaker
//
//  Created by RASHED on 10/14/22.
//

import UIKit
import AVKit
import DKImagePickerController

class ViewController: UIViewController {
    
    //IBoutlet
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var lblProcessing: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var btnMergeVideosImages: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI() {
        indicatorView.isHidden = true
        lblProcessing.isHidden = true
        backgroundView.roundCorners(corners: [.topLeft, .topRight], radius: 22)
        btnMergeVideosImages.getButtonComponentsWithCornerRadious()
        //load Gif
        let showGif = UIImage.gifImageWithName("duck")
        gifImageView.image = showGif
    }
    
    func showProcessing(isShow: Bool) {
        if isShow {
            gifImageView.isHidden = true
            indicatorView.isHidden = false
            indicatorView.startAnimating()
            lblProcessing.isHidden = false
        } else {
            gifImageView.isHidden = false
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
            lblProcessing.isHidden = true
        }
    }
    
    @IBAction func onTapButtonMergeVideosAndImages(_ sender: Any) {
        let picker = DKImagePickerController()
        picker.assetType = .allAssets
        picker.showsEmptyAlbums = false
        picker.showsCancelButton = true
        picker.allowsLandscape = false
        picker.maxSelectableCount = 10
        picker.modalPresentationStyle = .fullScreen
        
        picker.didSelectAssets = {[weak self] (assets: [DKAsset]) in
            guard let `self` = self, assets.count > 0 else {return}
            self.preprocess(assets: assets)
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    private func openPreviewScreen(_ videoURL:URL) -> Void {
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        playerController.modalPresentationStyle = .fullScreen
        
        present(playerController, animated: true, completion: {
            player.play()
        })
    }
    
    private func preprocess(assets: [DKAsset]) {
        var arrayAsset:[VideoData] = []
        
        var index = 0
        let group = DispatchGroup()
        
        assets.forEach { (asset) in
            var videoData = VideoData()
            videoData.index = index
            index += 1
            
            if asset.type == .video {
                videoData.isVideo = true
                
                group.enter()
                asset.fetchAVAsset { (avAsset, info) in
                    guard let avAsset = avAsset else {
                        group.leave()
                        return
                    }
                    
                    videoData.asset = avAsset
                    arrayAsset.append(videoData)
                    group.leave()
                }
            }
            else {
                group.enter()
                asset.fetchOriginalImage { (image, info) in
                    guard let image = image else {
                        group.leave()
                        return
                    }
                    
                    videoData.image = image
                    arrayAsset.append(videoData)
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            self.mergeVideosAndImages(arrayData: arrayAsset)
        }
    }
    
    private func mergeVideosAndImages(arrayData: [VideoData]) {
        showProcessing(isShow: true)
        
        let textData = TextData(text: "Hello Appnap",
                                fontSize: 55,
                                textColor: UIColor.red,
                                showTime: 1,
                                endTime: 5,
                                textFrame: CGRect(x: 0, y: 0, width: 400, height: 300))
        
        DispatchQueue.global().async {
            FilmMakerVideoManager.shared.makeVideoFrom(data: arrayData, textData: [textData], completion: {[weak self] (outputURL, error) in
                guard let `self` = self else { return }
                
                DispatchQueue.main.async {
                    self.showProcessing(isShow: false)
                    
                    if let error = error {
                        print("Error:\(error.localizedDescription)")
                    } else if let url = outputURL {
                        self.openPreviewScreen(url)
                    }
                }
            })
        }
    }
}
