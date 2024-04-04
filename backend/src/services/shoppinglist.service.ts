import connection from '../db';
import { RowDataPacket, FieldPacket } from 'mysql2';

interface shoppinglist {
    shoppinglistID: number;
    ingredient : string;
}

const shoppinglistService = {

    getingredients: async (shoppingListID: number): Promise<shoppinglist[]> => {
      try {
        const [rows]: [RowDataPacket[], FieldPacket[]] = await connection.promise().query('SELECT * FROM listcontains WHERE shoppingListID = ?', [shoppingListID]);
        if (!rows || rows.length === 0) return [];
        return rows.map(row => ({
          shoppinglistID: row.shoppingListID,
          ingredient: row.ingredientName,
        }));
      } catch (error) {
        throw new Error(`Error fetching users: ${error}`);
      }
    }

}

export default shoppinglistService;