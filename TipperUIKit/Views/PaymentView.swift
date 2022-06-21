//
//  PaymentView.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 6/12/22.
//

import SwiftUI

struct PaymentView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TipperViewModel

    func selectPayment(paymentMethod: PaymentMethod = .credit) {
        viewModel.paymentMethod = paymentMethod
        viewModel.payState = .paid
        print("paymentMethod is: \(String(describing: viewModel.paymentMethod?.description))")
        presentationMode.wrappedValue.dismiss()
    }

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
                Button(PaymentMethod.credit.description) {
                    selectPayment(paymentMethod: .credit)
                }
                Button(PaymentMethod.applepay.description) {
                    selectPayment(paymentMethod: .applepay)
                }
                Button(PaymentMethod.cash.description) {
                    selectPayment(paymentMethod: .cash)
                }
            }   // end button HStack
        }   // end VStack
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(viewModel: TipperViewModel())
    }
}
