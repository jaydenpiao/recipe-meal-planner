import express from 'express';
import connection from '../db';

const app = express();

// example query

// app.get('/users', (req, res) => {
//     connection.query('SELECT * FROM users', (err, results) => {
//         if (err) {
//             console.error('Error fetching users:', err);
//             res.status(500).send('Error fetching users');
//             return;
//         }
//         res.json(results);
//     });
// });

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});