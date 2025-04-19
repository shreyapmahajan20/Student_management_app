const db = require('../db');

const Elective = {
  getAll: (callback) => {
    db.query('SELECT * FROM electives', callback);
  },

  assign: (studentId, electiveId, callback) => {
    db.query('INSERT INTO student_electives (student_id, elective_id) VALUES (?, ?)', [studentId, electiveId], callback);
  }
};

module.exports = Elective;
