const db = require('../db');

const Student = {
  getAll: (callback) => {
    db.query('SELECT * FROM students', callback);
  }
};

module.exports = Student;
