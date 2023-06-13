//
//  DetailViewController.swift
//  ITunesApp
//
//  Created by serdar on 8.06.2023.
//

import UIKit
import ITunesAPI

protocol DetailViewControllerProtocol: AnyObject{
    func setTitle(_ title: String)
    func updateTrackNameLabel(text: String)
    func updateTrackImage(url: String)
    func updateCollectionPriceLabel(text: String)
    func updateTrackPriceLabel(text: String)
    func updateGenreNameLabel(text: String)
    func updateArtistNameLabel(text: String)
    func updateProgressBarView()
    func updateLikeImageButton(image: UIImage)
    func updateCollectionNameLabel(text: String)
    func updatePlayImageButton(image: UIImage)
    func setPlayImage(_ isPlaying: Bool)
    func updateProgress(progress: Double)
    func startPlayAnimation(elapsedTime: String,totalTime: String, progress: Double)
    func stopPlayAnimation()
    func getSource() -> Song?
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
    var source: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        playImageButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func imageViewTapped() {
        presenter.playMusic()
    }
    
}


extension DetailViewController: DetailViewControllerProtocol{
    func updateProgress(progress: Double) {
        //progressBar.setProgress(CGFloat(progress))
    }
    
    func setPlayImage(_ isPlaying: Bool) {
        DispatchQueue.main.async {
            if isPlaying {
                self.playImageButton.image = UIImage(systemName: "stop.fill")
            }
            else {
                self.playImageButton.image = UIImage(systemName: "play.fill")
            }
        }
    }
    
    func startPlayAnimation(elapsedTime: String, totalTime: String, progress: Double) {
        progressBar.setProgress(CGFloat(progress))
        progressBar.setElapsedTime(elapsedTime)
        progressBar.setTotalTime(totalTime)
    }
    
    func stopPlayAnimation() {
        updateProgress(progress: 0)
        setPlayImage(false)
    }
    
    func getSource() -> Song? {
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
    
    func updateProgressBarView() {
        progressBar = ProgressBarView(frame: CGRect(x: 0, y: 0, width: progressBarView.frame.width, height: 35))
        progressBar.setTotalTime("00:00")
        progressBar.setElapsedTime("00:00")
        progressBarView.addSubview(progressBar)
        
    }
    
    func updateLikeImageButton(image: UIImage) {
        likeImageButton.image = image
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
    }
    
    
    
}

class ProgressBarView: UIView {
    private var progressLayer: CALayer!
    private var progress: CGFloat = 0.0
    private var backgroundLayer: CALayer!
    private var elapsedTimeLabel: UILabel!
    private var totalTimeLabel: UILabel!
    
    var elapsedTime: String? {
        didSet {
            setElapsedTime(elapsedTime)
        }
    }
    
    var totalTime: String? {
        didSet {
            setTotalTime(totalTime)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProgressLayer()
        setupLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupProgressLayer()
        setupLabels()
    }
    
    private func setupProgressLayer() {
        backgroundLayer = CALayer()
        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        
        
        layer.addSublayer(backgroundLayer)
        progressLayer = CALayer()
        progressLayer.backgroundColor = UIColor.white.cgColor
        layer.addSublayer(progressLayer)
    }
    
    private func setupLabels() {
        let labelHeight: CGFloat = 20
        let labelSpacing: CGFloat = 8
        
        elapsedTimeLabel = UILabel(frame: CGRect(x: 0, y: bounds.height - labelHeight, width: bounds.width / 2, height: labelHeight))
        elapsedTimeLabel.textColor = UIColor.white
        elapsedTimeLabel.textAlignment = .left
        addSubview(elapsedTimeLabel)
        
        totalTimeLabel = UILabel(frame: CGRect(x: bounds.width / 2, y: bounds.height - labelHeight, width: bounds.width / 2, height: labelHeight))
        totalTimeLabel.textColor = UIColor.white
        totalTimeLabel.textAlignment = .right
        addSubview(totalTimeLabel)
        
        let progressViewHeight = bounds.height - labelHeight - labelSpacing
        progressLayer.frame = CGRect(x: 0, y: 0, width: 0, height: progressViewHeight)
    }
    
    func setProgress(_ progress: CGFloat) {
        self.progress = max(0.0, min(progress, 1.0))
        setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let progressWidth = bounds.width * progress
        let progressViewHeight = bounds.height - elapsedTimeLabel.frame.height - 10
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height - elapsedTimeLabel.frame.height - 10)
        progressLayer.frame = CGRect(x: 0, y: 0, width: progressWidth, height: progressViewHeight)
    }
    
    func setElapsedTime(_ time: String?) {
        elapsedTimeLabel.text = time
    }
    
    func setTotalTime(_ time: String?) {
        totalTimeLabel.text = time
    }
}

