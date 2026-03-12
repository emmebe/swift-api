import SwiftUI

struct ContentView: View {
    @State private var pokemonName: String = ""
    @State private var pokemonImage: String = ""
    @State private var pokemonType: String = ""
    @State private var fortune: String = ""
    @State private var isLoading: Bool = false
    @State private var showFortune: Bool = false
    
    // Fortune messages based on Pokémon types
    let fortunes: [String: [String]] = [
        "fire": [
            "Today burns bright with opportunity! Your passion will ignite success.",
            "A spark of inspiration will lead to brilliant ideas today.",
            "Your energy is contagious - share your warmth with others!"
        ],
        "water": [
            "Go with the flow today - adaptability is your strength.",
            "Dive deep into your emotions and find clarity.",
            "A wave of good fortune is heading your way!"
        ],
        "grass": [
            "Today is perfect for growth and new beginnings.",
            "Plant the seeds of your dreams - they will flourish.",
            "Nature's wisdom guides you toward harmony today."
        ],
        "electric": [
            "Your ideas will spark excitement in others today!",
            "Channel your energy wisely - powerful things await.",
            "A shocking opportunity may appear out of nowhere!"
        ],
        "psychic": [
            "Trust your intuition today - it won't lead you astray.",
            "Your mind is particularly sharp - use it wisely.",
            "Deep thoughts lead to profound discoveries today."
        ],
        "normal": [
            "Sometimes the ordinary holds extraordinary potential.",
            "Balance and consistency will bring you peace today.",
            "Don't underestimate the power of small, steady progress."
        ],
        "fighting": [
            "Face your challenges head-on with courage today!",
            "Your strength lies in your determination.",
            "Victory comes to those who persevere - keep pushing!"
        ],
        "flying": [
            "Rise above the small stuff today - soar to new heights!",
            "Freedom and adventure call your name.",
            "Your perspective from above helps you see clearly."
        ],
        "poison": [
            "Be cautious with your words today - they have power.",
            "Transform negativity into strength.",
            "What seems toxic might just need the right approach."
        ],
        "ground": [
            "Stay grounded and focused on what truly matters.",
            "Your foundation is strong - build upon it confidently.",
            "Connect with the earth today for stability and peace."
        ],
        "rock": [
            "Your resilience is unshakeable today.",
            "Stand firm in your convictions - you are solid as stone.",
            "Patience and persistence will move mountains."
        ],
        "bug": [
            "Small efforts lead to big transformations today.",
            "Your hard work is about to pay off in unexpected ways.",
            "Community and teamwork bring success today."
        ],
        "ghost": [
            "Let go of the past - new beginnings await.",
            "Mystery surrounds you today - embrace the unknown.",
            "Your intuition about unseen forces is especially strong."
        ],
        "steel": [
            "Your determination is unbreakable today.",
            "Structure and organization lead to success.",
            "Your sharp mind cuts through confusion easily."
        ],
        "dragon": [
            "Your power is legendary today - use it wisely!",
            "Bold moves lead to extraordinary outcomes.",
            "Your inner strength inspires those around you."
        ],
        "dark": [
            "Trust your instincts in uncertain situations today.",
            "Your mysterious aura attracts interesting opportunities.",
            "Sometimes darkness reveals hidden truths."
        ],
        "fairy": [
            "Magic is in the air - believe in the impossible today!",
            "Your charm opens doors you didn't know existed.",
            "Spread joy and watch it return to you tenfold."
        ],
        "ice": [
            "Cool, calm, and collected - that's your approach today.",
            "Preserve what's important and let the rest melt away.",
            "Your clarity of thought is crystal clear today."
        ]
    ]
    
    var body: some View {
        ZStack {
            // Background gradient
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 1.0, green: 0.3, blue: 0.3),
                    Color(red: 1.0, green: 0.7, blue: 0.2)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                // Title
                VStack(spacing: 10) {
                    Text("✨ Daily Pokémon Fortune ✨")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("Discover your fortune through Pokémon!")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.9))
                }
                .padding(.top, 60)
                
                Spacer()
                
                if isLoading {
                    // Loading state
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                            .tint(.white)
                        Text("Summoning your Pokémon...")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                } else if showFortune {
                    // Show Pokémon and fortune
                    VStack(spacing: 25) {
                        // Pokémon card
                        VStack(spacing: 15) {
                            // Pokémon image
                            AsyncImage(url: URL(string: pokemonImage)) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200, height: 200)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            // Pokémon name
                            Text(pokemonName.capitalized)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                            
                            // Pokémon type
                            Text(pokemonType.capitalized + " Type")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(Color.white.opacity(0.2))
                                .cornerRadius(20)
                        }
                        .padding(30)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(25)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        // Fortune text
                        VStack(spacing: 15) {
                            Text("Your Fortune:")
                                .font(.headline)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Text(fortune)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        .padding(20)
                        .background(Color.white.opacity(0.15))
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
                        
                        // New fortune button
                        Button(action: getNewFortune) {
                            Text("Get New Fortune")
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 1.0, green: 0.3, blue: 0.3))
                                .padding(.horizontal, 30)
                                .padding(.vertical, 15)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 20)
                } else {
                    // Initial state - button to get fortune
                    VStack(spacing: 20) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 80))
                            .foregroundColor(.white)
                        
                        Text("Ready to discover your daily Pokémon fortune?")
                            .font(.title3)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                        
                        Button(action: getNewFortune) {
                            Text("Reveal My Fortune")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(Color(red: 1.0, green: 0.3, blue: 0.3))
                                .padding(.horizontal, 40)
                                .padding(.vertical, 20)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                }
                
                Spacer()
                
                // Footer
                Text("Powered by PokéAPI")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
                    .padding(.bottom, 20)
            }
        }
    }
    
    func getNewFortune() {
        isLoading = true
        showFortune = false
        
        // Generate random Pokémon ID (1-898)
        let randomID = Int.random(in: 1...898)
        
        // Fetch Pokémon data from API
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomID)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PokemonResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        // Set Pokémon data
                        self.pokemonName = result.name
                        self.pokemonImage = result.sprites.front_default ?? ""
                        self.pokemonType = result.types.first?.type.name ?? "normal"
                        
                        // Get random fortune for this type
                        if let fortuneList = self.fortunes[self.pokemonType] {
                            self.fortune = fortuneList.randomElement() ?? "Today is your lucky day!"
                        } else {
                            self.fortune = "Adventure awaits you today!"
                        }
                        
                        self.isLoading = false
                        self.showFortune = true
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.isLoading = false
                        print("Error decoding: \(error)")
                    }
                }
            }
        }.resume()
    }
}

// Data models for the Pokémon API
struct PokemonResponse: Codable {
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
}

struct Sprites: Codable {
    let front_default: String?
}

struct TypeElement: Codable {
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}

#Preview {
    ContentView()
} 