import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/recipe.dart';


 const DUMMY_CATEGORIES = const [
  Category(
    catId: 'c1',
    catTitle: 'Italian',
    catColor: Colors.purple, //Colors.primaries.elementAt(2),
  ),
  Category(
    catId: 'c2',
    catTitle: 'Quick & Easy',
    catColor: Colors.red,
  ),
  Category(
    catId: 'c3',
    catTitle: 'Hamburgers',
    catColor: Colors.orange,
  ),
  Category(
    catId: 'c4',
    catTitle: 'German',
    catColor: Colors.amber,
  ),
  Category(
    catId: 'c5',
    catTitle: 'Light & Lovely',
    catColor: Colors.blue,
  ),
  Category(
    catId: 'c6',
    catTitle: 'Exotic',
    catColor: Colors.green,
  ),
  Category(
    catId: 'c7',
    catTitle: 'Breakfast',
    catColor: Colors.lightBlue,
  ),
  Category(
    catId: 'c8',
    catTitle: 'Asian',
    catColor: Colors.lightGreen,
  ),
  Category(
    catId: 'c9',
    catTitle: 'French',
    catColor: Colors.pink,
  ),
  Category(
    catId: 'c10',
    catTitle: 'Summer',
    catColor: Colors.teal,
  ),
  Category(
    catId: 'c11',
    catTitle: 'Indian Curries',
    catColor: Colors.cyanAccent,
  ),
];


const DUMMY_RECIPES = const [
  Recipe(
    recipeId: 'm1',
    mappedCategoryIds: [
      'c1',
      'c2',
    ],
    recipeTitle: 'Spaghetti with Tomato Sauce',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg',
    cookingTime: 20,
    recipeIngredients: [
      '4 Tomatoes',
      '1 Tablespoon of Olive Oil',
      '1 Onion',
      '250g Spaghetti',
      'Spices',
      'Cheese (optional)'
    ],
    recipeSteps: [
      'Cut the tomatoes and the onion into small pieces.',
      'Boil some water - add salt to it once it boils.',
      'Put the spaghetti into the boiling water - they should be done in about 10 to 12 minutes.',
      'In the meantime, heaten up some olive oil and add the cut onion.',
      'After 2 minutes, add the tomato pieces, salt, pepper and your other spices.',
      'The sauce will be done once the spaghetti are.',
      'Feel free to add some cheese on top of the finished dish.'
    ],
    isRecipeGlutenFree: false,
    isRecipeVegan: true,
    isRecipeVegetarian: true,
    isRecipeLactoseFree: true,
  ),
  Recipe(
    recipeId: 'm2',
    mappedCategoryIds: [
      'c2',
    ],
    recipeTitle: 'Toast Hawaii',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2018/07/11/21/51/toast-3532016_1280.jpg',
    cookingTime: 10,
    recipeIngredients: [
      '1 Slice White Bread',
      '1 Slice Ham',
      '1 Slice Pineapple',
      '1-2 Slices of Cheese',
      'Butter'
    ],
    recipeSteps: [
      'Butter one side of the white bread',
      'Layer ham, the pineapple and cheese on the white bread',
      'Bake the toast for round about 10 minutes in the oven at 200°C'
    ],
    isRecipeGlutenFree: false,
    isRecipeVegan: false,
    isRecipeVegetarian: false,
    isRecipeLactoseFree: false,
  ),
  Recipe(
    recipeId: 'm3',
    mappedCategoryIds: [
      'c2',
      'c3',
    ],
    recipeTitle: 'Classic Hamburger',
    affordabilityOfRecipe: AffordabilityOfRecipe.Pricey,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2014/10/23/18/05/burger-500054_1280.jpg',
    cookingTime: 45,
    recipeIngredients: [
      '300g Cattle Hack',
      '1 Tomato',
      '1 Cucumber',
      '1 Onion',
      'Ketchup',
      '2 Burger Buns'
    ],
    recipeSteps: [
      'Form 2 patties',
      'Fry the patties for c. 4 minutes on each side',
      'Quickly fry the buns for c. 1 minute on each side',
      'Bruch buns with ketchup',
      'Serve burger with tomato, cucumber and onion'
    ],
    isRecipeGlutenFree: false,
    isRecipeVegan: false,
    isRecipeVegetarian: false,
    isRecipeLactoseFree: true,
  ),
  Recipe(
    recipeId: 'm4',
    mappedCategoryIds: [
      'c4',
    ],
    recipeTitle: 'Wiener Schnitzel',
    affordabilityOfRecipe: AffordabilityOfRecipe.Luxurious,
    cookingComplexity: CookingComplexity.Challenging,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2018/03/31/19/29/schnitzel-3279045_1280.jpg',
    cookingTime: 60,
    recipeIngredients: [
      '8 Veal Cutlets',
      '4 Eggs',
      '200g Bread Crumbs',
      '100g Flour',
      '300ml Butter',
      '100g Vegetable Oil',
      'Salt',
      'Lemon Slices'
    ],
    recipeSteps: [
      'Tenderize the veal to about 2–4mm, and salt on both sides.',
      'On a flat plate, stir the eggs briefly with a fork.',
      'Lightly coat the cutlets in flour then dip into the egg, and finally, coat in breadcrumbs.',
      'Heat the butter and oil in a large pan (allow the fat to get very hot) and fry the schnitzels until golden brown on both sides.',
      'Make sure to toss the pan regularly so that the schnitzels are surrounded by oil and the crumbing becomes ‘fluffy’.',
      'Remove, and drain on kitchen paper. Fry the parsley in the remaining oil and drain.',
      'Place the schnitzels on awarmed plate and serve garnishedwith parsley and slices of lemon.'
    ],
    isRecipeGlutenFree: false,
    isRecipeVegan: false,
    isRecipeVegetarian: false,
    isRecipeLactoseFree: false,
  ),
  Recipe(
    recipeId: 'm5',
    mappedCategoryIds: [
      'c2',
      'c5',
      'c10',
    ],
    recipeTitle: 'Salad with Smoked Salmon',
    affordabilityOfRecipe: AffordabilityOfRecipe.Luxurious,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2016/10/25/13/29/smoked-salmon-salad-1768890_1280.jpg',
    cookingTime: 15,
    recipeIngredients: [
      'Arugula',
      'Lamb\'s Lettuce',
      'Parsley',
      'Fennel',
      '200g Smoked Salmon',
      'Mustard',
      'Balsamic Vinegar',
      'Olive Oil',
      'Salt and Pepper',
    ],
    recipeSteps: [
      'Wash and cut salad and herbs',
      'Dice the salmon',
      'Process mustard, vinegar and olive oil into a dressing',
      'Prepare the salad',
      'Add salmon cubes and dressing'
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: false,
    isRecipeVegetarian: false,
    isRecipeLactoseFree: true,
  ),
  Recipe(
    recipeId: 'm6',
    mappedCategoryIds: [
      'c6',
      'c10',
    ],
    recipeTitle: 'Delicious Orange Mousse',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Hard,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2017/05/01/05/18/pastry-2274750_1280.jpg',
    cookingTime: 240,
    recipeIngredients: [
      '4 Sheets of Gelatine',
      '150ml Orange Juice',
      '80g Sugar',
      '300g Yoghurt',
      '200g Cream',
      'Orange Peel',
    ],
    recipeSteps: [
      'Dissolve gelatine in pot',
      'Add orange juice and sugar',
      'Take pot off the stove',
      'Add 2 tablespoons of yoghurt',
      'Stir gelatin under remaining yoghurt',
      'Cool everything down in the refrigerator',
      'Whip the cream and lift it under die orange mass',
      'Cool down again for at least 4 hours',
      'Serve with orange peel',
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: false,
    isRecipeVegetarian: true,
    isRecipeLactoseFree: false,
  ),
  Recipe(
    recipeId: 'm7',
    mappedCategoryIds: [
      'c7',
    ],
    recipeTitle: 'Pancakes',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2018/07/10/21/23/pancake-3529653_1280.jpg',
    cookingTime: 20,
    recipeIngredients: [
      '1 1/2 Cups all-purpose Flour',
      '3 1/2 Teaspoons Baking Powder',
      '1 Teaspoon Salt',
      '1 Tablespoon White Sugar',
      '1 1/4 cups Milk',
      '1 Egg',
      '3 Tablespoons Butter, melted',
    ],
    recipeSteps: [
      'In a large bowl, sift together the flour, baking powder, salt and sugar.',
      'Make a well in the center and pour in the milk, egg and melted butter; mix until smooth.',
      'Heat a lightly oiled griddle or frying pan over medium high heat.',
      'Pour or scoop the batter onto the griddle, using approximately 1/4 cup for each pancake. Brown on both sides and serve hot.',
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: false,
    isRecipeVegetarian: true,
    isRecipeLactoseFree: false,
  ),
  Recipe(
    recipeId: 'm8',
    mappedCategoryIds: [
      'c8',
    ],
    recipeTitle: 'Creamy Indian Chicken Curry',
    affordabilityOfRecipe: AffordabilityOfRecipe.Pricey,
    cookingComplexity: CookingComplexity.Challenging,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2018/06/18/16/05/indian-food-3482749_1280.jpg',
    cookingTime: 35,
    recipeIngredients: [
      '4 Chicken Breasts',
      '1 Onion',
      '2 Cloves of Garlic',
      '1 Piece of Ginger',
      '4 Tablespoons Almonds',
      '1 Teaspoon Cayenne Pepper',
      '500ml Coconut Milk',
    ],
    recipeSteps: [
      'Slice and fry the chicken breast',
      'Process onion, garlic and ginger into paste and sauté everything',
      'Add spices and stir fry',
      'Add chicken breast + 250ml of water and cook everything for 10 minutes',
      'Add coconut milk',
      'Serve with rice'
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: false,
    isRecipeVegetarian: false,
    isRecipeLactoseFree: true,
  ),
  Recipe(
    recipeId: 'm9',
    mappedCategoryIds: [
      'c9',
    ],
    recipeTitle: 'Chocolate Souffle',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Hard,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2014/08/07/21/07/souffle-412785_1280.jpg',
    cookingTime: 45,
    recipeIngredients: [
      '1 Teaspoon melted Butter',
      '2 Tablespoons white Sugar',
      '2 Ounces 70% dark Chocolate, broken into pieces',
      '1 Tablespoon Butter',
      '1 Tablespoon all-purpose Flour',
      '4 1/3 tablespoons cold Milk',
      '1 Pinch Salt',
      '1 Pinch Cayenne Pepper',
      '1 Large Egg Yolk',
      '2 Large Egg Whites',
      '1 Pinch Cream of Tartar',
      '1 Tablespoon white Sugar',
    ],
    recipeSteps: [
      'Preheat oven to 190°C. Line a rimmed baking sheet with parchment paper.',
      'Brush bottom and sides of 2 ramekins lightly with 1 teaspoon melted butter; cover bottom and sides right up to the rim.',
      'Add 1 tablespoon white sugar to ramekins. Rotate ramekins until sugar coats all surfaces.',
      'Place chocolate pieces in a metal mixing bowl.',
      'Place bowl over a pan of about 3 cups hot water over low heat.',
      'Melt 1 tablespoon butter in a skillet over medium heat. Sprinkle in flour. Whisk until flour is incorporated into butter and mixture thickens.',
      'Whisk in cold milk until mixture becomes smooth and thickens. Transfer mixture to bowl with melted chocolate.',
      'Add salt and cayenne pepper. Mix together thoroughly. Add egg yolk and mix to combine.',
      'Leave bowl above the hot (not simmering) water to keep chocolate warm while you whip the egg whites.',
      'Place 2 egg whites in a mixing bowl; add cream of tartar. Whisk until mixture begins to thicken and a drizzle from the whisk stays on the surface about 1 second before disappearing into the mix.',
      'Add 1/3 of sugar and whisk in. Whisk in a bit more sugar about 15 seconds.',
      'whisk in the rest of the sugar. Continue whisking until mixture is about as thick as shaving cream and holds soft peaks, 3 to 5 minutes.',
      'Transfer a little less than half of egg whites to chocolate.',
      'Mix until egg whites are thoroughly incorporated into the chocolate.',
      'Add the rest of the egg whites; gently fold into the chocolate with a spatula, lifting from the bottom and folding over.',
      'Stop mixing after the egg white disappears. Divide mixture between 2 prepared ramekins. Place ramekins on prepared baking sheet.',
      'Bake in preheated oven until scuffles are puffed and have risen above the top of the rims, 12 to 15 minutes.',
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: false,
    isRecipeVegetarian: true,
    isRecipeLactoseFree: false,
  ),
  Recipe(
    recipeId: 'm10',
    mappedCategoryIds: [
      'c2',
      'c5',
      'c10',
    ],
    recipeTitle: 'Asparagus Salad with Cherry Tomatoes',
    affordabilityOfRecipe: AffordabilityOfRecipe.Luxurious,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://cdn.pixabay.com/photo/2018/04/09/18/26/asparagus-3304997_1280.jpg',
    cookingTime: 30,
    recipeIngredients: [
      'White and Green Asparagus',
      '30g Pine Nuts',
      '300g Cherry Tomatoes',
      'Salad',
      'Salt, Pepper and Olive Oil'
    ],
    recipeSteps: [
      'Wash, peel and cut the asparagus',
      'Cook in salted water',
      'Salt and pepper the asparagus',
      'Roast the pine nuts',
      'Halve the tomatoes',
      'Mix with asparagus, salad and dressing',
      'Serve with Baguette'
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: true,
    isRecipeVegetarian: true,
    isRecipeLactoseFree: true,
  ),
  Recipe(
    recipeId: 'm11',
    mappedCategoryIds: [
      'c11',
    ],
    recipeTitle: 'Cashew Chicken Curry',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'http://4.bp.blogspot.com/-UMPSiNuJtlA/Ua66v1i4MbI/AAAAAAAACbQ/coqUWk_KT44/s1600/DSC_4429.JPG',
    cookingTime: 35,
    recipeIngredients: [
      '1/2 kg of chicken',
      '1/2 cup of cashew',
      '1 medium sized onion',
      '2 spoons chicken masala powder',
      '1 spoon ginger garlic',
      '1/2 spoon of garam masala',
      '2 spoons of cashew paste',
      '4 spoons of oil',
      'salt to taste',
      '1 spoon of chilli powder',
      '1/2 cup corriander leaves',
      '1 small lemon',
      '1 tomato',
      '1 green chilli',
    ],
    recipeSteps: [
      'Wash chicken and marinate with salt, chilli powder and lemon juice.',
      'Keep the marinated chicken aside for 1 hour',
      'Heat up oil in a skillet and saute cut onions until lightly brown along with cashew.',
      'Once onions are brown, put chicken in to the skillet and start cooking it.',
      'Add chicken masala powder, ginger garlic paste, finely chopped tomato and green chilli.',
      'Cover the skillet with its lid and let the ingredients cook for 2 minutes on low temperature setting only.',
      'Add 1.5 cups of water and cook for 20 minutes again on low temperature setting.',
      'Now, add cashew paste, garam masala and corriander leaves and continue cooking for 10 more minutes with the same settings.',
      'Garnish with fried cashew and corriander leaves and serve the yummy hot chicken curry.'
    ],
    isRecipeGlutenFree: true,
    isRecipeVegan: false,
    isRecipeVegetarian: false,
    isRecipeLactoseFree: true,
  ),
  Recipe(
    recipeId: 'm12',
    mappedCategoryIds: [
      'c7',
    ],
    recipeTitle: 'Carrot Idli',
    affordabilityOfRecipe: AffordabilityOfRecipe.Affordable,
    cookingComplexity: CookingComplexity.Simple,
    recipeImageUrl:
        'https://www.sailusfood.com/wp-content/uploads/2012/11/carrot-idli.jpg',
    cookingTime: 10,
    recipeIngredients: [
      'Minapappu 1 cup',
      'Raw boiled rice ravva 2.5 cups',
      'Salt to taste',
      '1 small carrot',
    ],
    recipeSteps: [
      'Soak minapappu in water for 4-5 hours',
      'Wash throurougly after soak. Can also do it before soaking',
      'Wash and keep aside ravva.'
      'Grind minapappu until it is fine-grained and mashed-up',
      'Mix ravva with the grinded minapappu and add salt to your taste.'
      'Keep the final mixture aside for atleast 5 hours. Normally, it is done during night and used in the morning.'
      'When ready, peel 1 small carrot with a peeler. Take idli plates and apply ghee to the cast for better taste.'
      'Then add the peel to the plates and put in the flour mix to be cooked for 10 minutes',
      'After 10 minutes delicious idli will be ready for your to eat !',
    ],
    isRecipeGlutenFree: false,
    isRecipeVegan: false,
    isRecipeVegetarian: true,
    isRecipeLactoseFree: true,
  ),
];

