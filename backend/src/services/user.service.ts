import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface User {
    userID: number;
    name : string;
    email: string;
    username: string;
}

const userService = {

    getAllUsers: async (): Promise<User[]> => {
      try {
        const [rows]: [RowDataPacket[], FieldPacket[]] = 
        await connection.promise().query('SELECT * FROM user'); 
        if (!rows) return [];
        return rows.map(row => ({
          userID: row.userID,
          name: row.name,
          email: row.email,
          username: row.username,
        }));
      } catch (error) {
        throw new Error(`Error fetching users: ${error}`);
      }
    },

    verifiedReviewers: async (): Promise<User[]> => {
      try {
        const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query(`
          SELECT userID, name 
          FROM User 
          WHERE NOT EXISTS (
            SELECT recipeID 
            FROM Recipe 
            WHERE NOT EXISTS (
              SELECT * 
              FROM Review 
              WHERE Review.userID = User.userID 
              AND Review.recipeID = Recipe.recipeID
            )
          )
        `);
    
        if (!rows || rows.length === 0) {
          return [];
        }
    
        return rows.map(row => ({
          userID: row.userID,
          name: row.name,
          email: row.email, 
          username: row.username, 
        }));
      } catch (error) {
        throw new Error(`Error fetching verified reviewers: ${error}`);
      }
    }
    

}

export default userService;