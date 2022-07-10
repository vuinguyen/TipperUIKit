//
//  SwiftUIExtensions.swift
//  TipperSwiftUI
//
//  Created by Vui Nguyen on 2/1/22.
//

import SwiftUI

extension Text {
    func primaryStyle() -> some View {
        self
            .font(.headline)
            .fontWeight(.semibold)
            // Color in hex #323A56
            .foregroundColor(Color(red: 0.19607843137254902, green: 0.22745098039215686, blue: 0.33725490196078434))
            .padding()
    }
}
