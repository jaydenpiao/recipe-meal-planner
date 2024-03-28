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
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM recipes'); // Use connection.promise().query() to execute the query
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

  // Implement other CRUD operations similarly
};

export default recipeService;




