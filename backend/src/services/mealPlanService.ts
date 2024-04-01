import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface MealPlan {
  recipeid: number;
  name: string;
  category: string;
  instructions: string;
  // Add more properties as needed
}

const mealPlanService = {
    getmealPlanById: async (mealplanid: number): Promise<MealPlan | null> => {
        try {
          const [rows]: [RowDataPacket[], FieldPacket[]] = 
            await connection.promise().query('SELECT * FROM mealplan WHERE mealplanid = ?', [mealplanid]); 
          if (rows.length === 0) return null; // Return null if no recipe found
          const row = rows[0];
          return {
            recipeid: row.recipeid,
            name: row.name,
            category: row.category,
            instructions: row.instructions,
            // Map other properties as needed
          };
        } catch (error) {
          throw new Error(`Error fetching recipe by id ${mealplanid}: ${error}`);
        }
      },
};

export default mealPlanService;