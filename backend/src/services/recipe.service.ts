import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface Recipe {
  recipeID: number;
  name: string;
  instructions: string;
}

const recipeService = {

  getAllRecipes: async (): Promise<Recipe[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = 
      await connection.promise().query('SELECT * FROM recipe'); 
      if (!rows) return [];
      return rows.map(row => ({
        recipeID: row.recipeid,
        name: row.name,
        instructions: row.instructions,
      }));
    } catch (error) {
      throw new Error(`Error fetching recipes: ${error}`);
    }
  },

  getRecipeById: async (recipeId: number): Promise<Recipe | null> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM recipe WHERE recipeid = ?', [recipeId]);
      if (!rows || rows.length === 0) {
        return null; 
      }
      const row = rows[0];
      return {
        recipeID: row.recipeid,
        name: row.name,
        instructions: row.instructions,
      };
    } catch (error) {
      throw new Error(`Error fetching recipe: ${error}`);
    }
  },

  getRecipeByName: async (recipeName: string): Promise<Recipe | null> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM recipe WHERE name LIKE ?', [`%${recipeName}%`]);

      if (!rows || rows.length === 0) {
        return null; // Recipe not found
      }
      const row = rows[0];
      const recipe: Recipe = {
        recipeID: row.recipeid,
        name: row.name,
        instructions: row.instructions,
      };
      return recipe;
    } catch (error) {
      throw new Error(`Error fetching recipe: ${error}`);
    }
  }


};

export default recipeService;




