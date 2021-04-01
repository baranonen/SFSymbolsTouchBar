//
//  ContentView.swift
//  SFSymbolsTouchBar
//
//  Created by Baran Önen on 31.03.2021.
//

import SwiftUI
import SFSafeSymbols

struct TouchBarDiscoverView: View {
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                Text("Press to copy a symbol")
                ForEach(SFSymbol.allCases, id: \.self) { symbol in
                    Button( action: {
                        let pasteBoard = NSPasteboard.general
                        pasteBoard.clearContents()
                        pasteBoard.setString(symbol.rawValue, forType: .string)
                    }, label: {
                        Text("\(symbol.rawValue)")
                        Image(systemSymbol: symbol)
                    })
                }
            }
        }
        .frame(width: 685, height: 30)
    }
}

struct TouchBarFindView: View {
    var symbolName: String
    var body: some View {
        HStack {
            Text("Manually write a valid SF Symbol name")
            Button(action: {
                let pasteBoard = NSPasteboard.general
                pasteBoard.clearContents()
                pasteBoard.setString(symbolName, forType: .string)
            }, label: {
                Text("\(symbolName)")
                Image(systemName: symbolName)
            })
        }
        .frame(width: 685, height: 30, alignment: .leading)
    }
}

struct TouchBarRandomView: View {
    @State var symbolName: String = ""
    var body: some View {
        HStack {
            Text("Show a random SF Symbol")
            Button(action: {
                let pasteBoard = NSPasteboard.general
                pasteBoard.clearContents()
                pasteBoard.setString(symbolName, forType: .string)
            }, label: {
                HStack {
                    Text("\(symbolName)")
                    Image(systemName: symbolName)
                }
            })
            Spacer()
            Button(action: {
                symbolName = SFSymbol.allCases.randomElement()!.rawValue
            }, label: {
                Text("Random")
                Image(systemName: "die.face.5")
            })
        }
        .frame(width: 605, height: 30, alignment: .leading)
    }
}

struct ContentView: View {
    @State private var discover = ""
    @State private var symbolName = ""
    @State private var randomSymbol = ""
    var body: some View {
        TextField("Click here to discover all of the SF Symbols", text: $discover)
            .frame(width: 300, height: 60, alignment: .center)
            .padding(.horizontal)
            .padding(.top)
            .touchBar(TouchBar {
                TouchBarDiscoverView()
            })
            .onChange(of: (discover), perform: { newValue in
                discover = ""
            })
        TextField("Click here to find a symbol manually", text: $symbolName)
            .frame(width: 300, height: 60, alignment: .center)
            .padding(.horizontal)
            .touchBar(TouchBar {
                TouchBarFindView(symbolName: symbolName)
            })
        TextField("Click here to show a random SF Symbol", text: $randomSymbol)
            .frame(width: 300, height: 60, alignment: .center)
            .padding(.horizontal)
            .padding(.bottom)
            .touchBar(TouchBar {
                TouchBarRandomView()
            })
            .onChange(of: (randomSymbol), perform: { newValue in
                randomSymbol = ""
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
