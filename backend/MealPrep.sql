-- MySQL dump 10.13  Distrib 8.3.0, for macos13.6 (x86_64)
--
-- Host: localhost    Database: mealprep
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Category`
--

DROP TABLE IF EXISTS `Category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Category` (
  `category` varchar(50) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Category`
--

LOCK TABLES `Category` WRITE;
/*!40000 ALTER TABLE `Category` DISABLE KEYS */;
INSERT INTO `Category` VALUES ('fast food','Burger'),('fast food','Fries'),('sandwich','Grilled Cheese Sandwich'),('italian','Low Calorie Pasta'),('italian','Low Calorie Pizza'),('italian','Pasta'),('italian','Pizza'),('','Quinoa'),('salad','Salad'),('fast food','Sugar Free Burger'),('fast food','Sugar Free Fries'),('italian','Sugar Free Pasta'),('italian','Sugar Free Pizza'),('sandwich','Sugar Free Sandwich'),('fast food','Vegetarian Burger'),('italian','Vegetarian Pasta'),('italian','Vegetarian Pizza');
/*!40000 ALTER TABLE `Category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Ingredient`
--

DROP TABLE IF EXISTS `Ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Ingredient` (
  `name` varchar(50) NOT NULL,
  `isVegetarian` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Ingredient`
--

LOCK TABLES `Ingredient` WRITE;
/*!40000 ALTER TABLE `Ingredient` DISABLE KEYS */;
INSERT INTO `Ingredient` VALUES ('Beef',0),('Chicken',0),('Noodles',1),('Rice',1),('Salt',1);
/*!40000 ALTER TABLE `Ingredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `listContains`
--

DROP TABLE IF EXISTS `listContains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `listContains` (
  `shoppingListID` int NOT NULL,
  `ingredientName` varchar(50) NOT NULL,
  PRIMARY KEY (`shoppingListID`,`ingredientName`),
  KEY `ingredientName` (`ingredientName`),
  CONSTRAINT `listcontains_ibfk_1` FOREIGN KEY (`shoppingListID`) REFERENCES `ShoppingList` (`shoppingListID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `listcontains_ibfk_2` FOREIGN KEY (`ingredientName`) REFERENCES `Ingredient` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `listContains`
--

LOCK TABLES `listContains` WRITE;
/*!40000 ALTER TABLE `listContains` DISABLE KEYS */;
INSERT INTO `listContains` VALUES (2,'Beef'),(2,'Chicken'),(4,'Noodles'),(3,'Rice'),(1,'Salt');
/*!40000 ALTER TABLE `listContains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LowCalorieRecipe`
--

DROP TABLE IF EXISTS `LowCalorieRecipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LowCalorieRecipe` (
  `recipeID` int NOT NULL,
  PRIMARY KEY (`recipeID`),
  CONSTRAINT `lowcalorierecipe_ibfk_1` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LowCalorieRecipe`
--

LOCK TABLES `LowCalorieRecipe` WRITE;
/*!40000 ALTER TABLE `LowCalorieRecipe` DISABLE KEYS */;
INSERT INTO `LowCalorieRecipe` VALUES (11),(12);
/*!40000 ALTER TABLE `LowCalorieRecipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MealPlan`
--

DROP TABLE IF EXISTS `MealPlan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `MealPlan` (
  `mealPlanID` int NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `userID` int DEFAULT NULL,
  PRIMARY KEY (`mealPlanID`),
  KEY `userID` (`userID`),
  CONSTRAINT `mealplan_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MealPlan`
--

LOCK TABLES `MealPlan` WRITE;
/*!40000 ALTER TABLE `MealPlan` DISABLE KEYS */;
INSERT INTO `MealPlan` VALUES (1,'Normal Plan','2024-03-01',1),(2,'Protein Plan','2024-03-02',2),(3,'Vegetarian Plan','2024-03-03',3),(4,'Vegan Plan','2024-03-04',4),(5,'Low Sugar Plan','2024-03-05',5);
/*!40000 ALTER TABLE `MealPlan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mealPlanContains`
--

DROP TABLE IF EXISTS `mealPlanContains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mealPlanContains` (
  `mealPlanID` int NOT NULL,
  `recipeID` int NOT NULL,
  PRIMARY KEY (`mealPlanID`,`recipeID`),
  KEY `recipeID` (`recipeID`),
  CONSTRAINT `mealplancontains_ibfk_1` FOREIGN KEY (`mealPlanID`) REFERENCES `MealPlan` (`mealPlanID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mealplancontains_ibfk_2` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mealPlanContains`
--

LOCK TABLES `mealPlanContains` WRITE;
/*!40000 ALTER TABLE `mealPlanContains` DISABLE KEYS */;
INSERT INTO `mealPlanContains` VALUES (1,1),(2,3),(3,6),(4,10),(5,11);
/*!40000 ALTER TABLE `mealPlanContains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nutritionInfoIngredient`
--

DROP TABLE IF EXISTS `nutritionInfoIngredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nutritionInfoIngredient` (
  `ingredientName` varchar(50) NOT NULL,
  `calories` int DEFAULT NULL,
  `sugar` int DEFAULT NULL,
  `proteinContent` int DEFAULT NULL,
  `fatContent` int DEFAULT NULL,
  `carbContent` int DEFAULT NULL,
  PRIMARY KEY (`ingredientName`),
  CONSTRAINT `nutritioninfoingredient_ibfk_1` FOREIGN KEY (`ingredientName`) REFERENCES `Ingredient` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nutritioninfoingredient_chk_1` CHECK ((`sugar` >= 0)),
  CONSTRAINT `nutritioninfoingredient_chk_2` CHECK ((`proteinContent` >= 0)),
  CONSTRAINT `nutritioninfoingredient_chk_3` CHECK ((`fatContent` >= 0)),
  CONSTRAINT `nutritioninfoingredient_chk_4` CHECK ((`carbContent` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nutritionInfoIngredient`
--

LOCK TABLES `nutritionInfoIngredient` WRITE;
/*!40000 ALTER TABLE `nutritionInfoIngredient` DISABLE KEYS */;
INSERT INTO `nutritionInfoIngredient` VALUES ('Beef',400,40,40,40,40),('Chicken',500,50,50,50,50),('Noodles',200,20,20,20,20),('Rice',100,10,10,10,10),('Salt',300,30,30,30,30);
/*!40000 ALTER TABLE `nutritionInfoIngredient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nutritionInfoRecipe`
--

DROP TABLE IF EXISTS `nutritionInfoRecipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nutritionInfoRecipe` (
  `recipeID` int NOT NULL,
  `calories` int DEFAULT NULL,
  `sugar` int DEFAULT NULL,
  `proteinContent` int DEFAULT NULL,
  `fatContent` int DEFAULT NULL,
  `carbContent` int DEFAULT NULL,
  PRIMARY KEY (`recipeID`),
  CONSTRAINT `nutritioninforecipe_ibfk_1` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `nutritioninforecipe_chk_1` CHECK ((`sugar` >= 0)),
  CONSTRAINT `nutritioninforecipe_chk_2` CHECK ((`proteinContent` >= 0)),
  CONSTRAINT `nutritioninforecipe_chk_3` CHECK ((`fatContent` >= 0)),
  CONSTRAINT `nutritioninforecipe_chk_4` CHECK ((`carbContent` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nutritionInfoRecipe`
--

LOCK TABLES `nutritionInfoRecipe` WRITE;
/*!40000 ALTER TABLE `nutritionInfoRecipe` DISABLE KEYS */;
INSERT INTO `nutritionInfoRecipe` VALUES (1,100,10,10,10,10),(2,200,20,20,20,20),(3,300,30,30,30,30),(4,400,40,40,40,40),(5,500,50,50,50,50);
/*!40000 ALTER TABLE `nutritionInfoRecipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rating`
--

DROP TABLE IF EXISTS `Rating`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Rating` (
  `ratingID` int NOT NULL,
  `score` int DEFAULT NULL,
  `userID` int DEFAULT NULL,
  `recipeID` int DEFAULT NULL,
  PRIMARY KEY (`ratingID`),
  UNIQUE KEY `userID` (`userID`,`recipeID`),
  KEY `recipeID` (`recipeID`),
  CONSTRAINT `rating_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE,
  CONSTRAINT `rating_ibfk_2` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE,
  CONSTRAINT `rating_chk_1` CHECK (((0 <= `score`) and (`score` <= 5)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rating`
--

LOCK TABLES `Rating` WRITE;
/*!40000 ALTER TABLE `Rating` DISABLE KEYS */;
INSERT INTO `Rating` VALUES (1,1,1,1),(2,2,2,2),(3,3,3,3),(4,4,4,4),(5,5,5,5);
/*!40000 ALTER TABLE `Rating` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Recipe`
--

DROP TABLE IF EXISTS `Recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Recipe` (
  `recipeID` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `instructions` varchar(10000) DEFAULT NULL,
  PRIMARY KEY (`recipeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Recipe`
--

LOCK TABLES `Recipe` WRITE;
/*!40000 ALTER TABLE `Recipe` DISABLE KEYS */;
INSERT INTO `Recipe` VALUES (1,'Pizza','recipe text...'),(2,'Pasta','recipe text...'),(3,'Burger','recipe text...'),(4,'Fries','recipe text...'),(5,'Grilled Cheese Sandwich','recipe text...'),(6,'Salad','recipe text...'),(7,'Vegetarian Pasta','recipe text...'),(8,'Vegetarian Pizza','recipe text...'),(9,'Vegetarian Burger','recipe text...'),(10,'Quinoa','recipe text...'),(11,'Low Calorie Pizza','recipe text...'),(12,'Low Calorie Pasta','recipe text...'),(13,'Sugar Free Pizza','recipe text...'),(14,'Sugar Free Pasta','recipe text...'),(15,'Sugar Free Burger','recipe text...'),(16,'Sugar Free Fries','recipe text...'),(17,'Sugar Free Sandwich','recipe text...');
/*!40000 ALTER TABLE `Recipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recipeContains`
--

DROP TABLE IF EXISTS `recipeContains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipeContains` (
  `recipeID` int NOT NULL,
  `ingredientName` varchar(50) NOT NULL,
  PRIMARY KEY (`recipeID`,`ingredientName`),
  KEY `ingredientName` (`ingredientName`),
  CONSTRAINT `recipecontains_ibfk_1` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `recipecontains_ibfk_2` FOREIGN KEY (`ingredientName`) REFERENCES `Ingredient` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recipeContains`
--

LOCK TABLES `recipeContains` WRITE;
/*!40000 ALTER TABLE `recipeContains` DISABLE KEYS */;
INSERT INTO `recipeContains` VALUES (2,'Beef'),(3,'Beef'),(1,'Chicken'),(2,'Noodles'),(1,'Salt');
/*!40000 ALTER TABLE `recipeContains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Review`
--

DROP TABLE IF EXISTS `Review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Review` (
  `reviewID` int NOT NULL,
  `date` date DEFAULT NULL,
  `message` varchar(500) DEFAULT NULL,
  `userID` int NOT NULL,
  `recipeID` int DEFAULT NULL,
  PRIMARY KEY (`reviewID`),
  UNIQUE KEY `userID` (`userID`,`recipeID`),
  KEY `recipeID` (`recipeID`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Review`
--

LOCK TABLES `Review` WRITE;
/*!40000 ALTER TABLE `Review` DISABLE KEYS */;
INSERT INTO `Review` VALUES (1,'2024-03-01','Good',1,1),(2,'2024-03-02','Bad',2,2),(3,'2024-03-03','Amazing',3,3),(4,'2024-03-04','Terrible',4,4),(5,'2024-03-05','Spectacular',5,5);
/*!40000 ALTER TABLE `Review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saves`
--

DROP TABLE IF EXISTS `saves`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saves` (
  `userID` int NOT NULL,
  `recipeID` int NOT NULL,
  PRIMARY KEY (`userID`,`recipeID`),
  KEY `recipeID` (`recipeID`),
  CONSTRAINT `saves_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `User` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `saves_ibfk_2` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saves`
--

LOCK TABLES `saves` WRITE;
/*!40000 ALTER TABLE `saves` DISABLE KEYS */;
/*!40000 ALTER TABLE `saves` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ShoppingList`
--

DROP TABLE IF EXISTS `ShoppingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ShoppingList` (
  `shoppingListID` int NOT NULL,
  `mealPlanID` int DEFAULT NULL,
  PRIMARY KEY (`shoppingListID`),
  KEY `mealPlanID` (`mealPlanID`),
  CONSTRAINT `shoppinglist_ibfk_1` FOREIGN KEY (`mealPlanID`) REFERENCES `MealPlan` (`mealPlanID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ShoppingList`
--

LOCK TABLES `ShoppingList` WRITE;
/*!40000 ALTER TABLE `ShoppingList` DISABLE KEYS */;
INSERT INTO `ShoppingList` VALUES (1,1),(2,2),(3,3),(4,4),(5,5);
/*!40000 ALTER TABLE `ShoppingList` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SugarFreeRecipe`
--

DROP TABLE IF EXISTS `SugarFreeRecipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SugarFreeRecipe` (
  `recipeID` int NOT NULL,
  PRIMARY KEY (`recipeID`),
  CONSTRAINT `sugarfreerecipe_ibfk_1` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SugarFreeRecipe`
--

LOCK TABLES `SugarFreeRecipe` WRITE;
/*!40000 ALTER TABLE `SugarFreeRecipe` DISABLE KEYS */;
INSERT INTO `SugarFreeRecipe` VALUES (13),(14),(15),(16),(17);
/*!40000 ALTER TABLE `SugarFreeRecipe` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `userID` int NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (1,'Joe','joe@email.com','joe'),(2,'Jay','jay@email.com','jay'),(3,'Kohen','kohen@email.com','kohen'),(4,'George','george@email.com','george'),(5,'Jeff','jeff@email.com','jeff');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VegetarianRecipe`
--

DROP TABLE IF EXISTS `VegetarianRecipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `VegetarianRecipe` (
  `recipeID` int NOT NULL,
  PRIMARY KEY (`recipeID`),
  CONSTRAINT `vegetarianrecipe_ibfk_1` FOREIGN KEY (`recipeID`) REFERENCES `Recipe` (`recipeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VegetarianRecipe`
--

LOCK TABLES `VegetarianRecipe` WRITE;
/*!40000 ALTER TABLE `VegetarianRecipe` DISABLE KEYS */;
INSERT INTO `VegetarianRecipe` VALUES (7),(8),(9);
/*!40000 ALTER TABLE `VegetarianRecipe` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-03-29 11:46:18
