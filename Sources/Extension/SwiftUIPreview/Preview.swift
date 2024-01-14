//
//  Preview.swift
//  base-combine
//
//  Created by Thân Văn Thanh on 30/08/2023.
//

#if canImport(SwiftUI) && DEBUG
import SwiftUI
#endif

@available(iOS 13.0, *)
struct Preview<V: View>: View {
  enum Device: String, CaseIterable {
    case iPhone8 = "iPhone 8"
    case iPhone11 = "iPhone 11"
    case iPhone11Pro = "iPhone 11 Pro"
    case iPhone11ProMax = "iPhone 11 Pro Max"
  }

  let source: V
  var devices: [Device] = [.iPhone11ProMax, .iPhone8]
  var displayDarkMode: Bool = true

  // MARK: Body
  
  var body: some View {
    return Group {
      ForEach(devices, id: \.self) {
        self.previewSource(device: $0)
      }
      if !devices.isEmpty && displayDarkMode {
        self.previewSource(device: devices[0])
          .preferredColorScheme(.dark)
      }
    }
  }

  private func previewSource(device: Device) -> some View {
    source
      .previewDevice(PreviewDevice(rawValue: device.rawValue))
      .previewDisplayName(device.rawValue)
  }
}
