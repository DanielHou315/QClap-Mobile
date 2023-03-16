//
//  ContentView.swift
//  QClap
//
//  Created by Daniel Hou on 12/6/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct ClapperBoardView: View {
    @State var production: String
    @State var sceneNumber: String
    @State var takeNumber: String
    @State var rollNumber: Int
    @State var cameraNumber: String
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func Mark(){
        
    }
    
    func getTodayString() -> String{
        let today = Date.now
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        return formatter1.string(from: today)
    }
    
    func generateQRCode(from string: String) -> UIImage{
        filter.message = Data(string.utf8)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    var body: some View {
        // Main View
        HStack{
            // LeftMost Clapper
            Image("ClapperBoardSmall").resizable().frame(width: 80)
            
            // Main Board View
            VStack{
                // Production Name
                HStack{
                    Text("Production: ").foregroundColor(.black).frame(alignment:.leading).font(.system(size:36))
                    TextField("\(production)", text: $production).padding().foregroundColor(.black).frame(alignment: .center).font(.system(size:46))
                    Button("Mark", action: Mark).foregroundColor(.black).background(Color(.red)).clipShape(Capsule()).font(.system(size:46)).padding()
                }
                
                // Scene, Take, Roll
                Divider()
                
                HStack {
                    VStack{
                        Text("Scene").foregroundColor(.black).frame(alignment:.bottomLeading).font(.system(size:36))
                        Spacer()
                        TextField("\(sceneNumber)", text: $sceneNumber).foregroundColor(.black).frame(alignment: .center).font(.system(size:84)).padding()
                        // Text("\(sceneNumber)").foregroundColor(.black).frame(alignment: .topLeading).font(.system(size:84))
                        Spacer()
                    }.padding().background(.white).frame(
                        maxWidth: .infinity
                    )
                    Divider()
                    VStack{
                        Text("Take").foregroundColor(.black).frame(alignment: .topLeading).font(.system(size:36))
                        Spacer()
                        TextField("\(takeNumber)", text: $takeNumber).foregroundColor(.black).frame(alignment: .center).font(.system(size:84)).padding()
                        Spacer()
                    }.padding().background(.white).frame(
                        maxWidth: .infinity
                    )
                    Divider()
                    VStack{
                        Text("Roll").foregroundColor(.black).frame(alignment: .topLeading).font(.system(size:36))
                        Spacer()
                        Stepper("\(rollNumber)", value: $rollNumber, step: 1).foregroundColor(.black).frame(alignment: .center).font(.system(size:84)).padding()
                        Spacer()
                    }.padding().background(.white).frame(
                        maxWidth: .infinity
                    )
                }
                Divider()
                // Scene, Take, Roll
                HStack {
                    VStack{
                        Text("Camera").foregroundColor(.black).frame(alignment: .topLeading).font(.system(size:46))
                        Spacer()
                        TextField("\(cameraNumber)", text: $cameraNumber).foregroundColor(.black).frame(alignment: .center).font(.system(size:64)).padding()
                        Spacer()
                    }
                    Divider()
                    VStack{
                        Text("Date: ").foregroundColor(.black).frame(alignment: .topLeading).font(.system(size:46))
                        Spacer()
                        Text(Date.now, format: .dateTime.day().month().year()).foregroundColor(.black).frame(alignment: .topLeading).font(.system(size:64))
                        Spacer()
                    }
                    Divider()
                    VStack{
                        Text("QR-Code").foregroundColor(.black).frame(alignment: .topLeading).font(.system    (size:46))
                        Spacer()
                        // Image("Blank_White").resizable().scaledToFit()
                        Image(uiImage: generateQRCode(from: "Production:\(production)&Scene:\(sceneNumber)&Take:\(takeNumber)&Roll:\(String(rollNumber))&Camera:\(cameraNumber)&Date:\(getTodayString())")).interpolation(.none).resizable().scaledToFit().frame(width: 200, height: 200)
                        Spacer()
                    }
                }
                Divider()
            }
        }.background(.white).frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ClapperBoardView(production: "annarborbreak", sceneNumber: "1", takeNumber: "1A", rollNumber: 1, cameraNumber: "CAM1")
    }
}
