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
    mealPlanID INTEGER,
    name VARCHAR(50),
    date DATE,
    userID INTEGER,
    PRIMARY KEY (mealPlanID),
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
    recipeID INTEGER,
    ingredientName VARCHAR(50),
    PRIMARY KEY (shoppingListID),
    FOREIGN KEY (mealPlanID, recipeID) REFERENCES mealPlanContains(mealPlanID, recipeID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    FOREIGN KEY (ingredientName) REFERENCES Ingredient(name)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

CREATE TABLE listContains (
    shoppingListID INTEGER,
    ingredientName VARCHAR(50),
    PRIMARY KEY (shoppingListID, ingredientName),
    FOREIGN KEY (shoppingListID) REFERENCES ShoppingList(shoppingListID)
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
(5, 'Jeff', 'jeff@email.com', 'jeff');

INSERT INTO Ingredient (name, isVegetarian) VALUES
('Rice', TRUE),
('Noodles', TRUE),
('Salt', TRUE),
('Beef', FALSE),
('Chicken', FALSE);

INSERT INTO Recipe (recipeID, name, instructions) VALUES
(1, 'Pizza', 'cheese, tomato sauce, dough, toppings...'),
(2, 'Pasta', 'noodles, sauces, meat...'),
(3, 'Burger', 'bun, patty, lettuce, tomato...'),
(4, 'Fries', 'potatoes, oil, salt...'),
(5, 'Grilled Cheese Sandwich', 'bread, cheese, butter...'),
(6, 'Salad', 'lettuce, dressing, toppings...'),
(7, 'Vegetarian Pasta', 'noodles, sauces, vegetables...'),
(8, 'Vegetarian Pizza', 'cheese, tomato sauce, dough, vegetables...'),
(9, 'Vegetarian Burger', 'bun, patty, lettuce, tomato, vegetables...'),
(10, 'Quinoa', 'quinoa, vegetables, sauce...'),
(11, 'Low Calorie Pizza', 'cheese, tomato sauce, dough, toppings...'),
(12, 'Low Calorie Pasta', 'noodles, sauces, meat...'),
(13, 'Sugar Free Pizza', 'cheese, tomato sauce, dough, toppings...'),
(14, 'Sugar Free Pasta', 'noodles, sauces, meat...'),
(15, 'Sugar Free Burger', 'bun, patty, lettuce, tomato...'),
(16, 'Sugar Free Fries', 'potatoes, oil, salt...'),
(17, 'Sugar Free Sandwich', 'bread, cheese, butter...');

INSERT INTO MealPlan (mealPlanID, name, date, userID) VALUES
(1, 'Normal Plan', '2024-03-01', 1),
(2, 'Protein Plan', '2024-03-02', 2),
(3, 'Vegetarian Plan', '2024-03-03', 3),
(4, 'Vegan Plan', '2024-03-04', 4),
(5, 'Low Sugar Plan', '2024-03-05', 5);

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
('Sugar Free Sandwich', 'Sandwich');

INSERT INTO VegetarianRecipe (recipeID) VALUES
(7), (8), (9);

INSERT INTO LowCalorieRecipe (recipeID) VALUES
(11), (12);

INSERT INTO SugarFreeRecipe (recipeID) VALUES
(13), (14), (15), (16), (17);

INSERT INTO nutritionInfoRecipe (recipeID, calories, sugar, proteinContent, fatContent, carbContent) VALUES
(1, 100, 10, 10, 10, 10),
(2, 200, 20, 20, 20, 20),
(3, 300, 30, 30, 30, 30),
(4, 400, 40, 40, 40, 40),
(5, 500, 50, 50, 50, 50);

INSERT INTO nutritionInfoIngredient (ingredientName, calories, sugar, proteinContent, fatContent, carbContent) VALUES
('Rice', 100, 10, 10, 10, 10),
('Noodles', 200, 20, 20, 20, 20),
('Salt', 300, 30, 30, 30, 30),
('Beef', 400, 40, 40, 40, 40),
('Chicken', 500, 50, 50, 50, 50);

INSERT INTO recipeContains (recipeID, ingredientName) VALUES
(1, 'Salt'), (1, 'Chicken'), (2, 'Noodles'), (2, 'Beef'), (3, 'Beef');

INSERT INTO mealPlanContains (mealPlanID, recipeID) VALUES
(1, 1), (2, 3), (3, 6), (4, 10), (5, 11);

INSERT INTO ShoppingList (shoppingListID, mealPlanID, recipeID, ingredientName) VALUES
(1, 1, 1, 'Salt'),
(2, 2, 3, 'Beef'),
(3, 3, 6, 'Rice'),
(4, 4, 10, 'Noodles'),
(5, 5, 11, 'Chicken');

INSERT INTO listContains (shoppingListID, ingredientName) VALUES
(1, 'Salt'), (2, 'Chicken'), (2, 'Beef'), (3, 'Rice'), (4, 'Noodles');


INSERT INTO Rating (ratingID, score, userID, recipeID) VALUES
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5);

INSERT INTO Review (reviewID, date, message, userID, recipeID) VALUES
(1, '2024-03-01', 'Good', 1, 1),
(2, '2024-03-02', 'Bad', 2, 2),
(3, '2024-03-03', 'Amazing', 3, 3),
(4, '2024-03-04', 'Terrible', 4, 4),
(5, '2024-03-05', 'Spectacular', 5, 5);


INSERT INTO saves (userID, recipeID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);



