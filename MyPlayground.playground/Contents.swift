
import SwiftUI
import PlaygroundSupport
import Foundation
import Combine


struct User: Identifiable {
    var id: String
    var name: String
}


struct ContentView: View {
    @State var timer: Timer!
    @State var count = 0
    @State var disaster = false
    @State var drinkBought: [String] = []
    @State var drinkBought2: [String] = [""]
    @State var smallList: [Any] = [];
    @State var largeList: [Any] = [];
    @State var rotation: [Double] = [0]
    @State var stocks = [4, 21, 2, 1, 2, 3, 0, 2, 4, 3]
    @State private var myMoney = 0.0
    @State var returned = true
    @State var firstUse = true


    var rot = Double(Int.random(in: -30..<30))
    var prices = [1, 1, 1, 1, 1.3, 1.1, 1, 1.2, 1, 1.3]
    var colaColor = Color(red: 54 / 255, green: 13 / 255, blue: 29 / 255)
    var teaColor = Color(red: 226 / 255, green: 194 / 255, blue: 0 / 255)
    var waterColor = Color(red: 248 / 255, green: 241 / 255, blue: 247 / 255)
    var orangeColor = Color(red: 255 / 255, green: 202 / 255, blue: 0 / 255)
    var fantaColor = Color(red: 135 / 255, green: 0 / 255, blue: 18 / 255)
    var colaLabelColor = Color(red: 186 / 255, green: 0 / 255, blue: 26 / 255)
    var teaLabelColor = Color(red: 29 / 255, green: 157 / 255, blue: 26 / 255)
    var orangeLabelColor = Color(red: 255 / 255, green: 142 / 255, blue: 0 / 255)
    var waterLabelColor = Color(red: 152 / 255, green: 220 / 255, blue: 245 / 255)
    var energyLabelColor = Color(red: 204 / 255, green: 0 / 255, blue: 38 / 255)
    var fantaLabelColor = Color(red: 176 / 255, green: 0 / 255, blue: 98 / 255)




    func start() {
        self.timer?.invalidate()
        self.count = 0
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            _ in
            self.count += 1
            print(self.count)
        }
    }

    func order(myMoney: Double, price: Double, drinkName: String, index: Int) -> Double {
        var moneyLeft = 0.0
        var average = 0
        if (self.firstUse == true){
               start()
            self.firstUse = false
        }
   

        if (myMoney >= price) {
            let second = Int.random(in: 0 ... 30)
            print("count")
            print(second)
            
            let b = Int.random(in: 0 ... 3)
            if (b == 1) {
                self.disaster = true
            }


            if (self.disaster) {
                print("disaster happened!")
               
                self.rotation = [10, 30, 20, -20, 10, 40, 30, 10, 50, 20, -40]
                self.drinkBought = ["Cola", "Fanta", "Water", "Apple", "Tea", "Water", "Orange", "Water", "Fanta", "Apple"]
                self.drinkBought2 = ["a", "Cola", "Fanta", "Water", "Apple", "Tea", "Water", "Orange", "Water", "Fanta", "Apple"]
            }
            self.stocks[index] = self.stocks[index] - 1
            moneyLeft = myMoney - price

            if (drinkBought.count > 1) {
                average = ((drinkBought.count - 1) / 2) + 1

            } else {
                average = ((drinkBought.count - 1) / 2)

            }
            self.rotation.insert(Double(Int.random(in: -50..<50)), at: average)
            self.drinkBought.insert(drinkName, at: average)
            self.drinkBought2.insert(drinkName, at: average)
        } else {
            moneyLeft = myMoney
        }
        return moneyLeft
    }

    fileprivate func extractedFunc(color: Color, nameDrink: String, index: Int, type: Int, labelColor: Color) -> some View {
        return VStack {
            if (type == 1) {
                drinkPlastic(capColor: color, drinkColor: color, type: 0, labelColor: labelColor)
            }
            Text(nameDrink)
                .font(.system(size: 13))
                .foregroundColor(.black)
                .padding(.bottom, 3.0)



            if (self.stocks[index] <= 0) {
                Button(action: {
                }) {
                    Text("Sold Out")
                        .foregroundColor(.white)
                        .font(.system(size: 8))
                        .frame(width: 40, height: 12, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(5)
                }
            } else {
                if (self.disaster) {
                    Button(action: {
                    }) {
                        Text("Sold Out")
                            .foregroundColor(.white)
                            .font(.system(size: 8))
                            .frame(width: 40, height: 12, alignment: .center)
                            .background(Color.red)
                            .cornerRadius(5)
                    }
                } else {
                    Button(action: {
                        if (self.drinkBought.count < 10) {
                            self.myMoney = self.order(myMoney: self.myMoney, price: self.prices[index], drinkName: nameDrink, index: index)
                        }
                    }) {
                        Text("Buy $\(String(format: "%.1f", self.prices[index]))")
                            .foregroundColor(.black)
                            .font(.system(size: 8))
                            .frame(width: 40, height: 12, alignment: .center)
                            .background(Color(red: 168, green: 232, blue: 100))
                            .cornerRadius(5)
                    }
                }
            }
        }
    }

    fileprivate func eachDrinkWhenBought(num: Int, drinkName: String, color: Color, labelColor: Color) -> some View {
        return String(self.drinkBought2[num]) == drinkName ?
        Button(action: {

            if (num == 1) {
               
                self.drinkBought2.remove(at: num)
                self.drinkBought.remove(at: 0)
                self.rotation.remove(at: num)
            } else {
                do {
            if (self.disaster){
                self.drinkBought2.remove(at: num)
                                   self.drinkBought.remove(at: num - 1)
                                   self.rotation.remove(at: num)
            } else {
                self.drinkBought2.remove(at: num)
                                   self.drinkBought.remove(at: num)
                                   self.rotation.remove(at: num)
                    }
                   
                } catch {
                    self.drinkBought2.remove(at: num)
                    self.drinkBought.remove(at: -1)
                    self.rotation.remove(at: num)
                }

            }


        }) {
            drinkPlastic(capColor: color, drinkColor: color, type: 0, labelColor: labelColor)


        }

            : Button(action: { }) {
                drinkPlastic(capColor: color, drinkColor: color, type: 1, labelColor: labelColor)

        }

    }

    fileprivate func drinkPlastic(capColor: Color, drinkColor: Color, type: Int, labelColor: Color) -> some View {
        return
        ZStack (alignment: .bottom) {
            capColor
                .frame(width:
                        type == 1 ? 0:
                        8, height:
                        type == 1 ? 0:
                        45, alignment: .topLeading)
                .cornerRadius(2)
                .padding(.bottom,
                    type == 1 ? 0:
                        15)
            Ellipse()
                .fill(Color.white)
                .frame(width:
                        type == 1 ? 0:
                        24, height:
                        type == 1 ? 0:
                        45)
                .padding(.bottom,
                    type == 1 ? 0:
                        60)
                .frame(width:
                        type == 1 ? 0:
                        27, height:
                        type == 1 ? 0:
                        5)
            drinkColor
                .frame(width:
                        type == 1 ? 0:
                        24, height:
                        type == 1 ? 0:
                        41, alignment: .topLeading)
                .cornerRadius(4)
                .padding(.bottom, 0)

            drinkColor
                .frame(width:
                        type == 1 ? 0:
                        24, height:
                        type == 1 ? 0:
                        45, alignment: .topLeading)
                .cornerRadius(7)
            labelColor .frame(width:
                    type == 1 ? 0:
                    24, height:
                    type == 1 ? 0:
                    15, alignment: .topLeading)
                .padding(.bottom, 21.0)

        }
    }


    fileprivate func drinkCan(drinkColor: Color) -> some View {
        return drinkColor
            .frame(width: 30, height: 55, alignment: .topLeading)
            .cornerRadius(5)
  5  }

    var body: some View {

        return
        ZStack(alignment: .center) {
            self.disaster == true ?
            Image(uiImage: #imageLiteral(resourceName: "disaster.jpg"))


                .resizable()
                .aspectRatio(contentMode: .fill)
                :
                Image(uiImage: #imageLiteral(resourceName: "city.png"))


                .resizable()
                .aspectRatio(contentMode: .fill)

            VStack {
                VStack {



                    VStack(alignment: .center, spacing: 10) {

                        HStack(spacing: 24) {
                            extractedFunc(color: self.colaColor, nameDrink: "Cola", index: 0, type: 1, labelColor: self.colaLabelColor)
                            extractedFunc(color: self.colaColor, nameDrink: "Cola", index: 1, type: 1, labelColor: self.colaLabelColor)
                            extractedFunc(color: self.teaColor, nameDrink: "Tea", index: 2, type: 1, labelColor: self.teaLabelColor)

                            extractedFunc(color: self.orangeColor, nameDrink: "Orange", index: 3, type: 1, labelColor: self.orangeLabelColor)
                            extractedFunc(color: self.waterColor, nameDrink: "Water", index: 4, type: 1, labelColor: self.waterLabelColor)

                        }
                            .padding([.top, .leading, .trailing], 4.0)
                        Divider()
                        HStack(spacing: 24) {
                            extractedFunc(color: Color.blue, nameDrink: "Energy", index: 5, type: 1, labelColor: self.energyLabelColor)
                            extractedFunc(color: self.fantaColor
                                , nameDrink: "Fanta", index: 6, type: 1, labelColor: self.fantaLabelColor)
                            extractedFunc(color: Color.yellow, nameDrink: "Apple", index: 7, type: 1, labelColor: self.orangeLabelColor)
                            extractedFunc(color: self.orangeColor, nameDrink: "Orange", index: 8, type: 1, labelColor: self.orangeLabelColor)
                            extractedFunc(color: self.waterColor, nameDrink: "Water", index: 9, type: 1, labelColor: self.waterLabelColor)
                        }
                            .padding([.leading, .bottom, .trailing], 4.0)
                    }
                        .frame(height: 240.0)
                        .frame(maxWidth: .infinity)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(6)

                        .padding()

                    HStack () {
                        Spacer()
                       
                        Text(
                            "Emergency: get free drinks and Survive")
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(
                                self.count % 2 == 0 ?
                                Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255)
                                    :
                                    Color(red: 255 / 255, green: 95 / 255, blue: 105 / 255)
                            )

                            .multilineTextAlignment(.center)
                            .frame(width: 320, height: 28, alignment: .center)
                            .background(
                                !self.disaster ? Color(red: 248 / 255, green: 234 / 255, blue: 0 / 255).opacity(0.3)
                                    :
                                    Color(red: 248 / 255, green: 234 / 255, blue: 0 / 255)
                            )
                            .cornerRadius(3)
                        Spacer()
                    }

                    Divider()
                    HStack() {
                        VStack(alignment: .trailing) {
                            VStack {
//                            LinearGradient(gradient: Gradient(colors: [waterLabelColor, Color(red: 123 / 255, green: 218 / 255, blue: 239 / 255)]),
                                LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.yellow]), startPoint: .top,
                                    endPoint: .bottom)
                                    .mask(Text("          Disaster Rescue Vending Machine")
                                            .fontWeight(.heavy)
                                            .italic().padding(.bottom, 16.0)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                            .font(.custom("Rockwell", size: 25)).multilineTextAlignment(.leading))
                            }


//                        Text("        Disaster Rescue Vending Machine")
//                            .font(.custom("Rockwell", size: 25))
//                            .fontWeight(.bold)
//                            .italic()
//                            .padding(.bottom, 15.0)
                        }
                            .background(Color.red)
                            .frame(width: 161.0, height: 144.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(Color.black, lineWidth: 0.4)
                            )
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                VStack {
                                    Text(
                                        self.returned != true ? "Take":
                                            self.myMoney <= 0 ? "":
                                            "$\(String(format: "%.1f", self.myMoney))"
                                    )

                                        .font(.system(size: 10))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                        .padding(.bottom, 5.0)
                                } .frame(width: 42, height: 15, alignment: .center)
                                    .background(Color.black.opacity(0.3))
                                    .cornerRadius(5)
                                    .padding(.bottom, 6.0)

                                Button(action: {

                                    if (self.myMoney > 0) {
                                        self.returned = false
                                    }
                                    self.myMoney = 0

                                }) {

                                    Text("Return")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .font(.system(size: 8))
                                        .frame(width: 34, height: 15, alignment: .center)
                                        .background(Color.yellow.opacity(0.6))
                                        .cornerRadius(5)
                                        .padding(.bottom, 6.0)
                                }
                            }



                            VStack {

                                self.returned != false ? Button(action: {
                                    self.returned = true
                                    self.myMoney = 0
                                }) {
                                    ZStack {
                                        Circle()

                                            .fill(Color(red: 238 / 255, green: 233 / 255, blue: 171 / 255))
                                            .overlay(
                                                Circle()
                                                    .stroke(Color.black.opacity(0.2), lineWidth: 3)
                                            )
                                            .frame(width: 0, height: 0)

                                        VStack {

                                            Text("")
                                                .foregroundColor(.black) .padding(.top, 0)
                                                .font(.custom("Rockwell", size: 0))
                                        }
                                    }
                                        .rotation3DEffect(.degrees(30), axis: (x: 1, y: 0, z: 0))
                                }:
                                    Button(action: {
                                        self.returned = true
                                    }) {
                                        ZStack {
                                            Circle()

                                                .fill(Color(red: 238 / 255, green: 233 / 255, blue: 171 / 255))
                                                .overlay(
                                                    Circle()
                                                        .stroke(Color.black.opacity(0.2), lineWidth: 3)
                                                )
                                                .frame(width: 40, height: 40)

                                            VStack {

                                                Text("Money")
                                                    .foregroundColor(.black) .padding(.top, 8.0)
                                                    .font(.custom("Rockwell", size: 10))
                                            }
                                        }
                                            .rotation3DEffect(.degrees(30), axis: (x: 1, y: 0, z: 0))
                                }
                            } .frame(height: 55)
                                .frame(maxWidth: 70)
                                .background(Color.black.opacity(0.6))
                                .cornerRadius(8)
                        }
                    }
                        .padding(EdgeInsets(top: 70, leading: 20, bottom: 0, trailing: 20))
                        .frame(maxWidth: .infinity)
                        .frame(maxHeight: 100)

                    Spacer()
                    Group {
                        HStack() {
                            ForEach(0 ... self.drinkBought.count, id: \.self) { num in
                                Group {
                                    if 1 > 0 {
                                        VStack {
                                            ZStack {
                                                self.eachDrinkWhenBought(num: num, drinkName: "Cola", color: self.colaColor, labelColor: self.colaLabelColor)
                                                self.eachDrinkWhenBought(num: num, drinkName: "Fanta", color: self.fantaColor, labelColor: self.fantaLabelColor)

                                                self.eachDrinkWhenBought(num: num, drinkName: "Orange", color: self.orangeColor, labelColor: self.orangeLabelColor)
                                                self.eachDrinkWhenBought(num: num, drinkName: "Water", color: self.waterColor, labelColor: self.waterLabelColor)
                                                self.eachDrinkWhenBought(num: num, drinkName: "Energy", color: Color.blue, labelColor: Color.red)
                                                self.eachDrinkWhenBought(num: num, drinkName: "Apple", color: Color.yellow, labelColor: self.orangeLabelColor)
                                                self.eachDrinkWhenBought(num: num, drinkName: "Tea", color: self.teaColor, labelColor: self.teaLabelColor)
                                            }
                                                .rotationEffect(.degrees(Double(self.rotation[num])))
                                        }
                                    }

                                }
                            }
                        } .frame(height: 50)
                            .frame(width: 320)
                            .background(Color.black.opacity(0.6))
                            .cornerRadius(8)
                            .padding()
                    }

                }.frame(width: 350, height: 550, alignment:
                        .topLeading)
                    .background(Color.red)
                    .cornerRadius(8)

                VStack {
                    HStack {
                        Button(action: {
                            self.myMoney = self.myMoney + 1.0
                            print(self.myMoney)
                        }) {
                            VStack(alignment: .trailing) {
                                ZStack {
                                    Ellipse()
                                        .fill(Color.black.opacity(0.4)) .frame(height: 15)
                                        .frame(width: 11)
                                        .padding(.trailing, 51.0)
                                        .padding(.bottom, 12.0)
                                    Text("1")
                                        .foregroundColor(.white)
                                        .font(.custom("Rockwell", size: 13))
                                        .fontWeight(.heavy)
                                        .italic()
                                        .multilineTextAlignment(.leading)
                                        .padding(.trailing, 52.0)
                                        .padding(.bottom, 8.0)
                                    VStack (alignment: .center) {
                                        Spacer()

                                        Ellipse()

                                            .fill(Color.black.opacity(0.4)) .frame(height: 21)
                                            .frame(width: 17)
                                            .padding(.bottom, 2.0)


                                    }

                                        .frame(height: 35)
                                        .frame(width: 70)
                                        .border(Color.black.opacity(0.2), width: 3)
                                        .cornerRadius(2)
                                    Text("Money") .foregroundColor(.black) .padding(.bottom, 20.0)

                                        .font(.custom("Rockwell", size: 10))
                                        .padding(.top, 0)
                                    Text("$").foregroundColor(.white)
                                        .font(.system(size: 15))
                                        .padding(.top, 9.0)
                                }
                                    .frame(height: 15)
                            }


                                .frame(height: 40)
                                .frame(width: 75)
                                .background(Color(red: 238 / 255, green: 233 / 255, blue: 171 / 255))
                                .border(Color.black.opacity(0.2), width: 1)
                                .cornerRadius(2)
                        }

                        Button(action: {
                            self.myMoney = self.myMoney + 5.0
                            print(self.myMoney)
                        }) {
                            VStack(alignment: .trailing) {
                                ZStack {
                                    Ellipse()
                                        .fill(Color.black.opacity(0.4)) .frame(height: 15)
                                        .frame(width: 11)
                                        .padding(.trailing, 51.0)
                                        .padding(.bottom, 12.0)
                                    Text("5")
                                        .foregroundColor(.white)
                                        .font(.custom("Rockwell", size: 13))
                                        .fontWeight(.heavy)
                                        .italic()
                                        .multilineTextAlignment(.leading)
                                        .padding(.trailing, 52.0)
                                        .padding(.bottom, 8.0)
                                    VStack (alignment: .center) {
                                        Spacer()

                                        Ellipse()

                                            .fill(Color.black.opacity(0.4)) .frame(height: 21)
                                            .frame(width: 17)
                                            .padding(.bottom, 2.0)


                                    }

                                        .frame(height: 35)
                                        .frame(width: 70)
                                        .border(Color.black.opacity(0.2), width: 3)
                                        .cornerRadius(2)
                                    Text("Money") .foregroundColor(.black) .padding(.bottom, 20.0)

                                        .font(.custom("Rockwell", size: 10))
                                        .padding(.top, 0)
                                    Text("$").foregroundColor(.white)
                                        .font(.system(size: 15))
                                        .padding(.top, 9.0)
                                }
                                    .frame(height: 15)
                            }


                                .frame(height: 40)
                                .frame(width: 75)
                                .background(Color(red: 238 / 255, green: 233 / 255, blue: 171 / 255))
                                .border(Color.black.opacity(0.2), width: 1)
                                .cornerRadius(2)
                        }
                    }


                }
            }



        }
            .frame(width: 700, height: 1000)
//           .background(Color.black)




    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




////
PlaygroundPage.current.liveView = UIHostingController(rootView: ContentView())
