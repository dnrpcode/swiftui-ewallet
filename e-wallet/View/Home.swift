//
//  ContentView.swift
//  e-wallet
//
//  Created by dani prayogi on 19/03/22.
//

import SwiftUI

struct Home: View {
    @State var expandCards: Bool = false
    
    //mark detail view properties
    @State var currentCard: Card?
    @State var showDetailCard: Bool = false
    @Namespace var animation
    
    var body: some View {
        VStack(spacing: 0){
            Text("Wallet").font(.largeTitle).fontWeight(.semibold).frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center).padding(.horizontal, 5).overlay(alignment: .trailing){
                    // close button
                    Button{
                        withAnimation(.interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)){
                            expandCards = false
                        }
                    } label: {
                        Image(systemName: "plus").foregroundColor(.white).padding(10).background(.blue, in: Circle())
                    }
                    .rotationEffect(.init(degrees: expandCards ? 45 : 0))
                    .offset(x: expandCards ? 10 : 15)
                    .opacity(expandCards ? 1 : 0)
                    .padding()
                    .padding(.bottom, 5)
                }
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 0){
                    ForEach(cards){ card in
                        Group{
                            if currentCard?.id == card.id &&
                                showDetailCard{
                                CardView(card: card).opacity(0)
                            }else{
                                CardView(card: card)
                                    .matchedGeometryEffect(id: card.id, in: animation)
                            }
                        }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.35)){
                                    currentCard = card
                                    showDetailCard = true
                                }
                            }
                    }
                }
                .overlay{
                    //To avoid scrolling
                    Rectangle()
                        .fill(.black.opacity(expandCards ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation(.easeIn(duration: 0.35)){
                                expandCards = true
                            }
                        }
                }
                .padding(.top, expandCards ? 30 : 0)
            }.coordinateSpace(name: "Scroll").offset(y: expandCards ? 0 : 30)
            // add button
            Button{
                
            } label: {
                Image(systemName: "plus").font(.title).foregroundColor(.white).padding(20).background(.blue, in: Circle())
            }
            .rotationEffect(.init(degrees: expandCards ? 180 : 0))
            // to avoid warning 0.01
            .scaleEffect(expandCards ? 0.01 : 1)
            .opacity(!expandCards ? 1 : 0)
            .frame(height: expandCards ? 0 : nil)
            .padding(.bottom, expandCards ? 0 : 30)
        }
            .padding([.top, .horizontal])
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay{
                if let currentCard = currentCard, showDetailCard {
                    DetailView(currentCard: currentCard, showDetailCard: $showDetailCard, animation:    animation)
                }
            }
    }
    
    @ViewBuilder
    func CardView(card: Card)-> some View{
        GeometryReader{proxy in
            
            let rect = proxy.frame(in: .named("Scroll"))
            let offset = CGFloat(getIndex(Card: card) * (expandCards ? 10: 40))
            ZStack(alignment:.bottomLeading){
                Image(card.cardImage).resizable().aspectRatio(contentMode: .fit).frame(width: 392, height: 230)
                
                VStack(alignment: .leading, spacing: 10){
                    Text(card.name).fontWeight(.bold)
                    Text(customiseCardNumber(number: card.cardNumber)).font(.callout).fontWeight(.bold)
                }
                .padding(.bottom, 30)
                .padding(.leading, 60)
                .foregroundColor(Color.white)
            }
            .offset(y: expandCards ? offset : -rect.minY +  offset)
        }.frame(height: 200)
    }
    
    //retreiving index
    func getIndex(Card: Card)->Int{
        return cards.firstIndex { currentCard in
            return currentCard.id == Card.id
        } ?? 0
    }
    
}

// global func format number
func customiseCardNumber(number: String)->String{
    
    var newValue: String = " "
    let maxCount = number.count - 4
    
    number.enumerated().forEach{ value in
        if value.offset >= maxCount{
            //displaying text
            let string = String(value.element)
            newValue.append(contentsOf: string)
        }else{
            //simply displaying star
            let string = String(value.element)
            if string == " "{
                newValue.append(contentsOf: " ")
            }else{
                newValue.append(contentsOf: "*")
            }
        }
    }
    
    return newValue
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

// Mark: detail View
struct DetailView: View {
    var currentCard: Card
    @Binding  var showDetailCard: Bool
    // macthed geometry effect
    var animation: Namespace.ID
    
    // delaying expenses
    @State var showExpensiveView: Bool = false
    
    var body: some View{
        VStack{
            CardView()
                .matchedGeometryEffect(id: currentCard.id, in: animation)
                .frame(height: 200)
                
                .onTapGesture {
                    //Closing Expenses View First
                    withAnimation(.easeInOut(duration: 0.35)){
                        showDetailCard = false
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                        withAnimation(.easeInOut(duration: 0.35)){
                            showDetailCard = false
                        }
                    }
                }.zIndex(10)
                
            
            GeometryReader{ proxy in
                
                let height = proxy.size.height + 50
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 20){
                        //expense
                        ForEach(expenses){ expense in
                            ExpenseaCardView(expense: expense)
                        }
                    }.padding()
                }
                .frame(maxWidth: .infinity)
                .background(
                    Color.white.clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous)).ignoresSafeArea()
                )
                .offset(y: showExpensiveView ? 0 : height)
            }
            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.cyan.ignoresSafeArea())
        .onAppear{
            withAnimation(.easeInOut.delay(0.1)){
                showExpensiveView = true
            }
        }
    }
    
    @ViewBuilder
    func CardView()-> some View{
        ZStack(alignment:.bottomLeading){
            Image(currentCard.cardImage).resizable().aspectRatio(contentMode: .fit).frame(width: 360, height: 230)
            
            VStack(alignment: .leading, spacing: 10){
                Text(currentCard.name).fontWeight(.bold)
                Text(customiseCardNumber(number: currentCard.cardNumber)).font(.callout).fontWeight(.bold)
            }
            .padding(.bottom, 35)
            .padding(.leading, 50)
            .foregroundColor(Color.white)
        }
    }
}

struct ExpenseaCardView: View{
    var expense: Expense
    // displaying expense by base on indes
    @State var showView: Bool=false
    var body: some View{
        HStack(spacing: 14){
            Image(expense.productIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 45)
            
            VStack(alignment: .leading, spacing: 8){
                Text(expense.product).fontWeight(.bold)
                Text(expense.spendType).font(.caption).foregroundColor(.gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(spacing: 8){
                Text(expense.amountSpent).fontWeight(.bold)
                Text(Date().formatted(date: .numeric, time: .omitted)).font(.caption).foregroundColor(.gray)
            }
        }
        .opacity(showView ? 1 : 0)
        .onAppear{
            //time taken for to show up
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                withAnimation(.easeInOut(duration: 0.3).delay(Double(getIndex()) * 0.1)){
                    showView = true
                }
            }
        }
    }
    
    func getIndex()->Int{
        return expenses.firstIndex { currentExpense in
            return expense.id == currentExpense.id
        } ?? 0
    }
}
