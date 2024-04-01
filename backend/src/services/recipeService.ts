import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface Recipe {
  recipeid: number;
  name: string;
  category: string;
  instructions: string;
  // Add more properties as needed
}

const recipeService = {

  getAllRecipes: async (): Promise<Recipe[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = 
      await connection.promise().query('SELECT * FROM recipes'); 
      // Use connection.promise().query() to execute the query
      if (!rows) return [];
      return rows.map(row => ({
        recipeid: row.recipeid,
        name: row.name,
        category: row.category,
        instructions: row.instructions,
        // Map other properties as needed
      }));
    } catch (error) {
      throw new Error(`Error fetching recipes: ${error}`);
    }
  },

  getRecipeById: async (recipeId: number): Promise<Recipe | null> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = 
        await connection.promise().query('SELECT * FROM recipes WHERE recipeid = ?', [recipeId]); 
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
      throw new Error(`Error fetching recipe by id ${recipeId}: ${error}`);
    }
  },
};

export default recipeService;




