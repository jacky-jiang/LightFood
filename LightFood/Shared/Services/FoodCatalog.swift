import Foundation

/// Static sample data source for foods and recipes.
struct FoodCatalog: FoodCatalogProviding {

    private enum Image {
        static func url(_ id: String) -> URL? {
            URL(string: "https://images.unsplash.com/photo-\(id)?auto=format&fit=crop&w=320&q=70")
        }

        static let salad = url("1512621776951-a57141f2eefd")
        static let oat = url("1517673400267-0251440c45dc")
        static let egg = url("1482049016688-2d3e1b311543")
        static let rice = url("1516684732162-798a0062be99")
        static let banana = url("1571771894821-ce9b6c11b08e")
        static let yogurt = url("1488477181946-6428a0291777")
        static let chicken = url("1532550907401-a500c9a57435")
        static let salmon = url("1467003909585-2f8a72700288")
        static let broccoli = url("1459411621453-7b03977f4bfc")
        static let avocado = url("1541519227354-08fa5d50c44d")
        static let hero = URL(string: "https://images.unsplash.com/photo-1490645935967-10de6ba17061?auto=format&fit=crop&w=560&q=75")
    }

    static var heroImageURL: URL? { Image.hero }

    func foods() -> [Food] {
        [
            Food(id: "banana", name: "香蕉", kcalPer100g: 93, proteinPer100g: 1.4, fatPer100g: 0.4, carbsPer100g: 28.8, imageURL: Image.banana),
            Food(id: "rice", name: "米饭(白米饭)", kcalPer100g: 116, proteinPer100g: 2.6, fatPer100g: 0.3, carbsPer100g: 25.9, imageURL: Image.rice),
            Food(id: "yogurt", name: "酸奶(原味)", kcalPer100g: 72, proteinPer100g: 3.2, fatPer100g: 1.7, carbsPer100g: 9.3, imageURL: Image.yogurt),
            Food(id: "chicken", name: "鸡胸肉", kcalPer100g: 133, proteinPer100g: 22, fatPer100g: 1.5, carbsPer100g: 0, imageURL: Image.chicken),
            Food(id: "oat", name: "燕麦片", kcalPer100g: 389, proteinPer100g: 16, fatPer100g: 7, carbsPer100g: 66, imageURL: Image.oat),
            Food(id: "broccoli", name: "西兰花", kcalPer100g: 34, proteinPer100g: 2.8, fatPer100g: 0.4, carbsPer100g: 7, imageURL: Image.broccoli),
            Food(id: "avocado", name: "牛油果", kcalPer100g: 160, proteinPer100g: 2, fatPer100g: 15, carbsPer100g: 9, imageURL: Image.avocado),
            Food(id: "egg", name: "鸡蛋", kcalPer100g: 143, proteinPer100g: 13, fatPer100g: 10, carbsPer100g: 1, imageURL: Image.egg)
        ]
    }

    func recipes() -> [Recipe] {
        [
            Recipe(id: "avocado-chicken-salad", name: "牛油果鸡胸沙拉", kcal: 320, tags: ["推荐", "低脂"], description: "低脂高蛋白,饱腹感强,适合减脂期。", ingredients: ["鸡胸肉 120g", "牛油果 50g", "混合蔬菜 100g", "橄榄油 5g"], protein: 32, fat: 14, carbs: 18, imageURL: Image.salad),
            Recipe(id: "chicken-quinoa-salad", name: "鸡胸肉藜麦沙拉", kcal: 320, tags: ["推荐"], description: "高蛋白低卡,营养均衡,饱腹感强。", ingredients: ["鸡胸肉 100g", "藜麦 60g", "圣女果 50g", "柠檬汁 5g"], protein: 30, fat: 9, carbs: 28, imageURL: Image.chicken),
            Recipe(id: "salmon-veg", name: "香煎三文鱼配蔬菜", kcal: 450, tags: ["高蛋白"], description: "优质脂肪与蛋白,营养丰富。", ingredients: ["三文鱼 150g", "西兰花 100g", "芦笋 50g"], protein: 36, fat: 26, carbs: 12, imageURL: Image.salmon),
            Recipe(id: "greek-yogurt-cup", name: "希腊酸奶水果杯", kcal: 160, tags: ["低卡"], description: "低卡高蛋白,解馋无负担。", ingredients: ["希腊酸奶 150g", "蓝莓 30g", "燕麦 20g"], protein: 12, fat: 4, carbs: 22, imageURL: Image.yogurt)
        ]
    }
}
