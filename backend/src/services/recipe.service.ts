import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface Recipe {
  recipeID: number;
  name: string;
  instructions?: string;
  rating?: number;
  count?: number;
}

const recipeService = {

  getAllRecipes: async (): Promise<Recipe[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = 
      await connection.promise().query('SELECT * FROM recipe'); 
      if (!rows) return [];
      return rows.map(row => ({
        recipeID: row.recipeID,
        name: row.name,
        instructions: row.instructions,
      }));
    } catch (error) {
      throw new Error(`Error fetching recipes: ${error}`);
    }
  },

  getRecipeById: async (recipeID: number): Promise<Recipe | null> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM recipe WHERE recipeID = ?', [recipeID]);
      if (!rows || rows.length === 0) {
        return null; 
      }
      const row = rows[0];
      return {
        recipeID: row.recipeID,
        name: row.name,
        instructions: row.instructions,
      };
    } catch (error) {
      throw new Error(`Error fetching recipe: ${error}`);
    }
  },

  getRecipeByName: async (recipeName: string): Promise<Recipe[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM recipe WHERE name LIKE ?', [`%${recipeName}%`]);
  
      if (!rows || rows.length === 0) {
        return []; 
      }
  
      return rows.map(row => ({
        recipeID: row.recipeID,
        name: row.name,
        instructions: row.instructions,
      }));
    } catch (error) {
      throw new Error(`Error fetching recipes: ${error}`);
    }
  },

  getAvgRating: async (): Promise<Recipe[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query(
        'SELECT r.recipeID, r.name, avg_rating.average_rating ' +
        'FROM recipe r ' +
        'INNER JOIN (SELECT recipeID, AVG(score) AS average_rating ' +
        '            FROM rating ' +
        '            GROUP BY recipeID) AS avg_rating ' +
        'ON r.recipeID = avg_rating.recipeID;'
      );
      if (!rows) return [];
      return rows.map(row => ({
        recipeID: row.recipeID,
        name: row.name,
        avgrating: row.average_rating
      }));
    } catch (error) {
      throw new Error(`Error fetching recipes: ${error}`);
    }
  },
  getRecipeRatings: async (recipeID: number): Promise<Recipe[]> => {
    try {
      const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query(
        'SELECT r.recipeID, r.name, COUNT(*) AS rating_count, ra.score ' +
        'FROM recipe r ' +
        'JOIN rating ra ON r.recipeID = ra.recipeID ' +
        'WHERE r.recipeID = ? ' +
        'GROUP BY r.recipeID, r.name, ra.score;',
        [recipeID]
        );
      if (!rows) return [];
      return rows.map(row => ({
        recipeID: row.recipeID,
        name: row.name,
        rating: row.score,
        count: row.rating_count,
      }));
    } catch (error) {
      throw new Error(`Error fetching recipes: ${error}`);
    }
  },

  
};

export default recipeService;




