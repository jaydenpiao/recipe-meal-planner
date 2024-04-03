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
('Pepper', TRUE);

INSERT INTO Recipe (recipeID, name, instructions) VALUES
(1, 'Pizza', 'pizza instructions'),
(2, 'Pasta', 'pasta instructions'),
(3, 'Burger', 'burger instructions'),
(4, 'Fries', 'recipe text...'),
(5, 'Grilled Cheese Sandwich', 'recipe text...'),
(6, 'Salad', 'recipe text...'),
(7, 'Vegetarian Pasta', 'recipe text...'),
(8, 'Vegetarian Pizza', 'recipe text...'),
(9, 'Vegetarian Burger', 'recipe text...'),
(10, 'Quinoa', 'recipe text...'),
(11, 'Low Calorie Pizza', 'recipe text...'),
(12, 'Low Calorie Pasta', 'recipe text...'),
(13, 'Sugar Free Pizza', 'recipe text...'),
(14, 'Sugar Free Pasta', 'recipe text...'),
(15, 'Sugar Free Burger', 'recipe text...'),
(16, 'Sugar Free Fries', 'recipe text...'),
(17, 'Sugar Free Sandwich', 'recipe text...'),
(18, 'Tomato Soup', 'recipe text...'),
(19, 'Cheese Pizza', 'recipe text...');

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
(11, 'Grace Plan', '2024-04-20', 12);

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
('Cheese Pizza', 'Italian');

INSERT INTO VegetarianRecipe (recipeID) VALUES
(7), (8), (9), (18), (19);

INSERT INTO LowCalorieRecipe (recipeID) VALUES
(11), (12), (18), (6);

INSERT INTO SugarFreeRecipe (recipeID) VALUES
(13), (14), (15), (16), (17);

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
(10, 150, 5, 8, 2, 25),
(11, 280, 5, 10, 10, 30),
(12, 220, 4, 9, 8, 35),
(13, 300, 0, 11, 12, 40),
(14, 180, 0, 7, 5, 20),
(15, 350, 0, 20, 15, 30),
(16, 200, 0, 2, 10, 25),
(17, 250, 0, 9, 8, 28),
(18, 100, 2, 3, 1, 15),
(19, 350, 5, 15, 10, 40);

INSERT INTO nutritionInfoIngredient (ingredientName, calories, sugar, proteinContent, fatContent, carbContent) VALUES
('Rice', 100, 10, 10, 10, 10),
('Noodles', 200, 20, 20, 20, 20),
('Salt', 300, 30, 30, 30, 30),
('Beef', 400, 40, 40, 40, 40),
('Chicken', 500, 50, 50, 50, 50),
('Tomato', 20, 3, 1, 0, 5),
('Cheese', 100, 1, 7, 8, 2),
('Quinoa', 100, 0, 2, 0, 50),
('Pepper', 40, 2, 1, 0, 9);

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
(15, 3, 8, 3),
(16, 2, 9, 3),
(17, 5, 6, 4),
(18, 4, 7, 4),
(19, 3, 8, 5),
(20, 2, 9, 5),
(21, 5, 6, 6),
(22, 4, 7, 6),
(23, 3, 8, 7),
(24, 2, 9, 7),
(25, 5, 6, 8),
(26, 4, 7, 8),
(27, 3, 8, 9),
(28, 2, 9, 9),
(29, 5, 6, 10),
(30, 4, 7, 10),
(31, 3, 8, 11),
(32, 2, 9, 11),
(33, 5, 6, 12),
(34, 4, 7, 12),
(35, 3, 8, 13),
(36, 2, 9, 13),
(37, 5, 6, 14),
(38, 4, 7, 14),
(39, 3, 8, 15),
(40, 2, 9, 15),
(41, 5, 6, 16),
(42, 4, 7, 16),
(43, 3, 8, 17),
(44, 2, 9, 17),
(45, 5, 6, 18),
(46, 4, 7, 18),
(47, 3, 8, 19),
(48, 2, 9, 19),
(49, 5, 10, 1),
(50, 4, 10, 2),
(51, 3, 10, 3),
(52, 5, 11, 1),
(53, 4, 11, 2),
(54, 3, 11, 3),
(55, 5, 12, 1),
(56, 4, 12, 2),
(57, 3, 12, 3);



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
(15, '2024-03-15', 'Not my favorite', 8, 3),
(16, '2024-03-16', 'Could be better', 9, 3),
(17, '2024-03-17', 'Delicious', 6, 4),
(18, '2024-03-18', 'Tasty', 7, 4),
(19, '2024-03-19', 'Alright', 8, 5),
(20, '2024-03-20', 'Meh', 9, 5),
(21, '2024-03-21', 'Fantastic', 6, 6),
(22, '2024-03-22', 'Good choice', 7, 6),
(23, '2024-03-23', 'Average', 8, 7),
(24, '2024-03-24', 'Not bad', 9, 7),
(25, '2024-03-25', 'Great!', 6, 8),
(26, '2024-03-26', 'Yummy', 7, 8),
(27, '2024-03-27', 'So-so', 8, 9),
(28, '2024-03-28', 'Disliked it', 9, 9),
(29, '2024-03-29', 'Healthy', 6, 10),
(30, '2024-03-30', 'Nutritious', 7, 10),
(31, '2024-03-31', 'Light', 8, 11),
(32, '2024-04-01', 'Too light', 9, 11),
(33, '2024-04-02', 'No sugar, great', 6, 12),
(34, '2024-04-03', 'Miss the sugar', 7, 12),
(35, '2024-04-08', 'Perfect', 8, 13),
(36, '2024-04-05', 'Lacking flavor', 9, 13),
(37, '2024-04-06', 'Nice', 6, 14),
(38, '2024-04-07', 'Not for me', 7, 14),
(39, '2024-04-08', 'Enjoyed it', 8, 15),
(40, '2024-04-08', 'Bland', 9, 15),
(41, '2024-04-10', 'Crispy', 6, 16),
(42, '2024-04-11', 'Too crispy', 7, 16),
(43, '2024-04-12', 'Good for diet', 8, 17),
(44, '2024-04-13', 'Too plain', 9, 17),
(45, '2024-04-11', 'Refreshing', 6, 18),
(46, '2024-04-14', 'Lacks depth', 7, 18),
(47, '2024-04-02', 'Cheesy goodness', 8, 19),
(48, '2024-04-20', 'Too cheesy', 9, 19),
(49, '2024-04-18', 'Perfect', 10, 1),
(50, '2024-04-19', 'Great taste', 10, 2),
(51, '2024-04-20', 'Good', 10, 3),
(52, '2024-04-21', 'Loved it', 11, 1),
(53, '2024-04-22', 'Nice flavor', 11, 2),
(54, '2024-04-23', 'Decent', 11, 3),
(55, '2024-04-24', 'Amazing', 12, 1),
(56, '2024-04-25', 'Tasty', 12, 2),
(57, '2024-04-26', 'Not bad', 12, 3);



INSERT INTO saves (userID, recipeID) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (1, 6), (2, 7), (3, 8), (4, 9), (5, 10), (6, 1), (7, 1);



