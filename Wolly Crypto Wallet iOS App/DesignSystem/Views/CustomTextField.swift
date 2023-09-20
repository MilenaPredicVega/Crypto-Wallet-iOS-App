//
//  CustomTextField.swift
//  Wolly Crypto Wallet iOS App
//
//  Created by Milena Predic on 18.9.23..
//

import SwiftUI

struct CustomTextField: View {
    var placeholder: LocalizedStringKey
    var text: Binding<String>

    var body: some View {
        TextField(placeholder, text: text)
        Divider()
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        @State var email: String = ""
        CustomTextField(placeholder: "Email", text: $email)
    }
}
