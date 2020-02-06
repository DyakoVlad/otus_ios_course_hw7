//
//  ContentView.swift
//  otus_hw_7
//
//  Created by Vladislav Dyakov on 28.01.2020.
//  Copyright © 2020 Vladislav Dyakov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }

    @State private var errors: Dictionary<String, String> = [:]
    @State private var phoneText: String = ""
    @State private var emailText: String = ""
    @State private var nameText: String = ""
    @State private var birthDateText: String = ""
    @State private var passwordText: String = ""

    var body: some View {
        VStack {
            Group {
                TextField("Phone number", text: $phoneText) {
                    self.validatePhoneNumber()
                    UIApplication.shared.endEditing()
                }
                .foregroundColor(errors["phone"] != nil ? (errors["phone"]! != "nil" ? .red : .green) : .black)
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .modifier(PrimaryTextField())
                Text(errors["phone"] != nil && errors["phone"] != "nil" ? errors["phone"]! : "")
                    .foregroundColor(.red)
            }

            Group {
                TextField("Email", text: $emailText) {
                    self.validateEmail()
                    UIApplication.shared.endEditing()
                }
                .foregroundColor(errors["email"] != nil ? (errors["email"]! != "nil" ? .red : .green) : .black)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .modifier(PrimaryTextField())
                Text(errors["email"] != nil && errors["email"] != "nil" ? errors["email"]! : "")
                .foregroundColor(.red)
            }

            Group {
                TextField("Name", text: $nameText) {
                    self.validateName()
                    UIApplication.shared.endEditing()
                }
                .foregroundColor(errors["name"] != nil ? (errors["name"]! != "nil" ? .red : .green) : .black)
                .textContentType(.name)
                .keyboardType(.default)
                .modifier(PrimaryTextField())
                Text(errors["name"] != nil && errors["name"] != "nil" ? errors["name"]! : "")
                .foregroundColor(.red)
            }

            Group {
                TextField("Birth date", text: $birthDateText) {
                    self.validateDate()

                    UIApplication.shared.endEditing()
                }
                .foregroundColor(errors["date"] != nil ? (errors["date"]! != "nil" ? .red : .green) : .black)
                .textContentType(.none)
                .keyboardType(.numbersAndPunctuation)
                .modifier(PrimaryTextField())
                Text(errors["date"] != nil && errors["date"] != "nil" ? errors["date"]! : "")
                .foregroundColor(.red)
            }

            Group {
                SecureField("Password", text: $passwordText) {
                    self.validateFields()
                }
                .foregroundColor(errors["password"] != nil ? (errors["password"]! != "nil" ? .red : .green) : .black)
                .textContentType(.password)
                .keyboardType(.default)
                .modifier(PrimaryTextField())
                Text(errors["password"] != nil && errors["password"] != "nil" ? errors["password"]! : "")
                .foregroundColor(.red)
            }

            Button(action: {
                self.validateFields()
            }, label: {
                Text("Submit")
                    .foregroundColor(.white)
                    .font(.system(size: 17, weight: .semibold, design: .default))
            })
                .frame(width: 200, height: 50)
                .background(Color(.purple))
                .cornerRadius(12)

            Spacer()
        }
    }

    func validateFields() {
        validatePhoneNumber()
        validateEmail()
        validateName()
        validateDate()
        validatePassword()
    }

    func validatePhoneNumber() {
        if self.phoneText.isValidPhoneNumber {
            errors["phone"] = "nil"
        } else {
            errors["phone"] = "Incorrect phone number"
        }
    }

    func validateEmail() {
        if self.emailText.isValidEmailRFC5322 {
            errors["email"] = "nil"
        } else {
            errors["email"] = "Incorrect email adress"
        }
    }

    func validateName() {
        if self.nameText.isValidName {
            errors["name"] = "nil"
        } else {
            errors["name"] = "Incorrect name"
        }
    }

    func validateDate() {
        if self.birthDateText.isValidDate {
            errors["date"] = "nil"
        } else {
            errors["date"] = "Incorrect date"
        }
    }

    func validatePassword() {
        print(passwordText)
        if self.passwordText.isValidPassword {
            errors["password"] = "nil"
        } else {
            errors["password"] = "Password must contain at least 8 symbols including at least 1 uppercase letter, 1 lowercase letter, 1 number"
        }
    }
}

struct PrimaryTextField: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .font(.system(size: 26, weight: .heavy, design: .default))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

