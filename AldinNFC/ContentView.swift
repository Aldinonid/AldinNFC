//
//  ContentView.swift
//  AldinNFC
//
//  Created by Aldino Efendi on 2023-06-24.
//

import SwiftUI
import SwiftNFC

final class ContentViewModel: ObservableObject {
	
	@State var keyboard: Bool = false
	@AppStorage("type") var type = "T"
	
	var nfcr = NFCReader()
	var nfcw = NFCWriter()
	
	func read() {
		nfcr.read()
	}
	
	func write() {
		nfcw.msg = nfcr.msg
		nfcw.write()
	}
	
	enum FilterOption: String {
		case text, link
	}
	
}

struct ContentView: View {
	
	@StateObject private var vm = ContentViewModel()
	
	var body: some View {
		VStack(spacing: 0) {
			editor
			option
			editorRaw
			action
		}
		.ignoresSafeArea(.all)
	}
}

extension ContentView {
	var editor: some View {
		TextEditor(text: $vm.nfcr.msg)
			.font(.title)
			.padding(.top, 50)
			.padding(15)
			.background(Color.accentColor.opacity(0.5))
	}
	
	var editorRaw: some View {
		TextEditor(text: $vm.nfcr.raw)
			.padding(15)
			.background(Color.red.opacity(0.5))
	}
	
	var option: some View {
		Picker(selection: $vm.type, label: Text("Type Picker")) {
			Text("Text").tag("T")
			Text("Link").tag("U")
		}
		.onAppear {
			vm.nfcw.type = vm.type
		}
		.onChange(of: vm.type, perform: { newType in
			vm.nfcw.type = newType
		})
		.frame(maxWidth: .infinity, alignment: .leading)
		.padding(.leading)
	}
	
	var action: some View {
		HStack(spacing: 0) {
			Button {
				
			} label: {
				Label(
					"Read NFC",
					systemImage: "wave.3.left.circle.fill"
				)
				.frame(maxWidth: .infinity)
				.foregroundColor(Color.black)
				.padding()
				.padding(.top, 15)
				.padding(.bottom, 35)
				.background(Color.pink.opacity(0.85))
			}
			
			Button {
				
			} label: {
				Label(
					"Write NFC",
					systemImage: "wave.3.left.circle.fill"
				)
				.frame(maxWidth: .infinity)
				.foregroundColor(Color.black)
				.padding()
				.padding(.top, 15)
				.padding(.bottom, 35)
				.background(Color.green)
			}
		}
//		.frame(maxWidth: .infinity)
		.frame(maxWidth: .infinity, minHeight: 75)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
