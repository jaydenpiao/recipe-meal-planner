import connection from '../db';
import { RowDataPacket, FieldPacket, ResultSetHeader } from 'mysql2';

interface MealPlan {
  mealPlanID: number;
  name: string;
  date: Date;
  userID: number;
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
    await connection.promise().query('DELETE FROM MealPlanrecipes WHERE mealPlanID = ?', [mealPlanID]);

  } catch (error) {
    throw new Error(`Error deleting meal plan: ${error}`);
  }
}


  //editMealPlanName:
  //addRecipe:
  //deleteRecipe:




};

export default mealPlanService;