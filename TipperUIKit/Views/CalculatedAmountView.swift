//
//  CalculatedAmountView.swift
//  TipperUIKit
//
//  Created by Vui Nguyen on 3/29/22.
//

import SwiftUI

struct CalculatedAmountView: View {
    @ObservedObject var viewModel: TipperViewModel
    let calculatedAmountType: CalculatedAmountType

    var body: some View {
        let amountLabel = calculatedAmountType.rawValue
        let tipPercent = viewModel.tipPercent
        let billAmount = viewModel.billAmount
        let amount = calculatedAmountType == .tipAmount ?
        viewModel.getTipAmountStringFormatted(tipPercent: tipPercent, billAmount: billAmount) :
        viewModel.getBillTotalStringFormatted(tipPercent: tipPercent, billAmount: billAmount)
        
        HStack(alignment: .center) {
            Text(amountLabel)
                .primaryStyle()
            Spacer(minLength: 100)
            Text(amount)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(Color.blue)
            Spacer()
                .frame(width: 20)
        }
    }
}

struct CalculatedAmountView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatedAmountView(viewModel: TipperViewModel(), calculatedAmountType: .tipAmount)
    }
}
