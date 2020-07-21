//
//  ObjectAssociation.swift
//  Picturize
//
//  Created by Crocodic on 08/07/20.
//  Copyright © 2020 WradDev. All rights reserved.
//

import Foundation

public final class ObjectAssociation<T: AnyObject> {
	
	private let policy: objc_AssociationPolicy
	
	/// - Parameter policy: An association policy that will be used when linking objects.
	public init(policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
		
		self.policy = policy
	}
	
	/// Accesses associated object.
	/// - Parameter index: An object whose associated object is to be accessed.
	public subscript(index: AnyObject) -> T? {
		
		get { return objc_getAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque()) as! T? }
		set { objc_setAssociatedObject(index, Unmanaged.passUnretained(self).toOpaque(), newValue, policy) }
	}
}
