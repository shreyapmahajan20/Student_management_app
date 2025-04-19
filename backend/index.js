const express = require('express');
const cors = require('cors');
const app = express();
const studentRoutes = require('./routes/student');
const electiveRoutes = require('./routes/elective');

app.use(cors());
app.use(express.json());

app.use('/students', studentRoutes);
app.use('/electives', electiveRoutes);

app.listen(5000, () => console.log('Server started on port 5000'));
