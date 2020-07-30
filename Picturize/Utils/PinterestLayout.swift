//
//  PinterestLayout.swift
//  Picturize
//
//  Created by Crocodic on 28/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
	func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
	
	weak var delegate: PinterestLayoutDelegate?
	
	private let columnCount = 2
	private let cellPadding: CGFloat = 6
	
	private var cache: [UICollectionViewLayoutAttributes] = []
	
	private var contentHeight: CGFloat = 0
	
	private var contentWidth: CGFloat {
		guard let collectionView = collectionView else {
			return 0
		}
		let insets = collectionView.contentInset
		return collectionView.bounds.width - (insets.left + insets.right)
	}
	
	/// Whenever a layout operation is about to take place, UIKit calls this method.
	/// It’s your opportunity to prepare and perform any calculations required to determine the collection view’s size and the positions of the items
	override func prepare() {
		guard cache.isEmpty == true || cache.isEmpty == false, let collectionView = collectionView else {
			return
		}
		
		let columnWidth = contentWidth / CGFloat(columnCount)
		
		var xOffset: [CGFloat] = []
		for column in 0..<columnCount {
			xOffset.append(CGFloat(column) * columnWidth)
		}
		var column = 0
		var yOffset: [CGFloat] = .init(repeating: 0, count: columnCount)
		
		for item in 0..<collectionView.numberOfItems(inSection: 0) {
			let indexPath = IndexPath(item: item, section: 0)
			
			let photoHeight = delegate?.collectionView(collectionView, heightForPhotoAtIndexPath: indexPath) ?? columnWidth
			let height = CGFloat(cellPadding) * 2 + photoHeight
			let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
			
			let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
			
			let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
			attributes.frame = insetFrame
			cache.append(attributes)
			
			contentHeight = max(contentHeight, frame.maxY)
			yOffset[column] = yOffset[column] + height
			
			column = column < (columnCount - 1) ? (column + 1) : 0
		}
		
	}
	
	
	
	
	/// This method returns the width and height of the collection view’s contents.
	/// You must implement it to return the height and width of the entire collection view’s content, not just the visible content.
	///  The collection view uses this information internally to configure its scroll view’s content size
	override var collectionViewContentSize: CGSize {
		return CGSize(width: contentWidth, height: contentHeight)
	}
	
	/// In this method, you return the layout attributes for all items inside the given rectangle.
	/// You return the attributes to the collection view as an array of UICollectionViewLayoutAttributes
	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
		var visibleLayoutAttributes : [UICollectionViewLayoutAttributes] = []
		
		for attributes in cache {
			if attributes.frame.intersects(rect) {
				visibleLayoutAttributes.append(attributes)
			}
		}
		return visibleLayoutAttributes
	}
	
	/// This method provides on demand layout information to the collection view.
	///  You need to override it and return the layout attributes for the item at the requested indexPath
	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
		return cache[indexPath.item]
	}

}
