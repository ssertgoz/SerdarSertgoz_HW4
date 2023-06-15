//
//  DetailViewController.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import UIKit

protocol DetailViewControllerProtocol: AnyObject{
    func setTitle(_ title: String)
    func updateTrackNameLabel(text: String)
    func updateTrackImage(url: String)
    func updateCollectionPriceLabel(text: String)
    func updateTrackPriceLabel(text: String)
    func updateGenreNameLabel(text: String)
    func updateArtistNameLabel(text: String)
    func updateProgressBarView(defaultTime: String)
    func updateLikeImageButton(isFavorite: Bool, normal: String, filled: String)
    func updateCollectionNameLabel(text: String)
    func updatePlayImageButton(image: UIImage)
    func setPlayImage(_ isPlaying: Bool, _ stopImageName: String, _ playImageName: String)
    func startPlayAnimation(elapsedTime: String,totalTime: String, progress: Double)
    func stopPlayAnimation(_ stopImageName: String, _ playImageName: String)
    func getSource() -> SongEntity?
}

class DetailViewController: BaseViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackImage: UIImageView!
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var genreNameLabel: UILabel!
    @IBOutlet weak var collectionPriceLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var likeImageButton: UIImageView!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var playImageButton: UIImageView!
    private var progressBar: ProgressBarView!
    var presenter: DetailPresenterProtocol!
    var source: SongEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        
    }
    
    @objc private func imageViewTapped() {
        presenter.playMusic()
    }
    @objc private func likeImageButtonTapped() {
        presenter.saveToFavorites()
    }
    
}


extension DetailViewController: DetailViewControllerProtocol{
    
    func setPlayImage(_ isPlaying: Bool, _ stopImageName: String, _ playImageName: String) {
        DispatchQueue.main.async {
            if isPlaying {
                self.playImageButton.image = UIImage(systemName: stopImageName)
            }
            else {
                self.playImageButton.image = UIImage(systemName: playImageName)
            }
        }
    }
    
    func startPlayAnimation(elapsedTime: String, totalTime: String, progress: Double) {
        progressBar.setProgress(CGFloat(progress))
        progressBar.setElapsedTime(elapsedTime)
        progressBar.setTotalTime(totalTime)
    }
    
    func stopPlayAnimation(_ stopImageName: String, _ playImageName: String) {
        progressBar.setProgress(0)
        setPlayImage(false, stopImageName, playImageName)
    }
    
    func getSource() -> SongEntity? {
        return self.source
    }
    
    func updateTrackNameLabel(text: String) {
        trackNameLabel.text = text
    }
    
    func updateTrackImage(url: String) {
        if let url = URL(string: url) {
            DispatchQueue.main.async(execute: {
                self.trackImage.sd_setImage(with: url) { (image, error, cacheType, imageUrl) in
                    self.colorView.backgroundColor = image?.averageColor
                    let colors: [UIColor] = [.black, .black.withAlphaComponent(0), .black]
                    self.trackImage.clipsToBounds = false
                    self.trackImage.applyShadow()
                    self.gradientView.setGradientBackground(colors: colors)
                }
                
            })
        }
    }
    
    func updateCollectionPriceLabel(text: String) {
        collectionPriceLabel.text = text
    }
    
    func updateTrackPriceLabel(text: String) {
        trackPriceLabel.text = text
    }
    
    func updateGenreNameLabel(text: String) {
        genreNameLabel.text = text
    }
    
    func updateArtistNameLabel(text: String) {
        artistNameLabel.text = text
    }
    
    func updateProgressBarView(defaultTime: String) {
        let size = presenter.calculateProgressBarSize(width: view.frame.width)
        progressBar = ProgressBarView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        progressBar.setTotalTime(defaultTime)
        progressBar.setElapsedTime(defaultTime)
        progressBarView.addSubview(progressBar)
        
    }
    
    func updateLikeImageButton(isFavorite: Bool, normal: String, filled: String) {
        if isFavorite {
            likeImageButton.image = UIImage(systemName: filled)
        }
        else{
            likeImageButton.image = UIImage(systemName: normal)
        }
    }
    
    func updateCollectionNameLabel(text: String) {
        collectionNameLabel.text = text
    }
    
    func updatePlayImageButton(image: UIImage) {
        playImageButton.image = image
    }
    func setTitle(_ title: String) {
        self.title = title
        navigationController?.navigationBar.tintColor = UIColor.white
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        playImageButton.addGestureRecognizer(tapGesture)
        let likeImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(likeImageButtonTapped))
        likeImageButton.addGestureRecognizer(likeImageTapGesture)
    }
}

