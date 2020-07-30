//
//  DetailVC.swift
//  Picturize
//
//  Created by Crocodic on 06/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit
import Lightbox
import Toast_Swift

class DetailVC: UIViewController {
	
	@IBOutlet var authorLabel: UILabel!
	@IBOutlet var placeLabel: UILabel!
	@IBOutlet var resolutionLabel: UILabel!
	@IBOutlet var durationLabel: UILabel!
	@IBOutlet var imageView: UIImageView!
	@IBOutlet var downloadBtn: UIButton!
	@IBOutlet var shareBtn: UIButton!
	@IBOutlet var bottomOptnView: UIView!
	@IBOutlet var playBtn: UIButton!
	@IBOutlet var videoDetailStack: UIStackView!
	@IBOutlet var labelStack: UIStackView!
	@IBOutlet var constraintHeightImageView: NSLayoutConstraint!
	@IBOutlet var actionStack: UIStackView!
	
	var viewModel = DetailVM()
	var isVideo = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.viewModel.isVideo = isVideo
		
		playBtn.isHidden = !isVideo
		actionStack.isHidden = true
		videoDetailStack.isHidden = !isVideo
		
		setupView()
	}
	
	private func setupView() {
		authorLabel.text = viewModel.getAuthor
		placeLabel.text = viewModel.getImageProvider
		resolutionLabel.text = viewModel.getVideoResolution
		durationLabel.text = viewModel.getVideoDuration
		var placeholderImage: UIImage!
		if #available(iOS 13.0, *) {
			placeholderImage = UIImage(systemName: "photo.fill")
		} else {
			placeholderImage = UIImage(named: "placeholder_image")
		}
		
		imageView.sd_setImage(with: viewModel.getImageURL, placeholderImage: placeholderImage) { (image, error, cacheType, url) in
			if let image = image {
				self.setDynamicHeightImage(image: image)
				self.viewModel.setImage(image: image)
				self.actionStack.isHidden = false
			}
			if let _ = error {
				self.view.makeToast("No internet connection")
			}
		}
		
		/// Add tap gesture for imageview tap
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(gesture:)))
		imageView.addGestureRecognizer(tapGesture)
		imageView.isUserInteractionEnabled = true
		
		/// Add gesture for stackview tap
		let authorTapGesture = UITapGestureRecognizer(target: self, action: #selector(authorTapped(gesture:)))
		labelStack.addGestureRecognizer(authorTapGesture)
		labelStack.isUserInteractionEnabled = true
	}
	
	/// ImageView size depend on the image ratio
	private func setDynamicHeightImage(image: UIImage) {
		let ratio = image.size.width / image.size.height
		constraintHeightImageView.constant = imageView.bounds.width / ratio
	}
	
	/// ImageView tapped
	@objc func imageTapped(gesture: UIGestureRecognizer) {
		if (gesture.view as? UIImageView) != nil {
			showFullscreenPicture()
		}
	}
	
	/// Author stackview tapped
	@objc func authorTapped(gesture: UIGestureRecognizer) {
		if (gesture.view as? UIStackView) != nil {
			UIApplication.shared.open(viewModel.getAuthorURL)
		}
	}
	
	private func showFullscreenPicture() {
		let controller = LightboxController(images: viewModel.getLightboxImage)
		controller.modalPresentationStyle = .fullScreen
		controller.dynamicBackground = true
		present(controller, animated: true, completion: nil)
	}
	
	/// USELESS FUNCTION
	private func playVideo() {
		guard var videoUrl = self.viewModel.getVideoURL else {
			print("No video url!")
			return
		}
		if videoUrl.absoluteString != nil {
			var urlString = videoUrl.absoluteString
			if let targetRange = urlString.range(of: "?") {
				urlString.removeSubrange(targetRange.lowerBound..<urlString.endIndex)
			}
			videoUrl = URL(string: urlString)!
		}
		let playerController = UIStoryboard(name: "Player", bundle: nil).instantiateViewController(withIdentifier: "PlayerController") as! PlayerController
		playerController.url = videoUrl
		present(playerController, animated: true, completion: nil)
	}
	
	@IBAction func downloadAction(_ sender: Any) {
		viewModel.download()
//		let str = "Super long string here"
//		let filename = self.getDocumentsDirectory().appendingPathComponent("output.txt")
//
//		do {
//			try str.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
//		} catch {
//			// failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
//		}
	}
	
	func getDocumentsDirectory() -> URL {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		return paths[0]
	}
	
	@IBAction func shareAction(_ sender: Any) {
		let activityVC = UIActivityViewController(activityItems: [viewModel.getURL], applicationActivities: nil)
		activityVC.popoverPresentationController?.sourceView = self.view
		self.present(activityVC, animated: true, completion: nil)
	}
	
	@IBAction func playAction(_ sender: Any) {
		showFullscreenPicture()
	}
	
}
