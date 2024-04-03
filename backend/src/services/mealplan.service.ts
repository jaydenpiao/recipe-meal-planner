import connection from '../db';
import { RowDataPacket, FieldPacket, ResultSetHeader } from 'mysql2';

interface MealPlan {
  mealPlanID: number;
  name?: string;
  date?: Date;
  userID?: number;
  recipeID?: number;
}

const mealPlanService = {

  getMealPlansByUser: async (userID: number): Promise<MealPlan[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM mealplan WHERE userID = ?', [userID]);

      if (!rows || rows.length === 0) {
        return [];
      }

      return rows.map(row => ({
        mealPlanID: row.mealPlanID,
        name: row.name,
        date: row.date,
        userID: row.userID,
      }));
    } catch (error) {
      throw new Error(`Error fetching mealplans: ${error}`);
    }
  },

  createMealPlanForUser: async (userID: number, name: string): Promise<MealPlan> => {
    try {
        // check if meal plan exists
        const [existingMealPlans]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM MealPlan WHERE userID = ? AND name = ?', [userID, name]);

        if (existingMealPlans.length > 0) {
            throw new Error('A meal plan with the same name already exists for this user');
        }

        //create
        const [result]: [ResultSetHeader, FieldPacket[]] = await connection.promise().query('INSERT INTO MealPlan (name, date, userID) VALUES (?, ?, ?)', [name, new Date(), userID]);
        const insertId = result.insertId;

        const newMealPlan: MealPlan = {
            mealPlanID: insertId,
            name: name,
            date: new Date(),
            userID: userID,
        };
        
        return newMealPlan;
    } catch (error) {
        throw new Error(`Error creating meal plan: ${error}`);
    }
},

deleteMealPlan: async (mealPlanID: number): Promise<void> => {
  try {
    // Check if the meal plan exists
    const [existingMealPlans]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query(
      'SELECT * FROM MealPlan WHERE mealPlanID = ?', [mealPlanID]
    );

    if (existingMealPlans.length === 0) {
      throw new Error('Meal plan not found');
    }

    // Delete the meal plan
    await connection.promise().query('DELETE FROM MealPlan WHERE mealPlanID = ?', [mealPlanID]);
    await connection.promise().query('DELETE FROM MealPlancontains WHERE mealPlanID = ?', [mealPlanID]);

  } catch (error) {
    throw new Error(`Error deleting meal plan: ${error}`);
  }
},

editMealPlanName: async (mealPlanID: number, newName: string): Promise<void> => {
  try {
      // Check if meal plan exists
      const [existingMealPlans]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM MealPlan WHERE mealPlanID = ?', [mealPlanID]);

      if (existingMealPlans.length === 0) {
          throw new Error('Meal plan not found');
      }

      // Update meal plan name
      await connection.promise().query('UPDATE MealPlan SET name = ? WHERE mealPlanID = ?', [newName, mealPlanID]);
      
  } catch (error) {
      throw new Error(`Error editing meal plan name: ${error}`);
  }
},
  addRecipe: async (mealPlanID: number, recipeID: number): Promise<void> => {
    try {
        const [existingRecipes]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM MealPlancontains WHERE mealPlanID = ? AND recipeID = ?', [mealPlanID, recipeID]);

        if (existingRecipes.length > 0) {
            throw new Error('Recipe already exists in the meal plan');
        }

        await connection.promise().query('INSERT INTO MealPlancontains (mealPlanID, recipeID) VALUES (?, ?)', [mealPlanID, recipeID]);
        
    } catch (error) {
        throw new Error(`Error adding recipe to meal plan: ${error}`);
    }
},

  deleteRecipe: async (mealPlanID: number, recipeID: number): Promise<void> => {
      try {
          await connection.promise().query('DELETE FROM MealPlancontains WHERE mealPlanID = ? AND recipeID = ?', [mealPlanID, recipeID]);
      } catch (error) {
          throw new Error(`Error deleting recipe from meal plan: ${error}`);
      }
  },

  getRecipe: async (mealplanID: number): Promise<MealPlan[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM mealplancontains WHERE mealPlanID = ?', [mealplanID]);

      if (!rows || rows.length === 0) {
        return [];
      }
      return rows.map(row => ({
        mealPlanID: row.mealPlanID,
        recipeID: row.recipeID,
      }));
    } catch (error) {
      throw new Error(`Error fetching mealplans: ${error}`);
    }
  },

 





};

export default mealPlanService;