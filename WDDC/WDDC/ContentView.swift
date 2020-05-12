
import SwiftUI
//import PlaygroundSupport
import Foundation



struct User: Identifiable {
    var id: String
    var name: String
}



struct ContentView: View {

    let degree = Double.random(in: -30 ..< 30)
    @State var drinkBought: [String] = []
    @State var rotation: [Double] = [30]
    var rot = Double(Int.random(in: -30..<30))

    @State private var myMoney = 0.0
    var prices = [1, 1.1, 1, 1, 1.3, 1.1, 1, 1.2, 1, 1]
    var error = "Can't buy"

    func order(myMoney: Double, price: Double) -> Double {
        print(drinkBought)
        var moneyLeft = 0.0
        if (myMoney > price) {
            moneyLeft = myMoney - price
            var smallList: [String] = []; smallList.append("Coke")

            self.rotation.append(Double(Int.random(in: -30..<30)))
            self.drinkBought.append("Coke")
            print(drinkBought)
        } else {
            moneyLeft = myMoney
        }
        print(myMoney)

        return moneyLeft

    }

    fileprivate func extractedFunc(color: Color, nameDrink: String, index: Int) -> some View {
        return VStack {
            color
                .frame(width: 30, height: 55, alignment: .topLeading)
                .cornerRadius(5)
            Text(nameDrink)
                .font(.system(size: 13))

            Button(action: {
                self.myMoney = self.order(myMoney: self.myMoney, price: self.prices[index])
                if (self.myMoney < 0) {
                    print(self.error)
                }
                print("clicked")


            }) {
                Text("Buy $\(String(format: "%.1f", self.prices[index]))")
                    .foregroundColor(.black)
                    .font(.system(size: 8))
                    .frame(width: 35, height: 12, alignment: .center)
                    .background(Color.gray)
                    .cornerRadius(5)
            }
        }


    }

    var body: some View {

        VStack {



            VStack {

                VStack(spacing: 10) {

                    HStack(spacing: 28) {
                        extractedFunc(color: Color.blue, nameDrink: "Cola", index: 0)
                        extractedFunc(color: Color(red: 248 / 255, green: 102 / 255, blue: 70 / 255)
                            , nameDrink: "Fanta", index: 1)
                        extractedFunc(color: Color.orange, nameDrink: "Pepsi", index: 2)
                        extractedFunc(color: Color.orange, nameDrink: "Orange", index: 3)
                        extractedFunc(color: Color.white, nameDrink: "Walter", index: 4)

                    }
                    HStack(spacing: 28) {
                        extractedFunc(color: Color.blue, nameDrink: "Cola", index: 0)
                        extractedFunc(color: Color(red: 248 / 255, green: 102 / 255, blue: 70 / 255)
                            , nameDrink: "Fanta", index: 1)
                        extractedFunc(color: Color.orange, nameDrink: "Pepsi", index: 2)
                        extractedFunc(color: Color.orange, nameDrink: "Orange", index: 3)
                        extractedFunc(color: Color.white, nameDrink: "Walter", index: 4)
                    }

                }
                    .frame(height: 220)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(3)

                    .padding()

                Divider()
                HStack() {



                    Color.red

                        .cornerRadius(25)
                        .frame(width: 161.0, height: 146.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 9)
                                .stroke(Color.black, lineWidth: 0.4)
                        )
                    Spacer()
                    Text(
                        self.myMoney <= 0 ? "":
                            "$\(String(format: "%.1f", self.myMoney))"
                    )


                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Corner Radius@*/13.0/*@END_MENU_TOKEN@*/)
                        .fill(Color.black.opacity(0.5))
                        .frame(height: 40)
                        .frame(width: 70)
                }
                    .padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 20))


                    .frame(maxWidth: .infinity)
                    .frame(maxHeight: 100)

                Spacer()
                Group {
                    HStack() {

                        ForEach(0 ... drinkBought.count, id: \.self) { num in
                            VStack {
                                VStack{
                                    Color.green
                                                                     .frame(width: 30, height: 55)

                                                                     .cornerRadius(5)
                                }
                                .rotationEffect(.degrees(Double(self.rotation[num])))

                             
                            }
                        }


                    } .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(8)

                        .padding()


                }

            }.frame(width: 350, height: 550, alignment:
                    .topLeading)
                .background(Color.red)
                .cornerRadius(8)


            HStack {


                Button(action: {
                    self.myMoney = self.myMoney + 1.0
                    print(self.myMoney)
                }) {
                    Text("$1.0")
                }
                Button(action: {
                    self.myMoney = self.myMoney + 3.0
                    print(self.myMoney)
                }) {
                    Text("$3.0")
                }
                Button(action: {
                    self.myMoney = self.myMoney + 5.0
                    print(self.myMoney)
                }) {
                    Text("$5.0")
                }
            }
        }

    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()


    }
}





//PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
