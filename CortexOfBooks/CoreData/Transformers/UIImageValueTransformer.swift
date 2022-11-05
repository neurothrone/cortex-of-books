//
//  UIImageValueTransformer.swift
//  CortexOfBooks
//
//  Created by Zaid Neurothrone on 2022-11-05.
//

import UIKit

final class UIImageValueTransformer: ValueTransformer {
  override func transformedValue(_ value: Any?) -> Any? {
    guard let image = value as? UIImage else { return nil }
    
    do {
      return try NSKeyedArchiver.archivedData(withRootObject: image, requiringSecureCoding: true)
    } catch {
      assertionFailure("❌ -> Failed to transform `UIImage` to `Data`.")
      return nil
    }
  }
  
  override func reverseTransformedValue(_ value: Any?) -> Any? {
    guard let data = value as? Data else { return nil }
    
    do {
      return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIImage.self, from: data)
    } catch {
      assertionFailure("❌ -> Failed to transform `Data` to `UIImage`.")
      return nil
    }
  }
}

extension UIImageValueTransformer {
  static let name = NSValueTransformerName(String(describing: UIImageValueTransformer.self))
  
  public static func register() {
    ValueTransformer.setValueTransformer(UIImageValueTransformer(), forName: name)
  }
}
