import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

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

    createMealPlanForUser:async (userID: number): Promise<MealPlan[]> => {
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

    
    //deleteMealPlan:
    //editMealPlanName:
    //addRecipe:
    //deleteRecipe:




};

export default mealPlanService;