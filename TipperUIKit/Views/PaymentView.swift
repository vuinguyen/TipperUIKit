//
//  PaymentView.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 6/12/22.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .center, spacing: 20.0) {
            Text("Thanks for the tip!")
                .primaryStyle()
            Image("Image-15percent")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(EdgeInsets(top: 0.0, leading: 40.0, bottom: 0.0, trailing: 40.0))
            Text("How would you like to pay?")
                .primaryStyle()
            HStack(alignment: .center, spacing: 25.0) {
                Button("Credit") {
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Apple Pay") {
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Cash") {
                    presentationMode.wrappedValue.dismiss()
                }
            }   // end button HStack
        }   // end VStack
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView()
    }
}
