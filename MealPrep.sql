DROP TABLE IF EXISTS saves;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Rating;
DROP TABLE IF EXISTS listContains;
DROP TABLE IF EXISTS ShoppingList;
DROP TABLE IF EXISTS mealPlanContains;
DROP TABLE IF EXISTS recipeContains;
DROP TABLE IF EXISTS nutritionInfoIngredient;
DROP TABLE IF EXISTS nutritionInfoRecipe;
DROP TABLE IF EXISTS SugarFreeRecipe;
DROP TABLE IF EXISTS LowCalorieRecipe;
DROP TABLE IF EXISTS VegetarianRecipe;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS MealPlan;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS User;


CREATE TABLE User (
    userID INTEGER,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    PRIMARY KEY (userID)
);

CREATE TABLE Ingredient (
    name VARCHAR(50),
    isVegetarian BOOLEAN,
    PRIMARY KEY (name)
);

CREATE TABLE Recipe (
    recipeID INTEGER,
    name VARCHAR(50) NOT NULL,
    instructions TEXT,
    PRIMARY KEY (recipeID)
);

CREATE TABLE MealPlan (
    mealPlanID INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    date DATE,
    userID INTEGER,
    FOREIGN KEY (userID) REFERENCES User(userID)
);


CREATE TABLE Category (
    name VARCHAR(50),
    category VARCHAR(50) NOT NULL,
    PRIMARY KEY (name)
);

CREATE TABLE VegetarianRecipe (
    recipeID INTEGER,
    PRIMARY KEY (recipeID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE LowCalorieRecipe (
    recipeID INTEGER,
    PRIMARY KEY (recipeID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

CREATE TABLE SugarFreeRecipe (
    recipeID INTEGER,
    PRIMARY KEY (recipeID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);


CREATE TABLE nutritionInfoRecipe (
    recipeID INTEGER,
    calories INTEGER,
    sugar INTEGER CHECK (sugar >= 0),
    proteinContent INTEGER CHECK (proteinContent >= 0),
    fatContent INTEGER CHECK (fatContent >= 0),
    carbContent INTEGER CHECK (carbContent >= 0),
    PRIMARY KEY (recipeID),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE nutritionInfoIngredient (
    ingredientName VARCHAR(50),
    calories INTEGER,
    sugar INTEGER CHECK (sugar >= 0),
    proteinContent INTEGER CHECK (proteinContent >= 0),
    fatContent INTEGER CHECK (fatContent >= 0),
    carbContent INTEGER CHECK (carbContent >= 0),
    PRIMARY KEY (ingredientName),
    FOREIGN KEY (ingredientName) REFERENCES Ingredient(name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE recipeContains (
    recipeID INTEGER,
    ingredientName VARCHAR(50),
    PRIMARY KEY (recipeID, ingredientName),
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID) 
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ingredientName) REFERENCES Ingredient(name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE mealPlanContains (
    mealPlanID INTEGER,
    recipeID INTEGER,
    PRIMARY KEY (mealPlanID, recipeID),
    FOREIGN KEY (mealPlanID) REFERENCES MealPlan(mealPlanID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE ShoppingList (
    shoppingListID INTEGER,
    mealPlanID INTEGER,
    PRIMARY KEY (shoppingListID),
    FOREIGN KEY (mealPlanID) REFERENCES MealPlan(mealPlanID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


CREATE TABLE listContains (
    shoppingListID INTEGER,
    ingredientName VARCHAR(50),
    PRIMARY KEY (shoppingListID, ingredientName),
    FOREIGN KEY (shoppingListID) REFERENCES ShoppingList(shoppingListID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ingredientName) REFERENCES Ingredient(name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);



CREATE TABLE Rating (
    ratingID INTEGER,
    score INTEGER CHECK (0 <= score AND score <= 5),
    userID INTEGER,
    recipeID INTEGER,
    PRIMARY KEY (ratingID),
    UNIQUE (userID, recipeID),
    FOREIGN KEY (userID) REFERENCES User(userID)
        ON DELETE CASCADE,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON DELETE CASCADE
);

CREATE TABLE Review (
    reviewID INTEGER,
    date DATE,
    message VARCHAR(500),
    userID INTEGER NOT NULL,
    recipeID INTEGER,
    PRIMARY KEY (reviewID),
    UNIQUE (userID, recipeID),
    FOREIGN KEY (userID) REFERENCES User(userID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE saves (
    userID INTEGER,
    recipeID INTEGER,
    PRIMARY KEY (userID, recipeID),
    FOREIGN KEY (userID) REFERENCES User(userID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (recipeID) REFERENCES Recipe(recipeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);


INSERT INTO User (userID, name, email, username) VALUES
(1, 'Joe', 'joe@email.com', 'joe'),
(2, 'Jay', 'jay@email.com', 'jay'),
(3, 'Kohen', 'kohen@email.com', 'kohen'),
(4, 'George', 'george@email.com', 'george'),
(5, 'Jeff', 'jeff@email.com', 'jeff'),
(6, 'Alice', 'alice@email.com', 'alice'),
(7, 'Bob', 'bob@email.com', 'bob'),
(8, 'Jimbo', 'jimbo@email.com', 'Jimbo'),
(9, 'Lebron', 'lebron@email.com', 'lebron'),
(10, 'Emily', 'emily@email.com', 'emily'),
(11, 'Frank', 'frank@email.com', 'frank'),
(12, 'Grace', 'grace@email.com', 'grace');


INSERT INTO Ingredient (name, isVegetarian) VALUES
('Rice', TRUE),
('Noodles', TRUE),
('Salt', TRUE),
('Beef', FALSE),
('Chicken', FALSE),
('Tomato', TRUE),
('Cheese', TRUE),
('Quinoa', TRUE),
('Lettuce', TRUE),
('Pepper', TRUE),
('Dough', TRUE),
('Olive Oil', TRUE),
('Pepperoni', FALSE);

INSERT INTO Recipe (recipeID, name, instructions) VALUES
(1, 'Pizza', 
'Ingredients:
1 pizza dough 
1/2 cup pizza sauce 
30 pepperoni slices
2 cups shredded mozzarella cheese
2-3 fresh tomatoes, thinly sliced
Fresh basil leaves
Extra virgin olive oil
Salt and pepper to taste
Instructions:
Preheat your oven to the highest temperature it can go (usually around 475°F to 500°F). If you have a pizza stone, place it in the oven to preheat as well.

Roll out your pizza dough on a floured surface to your desired thickness.

Transfer the rolled-out dough to a pizza peel or a baking sheet lined with parchment paper.

Spread the pizza sauce evenly over the dough, leaving a small border around the edges.

Sprinkle the shredded mozzarella cheese over the sauce.

Arrange the sliced tomatoes on top of the cheese.

Drizzle a little extra virgin olive oil over the pizza and season with salt and pepper.

If using a pizza stone, carefully transfer the pizza from the peel to the hot stone in the oven. If using a baking sheet, place it directly in the oven.

Bake for about 10-12 minutes, or until the crust is golden brown and the cheese is bubbly and slightly browned.

Remove the pizza from the oven and immediately top with fresh basil leaves.

Let the pizza cool for a few minutes, then slice and serve.'),
(2, 'Pasta',
 'Ingredients:
8 oz spaghetti (or any long pasta)
4 cloves garlic, thinly sliced
1/4 cup extra virgin olive oil
1/4 teaspoon red pepper flakes (optional)
Salt, to taste
Freshly grated Parmesan cheese (optional)
Fresh parsley, chopped (optional)
Instructions:

Cook the spaghetti in a large pot of salted boiling water according to the package instructions until al dente.

While the pasta is cooking, heat the olive oil in a large pan over medium heat. Add the sliced garlic and red pepper flakes (if using) and sauté for 1-2 minutes, or until the garlic is lightly golden and fragrant. Be careful not to burn the garlic.

Drain the cooked pasta, reserving about 1/4 cup of the pasta water.

Add the drained pasta to the pan with the garlic and olive oil. Toss well to coat the pasta in the oil, adding a little reserved pasta water if needed to help the sauce cling to the pasta.

Season with salt to taste.

Serve the pasta hot, sprinkled with freshly grated Parmesan cheese and chopped parsley if desired.'),
(3, 'Burger',
 'Ingredients:

1 lb ground beef (80% lean, 20% fat)
Salt and pepper, to taste
4 burger buns
Optional toppings: lettuce, tomato slices, onion slices, pickles, cheese slices, ketchup, mustard, mayonnaise
Instructions:

Preheat your grill or a skillet over medium-high heat.

Divide the ground beef into 4 equal portions and form each into a patty about 3/4-inch thick. Make a small indentation in the center of each patty with your thumb to prevent it from puffing up during cooking.

Season both sides of each patty with salt and pepper.

Place the patties on the grill or in the skillet and cook for about 3-4 minutes on each side for medium-rare, or longer if you prefer your burgers more well-done.

 place a slice of cheese on each patty during the last minute of cooking to allow it to melt.

While the burgers are cooking, you can toast the buns on the grill or in a toaster if desired.

Assemble the burgers by placing a patty on the bottom half of each bun. Add your favorite toppings and condiments, then cover with the top half of the bun.'),
(4, 'Fries', 
'Ingredients:

4 large potatoes (Russet or Yukon Gold work well)
Vegetable oil, for frying
Salt, to taste
Instructions:

Peel the potatoes and cut them into long, thin strips about 1/4-inch thick. Try to keep the size and thickness of the fries as uniform as possible for even cooking.

Rinse the cut potatoes in cold water to remove excess starch, then pat them dry with paper towels.

Fill a large, heavy-bottomed pot or deep fryer with about 2-3 inches of vegetable oil. Heat the oil to 325°F (163°C) using a deep-fry thermometer to check the temperature.

Carefully add the fries to the hot oil in small batches, being careful not to overcrowd the pot. Fry for about 3-4 minutes, or until they are soft but not browned. This is called "blanching" and helps to cook the potatoes without browning them.

Remove the fries from the oil with a slotted spoon and drain them on a paper towel-lined plate or baking sheet. Let them cool for a few minutes.

Increase the temperature of the oil to 375°F (190°C).

Return the fries to the hot oil in batches and fry again for 3-4 minutes, or until they are golden brown and crispy.

Remove the fries from the oil, drain them on fresh paper towels, and season with salt while they are still hot.'),
(5, 'Grilled Cheese Sandwich', 'Ingredients:

2 slices of bread (white, whole wheat, or any type you prefer)
2 slices of cheese (Cheddar, American, Swiss, or your favorite cheese)
Butter or mayonnaise
Optional: tomato slices, ham, bacon, or any other additional fillings
Instructions:

Butter one side of each bread slice. If you prefer, you can use mayonnaise instead of butter for a different flavor and to help the bread achieve a golden brown color when grilled.

Place one slice of cheese on the unbuttered side of one slice of bread. If youre adding any additional fillings, layer them on top of the cheese. Place the second slice of cheese on top of the fillings, then cover with the second slice of bread, buttered side facing out.

Heat a skillet or griddle over medium heat. Once hot, place the sandwich in the skillet.

Grill the sandwich for about 2-3 minutes on each side, or until the bread is golden brown and the cheese is melted. Press down lightly with a spatula for even grilling, but be careful not to flatten the sandwich too much.

Remove the sandwich from the skillet and let it cool for a minute before cutting it in half.'),
(6, 'Salad',
 'Ingredients:

4 cups mixed salad greens (such as lettuce, spinach, arugula, or your favorite mix)
1/2 cup cherry tomatoes, halved
1/4 cup cucumber, sliced
1/4 cup red onion, thinly sliced
1/4 cup carrots, shredded
In a large salad bowl, combine the mixed salad greens, cherry tomatoes, cucumber, red onion, and carrots. Toss gently to mix.

In a small bowl or jar, whisk together the olive oil, vinegar, Dijon mustard, honey (if using), salt, and pepper until well combined. This is your vinaigrette dressing.

Just before serving, drizzle the vinaigrette over the salad and toss gently to coat the greens evenly. Adjust the seasoning if needed.

Top the salad with croutons if desired.

Serve the salad immediately as a fresh and healthy side dish or light meal. Enjoy!'),
(7, 'Vegetarian Pasta',
 'Ingredients:

8 oz (225g) pasta (such as penne, spaghetti, or fettuccine)
2 tablespoons olive oil
2 cloves garlic, minced
1 bell pepper, sliced
1 zucchini, sliced
1 cup cherry tomatoes, halved
1/2 cup marinara sauce or tomato sauce
Salt and pepper, to taste
1/4 cup fresh basil leaves, chopped
Grated Parmesan cheese, for serving (optional)
Instructions:

Cook the pasta according to the package instructions in a large pot of salted boiling water until al dente. Drain and set aside.

In a large skillet, heat the olive oil over medium heat. Add the minced garlic and cook for about 1 minute until fragrant.

Add the sliced bell pepper and zucchini to the skillet. Cook for 4-5 minutes, or until the vegetables start to soften.

Stir in the cherry tomatoes and cook for another 2-3 minutes until they start to release their juices.

Add the marinara sauce to the skillet and season with salt and pepper. Stir to combine and let the sauce simmer for a couple of minutes.

Add the cooked pasta to the skillet and toss everything together until the pasta is well coated with the sauce and vegetables.

Remove from heat and sprinkle with fresh chopped basil.

Serve the vegetarian pasta hot, garnished with grated Parmesan cheese if desired. Enjoy!'),
(8, 'Vegetarian Pizza', 'Ingredients:

1 pizza dough (store-bought or homemade)
1/2 cup pizza sauce (store-bought or homemade)
2 cups shredded mozzarella cheese
1/2 cup sliced bell peppers (any color)
1/2 cup sliced mushrooms
1/4 cup sliced red onions
1/4 cup black olives, sliced
1/4 cup cherry tomatoes, halved
1/4 cup spinach leaves
2 tablespoons extra virgin olive oil
Salt and pepper, to taste
Optional: crushed red pepper flakes, dried oregano, or fresh basil leaves for garnish
Instructions:

Preheat your oven to 475°F (245°C). If you have a pizza stone, place it in the oven to preheat as well.

Roll out your pizza dough on a floured surface to your desired thickness.

Transfer the rolled-out dough to a pizza peel or a baking sheet lined with parchment paper.

Spread the pizza sauce evenly over the dough, leaving a small border around the edges.

Sprinkle the shredded mozzarella cheese over the sauce.

Arrange the sliced bell peppers, mushrooms, red onions, black olives, cherry tomatoes, and spinach leaves evenly over the cheese.

Drizzle the olive oil over the toppings and season with salt and pepper.

If using a pizza stone, carefully transfer the pizza from the peel to the hot stone in the oven. If using a baking sheet, place it directly in the oven.

Bake for about 10-12 minutes, or until the crust is golden brown and the cheese is bubbly and slightly browned.

Remove the pizza from the oven and let it cool for a few minutes. If desired, sprinkle with crushed red pepper flakes, dried oregano, or garnish with fresh basil leaves.'),
(9, 'Vegetarian Burger', 
'Ingredients:

1 can (15 oz) black beans, drained and rinsed
1/2 cup breadcrumbs
1/4 cup finely chopped onion
1/4 cup finely grated carrot
2 cloves garlic, minced
1 teaspoon ground cumin
1/2 teaspoon smoked paprika
Salt and pepper, to taste
1 egg, beaten
2 tablespoons olive oil
4 burger buns
Lettuce, tomato, avocado, and other desired toppings
Instructions:

In a large bowl, mash the black beans with a fork or a potato masher until they are mostly broken down but still have some texture.

Add the breadcrumbs, onion, carrot, garlic, cumin, smoked paprika, salt, and pepper to the mashed beans. Mix well to combine.

Stir in the beaten egg until the mixture is well combined. If the mixture is too wet, you can add a little more breadcrumbs.

Divide the mixture into four equal portions and shape each portion into a burger patty.

Heat the olive oil in a large skillet over medium heat. Once hot, add the burger patties to the skillet.

Cook the patties for about 4-5 minutes on each side, or until they are nicely browned and heated through.

Toast the burger buns, if desired, and assemble the burgers with lettuce, tomato, avocado slices, and any other toppings you like.'),
(10, 'Quinoa', 'Ingredients:

1 cup quinoa
2 cups water or vegetable broth
1/2 teaspoon salt (optional)
Instructions:

Rinse the quinoa: Place the quinoa in a fine-mesh strainer and rinse it under cold running water for a minute or two. This helps to remove the natural coating called saponin, which can give quinoa a bitter taste.

Combine quinoa and liquid: In a medium saucepan, combine the rinsed quinoa, water (or vegetable broth), and salt (if using).

Bring to a boil: Bring the mixture to a boil over medium-high heat.

Reduce heat and simmer: Once boiling, reduce the heat to low, cover the saucepan with a lid, and let it simmer for about 15 minutes, or until the quinoa is cooked and has absorbed all the liquid. Youll know its done when the quinoa is tender and you can see little tails sprouting from the grains.

Rest and fluff: Remove the saucepan from heat and let it sit, covered, for 5 minutes. This allows the quinoa to steam and fluff up. After 5 minutes, remove the lid and fluff the quinoa with a fork.

Serve: Use the cooked quinoa as a base for salads, as a side dish, or in any recipe that calls for cooked quinoa. Enjoy!'),
(11, 'Low Calorie Pizza',
 'Ingredients:

1 whole wheat or cauliflower pizza crust (about 12 inches)
1/2 cup marinara sauce
1 cup shredded part-skim mozzarella cheese
1 cup sliced vegetables (e.g., bell peppers, onions, mushrooms, spinach, zucchini)
1/2 teaspoon dried oregano
1/2 teaspoon dried basil
Salt and pepper, to taste
Fresh basil leaves for garnish (optional)
Instructions:

Preheat your oven to the temperature specified on the pizza crust package (usually around 425°F or 220°C).

Place the pizza crust on a baking sheet or pizza stone.

Spread the marinara sauce evenly over the crust, leaving a small border around the edges.

Sprinkle the shredded mozzarella cheese over the sauce.

Arrange your sliced vegetables on top of the cheese. Try to distribute them evenly for better cooking and flavor.

Season the pizza with dried oregano, dried basil, salt, and pepper.

Bake the pizza in the preheated oven for about 10-15 minutes, or until the cheese is melted and bubbly and the crust is golden brown.

Remove the pizza from the oven and let it cool for a few minutes before slicing.

Garnish with fresh basil leaves if desired.

Serve and enjoy your low-calorie pizza!'),
(12, 'Low Calorie Pasta',
 'Ingredients:

8 oz (225g) whole wheat or chickpea pasta
2 cups cherry tomatoes, halved
2 cloves garlic, minced
1 tablespoon olive oil
2 cups spinach leaves
1/4 cup fresh basil, chopped
Salt and pepper, to taste
Grated Parmesan cheese (optional, for serving)
Instructions:

Cook the pasta according to the package instructions in a large pot of boiling salted water until al dente. Drain and set aside.

While the pasta is cooking, heat the olive oil in a large skillet over medium heat. Add the minced garlic and sauté for about 1 minute until fragrant.

Add the cherry tomatoes to the skillet and cook for 2-3 minutes until they start to soften.

Stir in the spinach leaves and cook for another 1-2 minutes until they wilt.

Add the cooked pasta to the skillet with the vegetables. Toss everything together to combine. Season with salt and pepper to taste.

Remove from heat and stir in the fresh chopped basil.

Serve the pasta in bowls, optionally topped with grated Parmesan cheese. Enjoy your low-calorie pasta dish!'),
(13, 'Sugar Free Pizza', 'Ingredients:

1 sugar-free whole wheat or cauliflower pizza crust (about 12 inches)
1/2 cup sugar-free tomato sauce (check the label to ensure its sugar-free)
1 cup shredded part-skim mozzarella cheese
1 cup sliced vegetables (e.g., bell peppers, onions, mushrooms, spinach, zucchini)
1/2 teaspoon dried oregano
1/2 teaspoon dried basil
Salt and pepper, to taste
Fresh basil leaves for garnish (optional)
Instructions:

Preheat your oven to the temperature specified on the pizza crust package (usually around 425°F or 220°C).

Place the pizza crust on a baking sheet or pizza stone.

Spread the sugar-free tomato sauce evenly over the crust, leaving a small border around the edges.

Sprinkle the shredded mozzarella cheese over the sauce.

Arrange your sliced vegetables on top of the cheese. Try to distribute them evenly for better cooking and flavor.

Season the pizza with dried oregano, dried basil, salt, and pepper.

Bake the pizza in the preheated oven for about 10-15 minutes, or until the cheese is melted and bubbly and the crust is golden brown.

Remove the pizza from the oven and let it cool for a few minutes before slicing.

Garnish with fresh basil leaves if desired.'),
(14, 'Sugar Free Pasta', 
'Ingredients:

8 oz (225g) whole wheat or lentil pasta
2 cups sugar-free marinara sauce (check the label to ensure its sugar-free)
2 cloves garlic, minced
1 tablespoon olive oil
2 cups spinach leaves
1/4 cup fresh basil, chopped
Salt and pepper, to taste
Grated Parmesan cheese (optional, for serving)
Instructions:

Cook the pasta according to the package instructions in a large pot of boiling salted water until al dente. Drain and set aside.

While the pasta is cooking, heat the olive oil in a large skillet over medium heat. Add the minced garlic and sauté for about 1 minute until fragrant.

Add the sugar-free marinara sauce to the skillet and cook for 2-3 minutes until heated through.

Stir in the spinach leaves and cook for another 1-2 minutes until they wilt.

Add the cooked pasta to the skillet with the sauce and spinach. Toss everything together to combine. Season with salt and pepper to taste.

Remove from heat and stir in the fresh chopped basil.

Serve the pasta in bowls, optionally topped with grated Parmesan cheese.'),
(15, 'Sugar Free Burger', 
'Ingredients:

1 lb (450g) ground beef (85% lean)
1/2 teaspoon garlic powder
1/2 teaspoon onion powder
1/2 teaspoon smoked paprika
Salt and pepper, to taste
4 whole wheat or lettuce burger buns (ensure they are sugar-free)
4 lettuce leaves
1 tomato, sliced
1 red onion, sliced
Sugar-free ketchup or mustard (optional, for serving)
Instructions:

In a large bowl, combine the ground beef, garlic powder, onion powder, smoked paprika, salt, and pepper. Mix well.

Divide the mixture into four equal portions and shape each portion into a burger patty.

Preheat a grill or skillet over medium-high heat. Cook the burger patties for about 4-5 minutes on each side, or until they reach your desired level of doneness.

If using whole wheat buns, toast them lightly on the grill or in a toaster.

Assemble the burgers by placing a lettuce leaf on the bottom half of each bun. Add a cooked burger patty on top of the lettuce, followed by a slice of tomato, a slice of red onion, and any other desired toppings.

If using, spread some sugar-free ketchup or mustard on the top half of the bun, then place it on top of the burger.

Serve the sugar-free burgers immediately.'),
(16, 'Sugar Free Fries',
 'Ingredients:

2 large russet potatoes, peeled and cut into 1/4-inch thick fries
2 tablespoons olive oil
1/2 teaspoon garlic powder
1/2 teaspoon onion powder
1/2 teaspoon smoked paprika
Salt and pepper, to taste
Fresh parsley, chopped (optional, for garnish)
Instructions:

Preheat your oven to 425°F (220°C). Line a baking sheet with parchment paper or a silicone baking mat.

In a large bowl, toss the potato fries with olive oil, garlic powder, onion powder, smoked paprika, salt, and pepper until evenly coated.

Spread the fries in a single layer on the prepared baking sheet, making sure they are not touching each other for even cooking.

Bake in the preheated oven for 25-30 minutes, or until the fries are golden brown and crispy, flipping them halfway through the baking time.

Remove the fries from the oven and let them cool for a few minutes.'),
(17, 'Sugar Free Sandwich',
 'Ingredients:

2 slices of whole wheat or whole grain bread (ensure they are sugar-free)
4 slices of turkey or chicken breast (cooked and sliced)
2 slices of cheese (such as cheddar or Swiss)
Lettuce leaves
Tomato slices
Cucumber slices
Mustard or sugar-free mayonnaise (optional)
Instructions:

Toast the bread slices if desired.

Spread a thin layer of mustard or sugar-free mayonnaise on one side of each bread slice.

On one slice of bread, layer the lettuce leaves, tomato slices, cucumber slices, turkey or chicken slices, and cheese.

Top with the second slice of bread, with the spread side facing down.

Cut the sandwich in half or into quarters, depending on your preference.

Serve immediately and enjoy your sugar-free sandwich!'),
(18, 'Tomato Soup', 
'Ingredients:

2 tablespoons olive oil
1 onion, chopped
2 cloves garlic, minced
2 cans (28 oz each) whole peeled tomatoes, with their juice
2 cups vegetable or chicken broth
1 teaspoon sugar (optional, to balance acidity)
Salt and pepper, to taste
Fresh basil leaves, chopped (for garnish)
Heavy cream or milk (optional, for a creamier soup)
Instructions:

In a large pot, heat the olive oil over medium heat. Add the chopped onion and cook until softened, about 5 minutes.

Add the minced garlic and cook for another minute until fragrant.

Pour in the whole peeled tomatoes, including their juice. Use a wooden spoon to break up the tomatoes into smaller pieces.

Add the vegetable or chicken broth and bring the mixture to a simmer. Let it cook for about 20 minutes, stirring occasionally.

If using, add a teaspoon of sugar to balance the acidity of the tomatoes.

Use an immersion blender or transfer the soup to a blender to puree the soup until smooth. Be careful when blending hot liquids.

Return the soup to the pot and season with salt and pepper to taste. If you want a creamier soup, stir in some heavy cream or milk at this point.

Serve the tomato soup in bowls, garnished with fresh basil leaves.'),
(19, 'Cheese Pizza',
 'Ingredients:

1 pizza dough (store-bought or homemade)
1/2 cup pizza sauce (store-bought or homemade)
2 cups shredded mozzarella cheese
1/2 teaspoon dried oregano
1/2 teaspoon dried basil
Olive oil, for brushing
Cornmeal or flour, for dusting
Instructions:

Preheat your oven to 475°F (245°C). If you have a pizza stone, place it in the oven to preheat as well.

On a lightly floured surface, roll out the pizza dough to your desired thickness and shape.

If using a pizza stone, sprinkle some cornmeal on a pizza peel or the back of a baking sheet. If not, place the rolled-out dough on a baking sheet lined with parchment paper.

Brush the edges of the dough lightly with olive oil. This will help the crust get a nice golden color.

Spread the pizza sauce evenly over the dough, leaving a small border around the edges for the crust.

Sprinkle the shredded mozzarella cheese evenly over the sauce. Add the dried oregano and basil on top of the cheese.

Transfer the pizza to the preheated oven (or onto the pizza stone) and bake for about 10-12 minutes, or until the cheese is melted and bubbly and the crust is golden brown.

Remove the pizza from the oven and let it cool for a few minutes before slicing.

Serve and enjoy your delicious homemade cheese pizza!'),
(20, 'Chicken Rice', 
'Ingredients:

2 chicken breasts, boneless and skinless
1 cup white rice
2 cups chicken broth
1 onion, finely chopped
2 cloves garlic, minced
1 tablespoon olive oil
Salt and pepper, to taste
Fresh parsley, chopped (for garnish)
Instructions:

In a large skillet, heat the olive oil over medium heat. Add the chopped onion and minced garlic, and sauté until softened and fragrant, about 3-4 minutes.

Add the chicken breasts to the skillet and season them with salt and pepper. Cook for about 5-7 minutes on each side, or until they are golden brown and cooked through. Remove the chicken from the skillet and set aside.

In the same skillet, add the white rice and toast it for a couple of minutes, stirring constantly.

Pour in the chicken broth and bring it to a boil. Reduce the heat to low, cover the skillet, and let the rice simmer for about 18-20 minutes, or until its cooked and the liquid is absorbed.

While the rice is cooking, shred or slice the cooked chicken breasts.

Once the rice is done, fluff it with a fork and mix in the shredded chicken. Taste and adjust the seasoning if necessary.

Serve the chicken rice in bowls, garnished with chopped fresh parsley.');

INSERT INTO MealPlan (mealPlanID, name, date, userID) VALUES
(1, 'Normal Plan', '2024-03-01', 1),
(2, 'Protein Plan', '2024-03-02', 2),
(3, 'Vegetarian Plan', '2024-03-03', 3),
(4, 'Vegan Plan', '2024-03-04', 4),
(5, 'Low Sugar Plan', '2024-03-05', 5),
(6, 'Vegan Plan', '2024-04-01', 1),
(7, 'Vegetarian Plan', '2024-04-02',1),
(8, 'Low Sugar Plan', '2024-04-03',1),
(9, 'Emily Plan', '2024-04-18', 10),
(10, 'Frank Plan', '2024-04-19', 11),
(11, 'Grace Plan', '2024-04-20', 12),
(12, 'Lebron Plan', '2024-01-01', 9);

INSERT INTO Category (name, category) VALUES
('Pizza', 'Italian'),
('Pasta', 'Italian'),
('Burger', 'Fast Food'),
('Fries', 'Fast Food'),
('Grilled Cheese Sandwich', 'Sandwich'),
('Salad', 'Salad'),
('Vegetarian Pasta', 'Italian'),
('Vegetarian Pizza', 'Italian'),
('Vegetarian Burger', 'Fast Food'),
('Quinoa', 'Grain'),
('Low Calorie Pizza', 'Italian'),
('Low Calorie Pasta', 'Italian'),
('Sugar Free Pizza', 'Italian'),
('Sugar Free Pasta', 'Italian'),
('Sugar Free Burger', 'Fast Food'),
('Sugar Free Fries', 'Fast Food'),
('Sugar Free Sandwich', 'Sandwich'),
('Tomato Soup', 'Soup'),
('Cheese Pizza', 'Italian'),
('Chicken Rice', 'Clean');

INSERT INTO VegetarianRecipe (recipeID) VALUES
(6), (7), (8), (9), (18), (19), (10), (16), (4);

INSERT INTO LowCalorieRecipe (recipeID) VALUES
(11), (12), (18), (6), (13), (14), (15), (16), (17),(7),(8),(9),(20);

INSERT INTO SugarFreeRecipe (recipeID) VALUES
(13), (14), (15), (16), (17), (10);

INSERT INTO nutritionInfoRecipe (recipeID, calories, sugar, proteinContent, fatContent, carbContent) VALUES
(1, 100, 10, 10, 10, 10),
(2, 200, 20, 20, 20, 20),
(3, 300, 30, 30, 30, 30),
(4, 400, 40, 40, 40, 40),
(5, 500, 50, 50, 50, 50),
(6, 250, 15, 5, 5, 30),
(7, 350, 10, 12, 15, 40),
(8, 400, 20, 10, 20, 45),
(9, 450, 25, 15, 25, 50),
(10, 150, 0, 8, 2, 25),
(11, 280, 5, 10, 10, 30),
(12, 220, 4, 9, 8, 35),
(13, 300, 0, 11, 12, 40),
(14, 180, 0, 7, 5, 20),
(15, 350, 0, 20, 15, 30),
(16, 200, 0, 2, 10, 25),
(17, 250, 0, 9, 8, 28),
(18, 100, 2, 3, 1, 15),
(19, 350, 5, 15, 10, 40),
(20, 400, 10, 30, 15, 100);

INSERT INTO nutritionInfoIngredient (ingredientName, calories, sugar, proteinContent, fatContent, carbContent) VALUES
('Rice', 100, 10, 10, 10, 10),
('Noodles', 200, 20, 20, 20, 20),
('Salt', 300, 30, 30, 30, 30),
('Beef', 400, 40, 40, 40, 40),
('Chicken', 500, 50, 50, 50, 50),
('Tomato', 20, 3, 1, 0, 5),
('Cheese', 100, 1, 7, 8, 2),
('Quinoa', 100, 0, 2, 0, 50),
('Pepper', 1, 2, 1, 0, 9),
('Lettuce', 1, 0, 0 ,0, 10),
('Dough',100, 2, 2, 2, 100),
('Olive Oil', 100, 2, 0, 50, 0),
('Pepperoni', 200,5,10, 50, 2);

INSERT INTO recipeContains (recipeID, ingredientName) VALUES
(1, 'Salt'), (1, 'Cheese'), (1, 'Tomato'),(1, 'Dough'), (1, 'Olive Oil'),(1, 'Pepperoni'),(2, 'Noodles'), (2, 'Beef'), (3, 'Beef') ;

INSERT INTO mealPlanContains (mealPlanID, recipeID) VALUES
(1, 1), (1, 2), (2, 3), (3, 6), (4, 10), (5, 11), (6, 6), (6, 10), (7,8), (8, 13), (8,14), (8,15), (12,20);

INSERT INTO ShoppingList (shoppingListID, mealPlanID) VALUES
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(5, 4),
(6, 5),
(7, 6),
(8, 6),
(9, 7),
(10, 8),
(11, 8),
(12, 8),
(13, 12),
(14, 12);


INSERT INTO listContains (shoppingListID, ingredientName) VALUES
(1, 'Salt'),(1, 'Tomato'), (1, 'Dough'), (1, 'Olive Oil'),(1, 'Pepperoni'),(1, 'Noodles'),(2, 'Chicken'), (2, 'Beef'), (3, 'Rice'), (4, 'Noodles'), (6, 'Lettuce'), (6, 'Quinoa'), (7, 'Tomato'),(9, 'Tomato'), (10, 'Tomato'), (11, 'Noodles'), (12, 'Beef');

INSERT INTO Rating (ratingID, score, userID, recipeID) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5),
(6, 5, 1, 6),
(7, 4, 2, 7),
(8, 3, 3, 8),
(9, 2, 4, 9),
(10, 1, 5, 10),
(11, 4, 6, 1), 
(12, 3, 7, 1),
(13, 5, 6, 2),
(14, 4, 7, 2),
(16, 2, 8, 3),
(17, 5, 6, 4),
(18, 4, 7, 4),
(20, 2, 8, 5),
(21, 5, 6, 6),
(22, 4, 7, 6),
(24, 2, 8, 7),
(25, 5, 6, 8),
(26, 4, 7, 8),
(28, 2, 8, 9),
(29, 5, 6, 10),
(30, 4, 7, 10),
(32, 2, 8, 11),
(33, 5, 6, 12),
(34, 4, 7, 12),
(36, 2, 8, 13),
(37, 5, 6, 14),
(38, 4, 7, 14),
(40, 2, 8, 15),
(41, 5, 6, 16),
(42, 4, 7, 16),
(44, 2, 8, 17),
(45, 5, 6, 18),
(46, 4, 7, 18),
(48, 2, 8, 19),
(49, 5, 10, 1),
(50, 4, 10, 2),
(51, 3, 10, 3),
(52, 5, 11, 1),
(53, 4, 11, 2),
(54, 3, 11, 3),
(55, 5, 12, 1),
(56, 4, 12, 2),
(57, 3, 12, 3),
(58, 5, 9, 1),
(59, 5, 9, 2),
(60, 3, 9, 3),
(61, 2, 9, 4),
(62, 5, 9, 5),
(63, 5, 9, 6),
(64, 3, 9, 7),
(65, 2, 9, 8),
(66, 5, 9, 9),
(67, 5, 9, 10),
(68, 5, 9, 11),
(69, 3, 9, 12),
(70, 1, 9, 13),
(71, 3, 9, 14),
(72, 1, 9, 15),
(73, 2, 9, 16),
(74, 4, 9, 17),
(75, 5, 9, 18),
(76, 5, 9, 19),
(77, 5, 9, 20);
INSERT INTO Review (reviewID, date, message, userID, recipeID) VALUES
(1, '2024-03-01', 'Good', 1, 1),
(2, '2024-03-02', 'Bad', 2, 2),
(3, '2024-03-03', 'Amazing', 3, 3),
(4, '2024-03-04', 'Terrible', 4, 4),
(5, '2024-03-05', 'Spectacular', 5, 5),
(6, '2024-03-06', 'Okay', 1, 6),
(7, '2024-03-07', 'Not bad', 2, 7),
(8, '2024-03-08', 'Great', 3, 8),
(9, '2024-03-09', 'Disappointing', 4, 9),
(10, '2024-03-10', 'Outstanding', 5, 10),
(11, '2024-03-11', 'Decent', 6, 1),
(12, '2024-03-12', 'Average', 7, 1),
(13, '2024-03-13', 'Loved it', 6, 2),
(14, '2024-03-14', 'Pretty good', 7, 2),
(16, '2024-03-16', 'Could be better', 8, 3),
(17, '2024-03-17', 'Delicious', 6, 4),
(18, '2024-03-18', 'Tasty', 7, 4),
(20, '2024-03-20', 'Meh', 8, 5),
(21, '2024-03-21', 'Fantastic', 6, 6),
(22, '2024-03-22', 'Good choice', 7, 6),
(24, '2024-03-24', 'Not bad', 8, 7),
(25, '2024-03-25', 'Great!', 6, 8),
(26, '2024-03-26', 'Yummy', 7, 8),
(28, '2024-03-28', 'Disliked it', 8, 9),
(29, '2024-03-29', 'Healthy', 6, 10),
(30, '2024-03-30', 'Nutritious', 7, 10),
(32, '2024-04-01', 'Too light', 8, 11),
(33, '2024-04-02', 'No sugar, great', 6, 12),
(34, '2024-04-03', 'Miss the sugar', 7, 12),
(36, '2024-04-05', 'Lacking flavor', 8, 13),
(37, '2024-04-06', 'Nice', 6, 14),
(38, '2024-04-07', 'Not for me', 7, 14),
(40, '2024-04-08', 'Bland', 8, 15),
(41, '2024-04-10', 'Crispy', 6, 16),
(42, '2024-04-11', 'Too crispy', 7, 16),
(44, '2024-04-13', 'Too plain', 8, 17),
(45, '2024-04-11', 'Refreshing', 6, 18),
(46, '2024-04-14', 'Lacks depth', 7, 18),
(48, '2024-04-20', 'Too cheesy', 8, 19),
(49, '2024-04-18', 'Perfect', 10, 1),
(50, '2024-04-19', 'Great taste', 10, 2),
(51, '2024-04-20', 'Good', 10, 3),
(52, '2024-04-21', 'Loved it', 11, 1),
(53, '2024-04-22', 'Nice flavor', 11, 2),
(54, '2024-04-23', 'Decent', 11, 3),
(55, '2024-04-24', 'Amazing', 12, 1),
(56, '2024-04-25', 'Tasty', 12, 2),
(57, '2024-04-26', 'Not bad', 12, 3),
(58, '2024-04-01', 'Great pizza!', 9, 1),
(59, '2024-04-02', 'Pasta was delicious.', 9, 2),
(60, '2024-04-03', 'Burger could be better.', 9, 3),
(61, '2024-04-04', 'Fries were too salty.', 9, 4),
(62, '2024-04-05', 'Loved the grilled cheese sandwich.', 9, 5),
(63, '2024-04-06', 'Salad was fresh and tasty.', 9, 6),
(64, '2024-04-07', 'Vegetarian pasta was okay.', 9, 7),
(65, '2024-04-08', 'Vegetarian pizza lacked flavor.', 9, 8),
(66, '2024-04-09', 'Vegetarian burger was excellent.', 9, 9),
(67, '2024-04-10', 'Quinoa was cooked perfectly.', 9, 10),
(68, '2024-04-11', 'Low calorie pizza was surprisingly good.', 9, 11),
(69, '2024-04-12', 'Low calorie pasta needed more seasoning.', 9, 12),
(70, '2024-04-13', 'Sugar-free pizza was not to my liking.', 9, 13),
(71, '2024-04-14', 'Sugar-free pasta was decent.', 9, 14),
(72, '2024-04-15', 'Sugar-free burger was dry.', 9, 15),
(73, '2024-04-16', 'Sugar-free fries were okay.', 9, 16),
(74, '2024-04-17', 'Sugar-free sandwich was good.', 9, 17),
(75, '2024-04-18', 'Tomato soup was comforting.', 9, 18),
(76, '2024-04-19', 'Cheese pizza was a classic.', 9, 19),
(77, '2024-04-20', 'These are my pre-game snack', 9,20);

INSERT INTO saves (userID, recipeID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (1, 6), (2, 7), (3, 8), (4, 9), (5, 10), (6, 1), (7, 1);



