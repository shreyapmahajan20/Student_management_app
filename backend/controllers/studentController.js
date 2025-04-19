const db = require('../models/db');

// Get all students with their electives
exports.getAllStudents = (req, res) => {
  const sql = `
    SELECT students.*, GROUP_CONCAT(electives.subject_name) AS electives
    FROM students
    LEFT JOIN student_electives ON students.student_id = student_electives.student_id
    LEFT JOIN electives ON student_electives.subject_id = electives.subject_id
    GROUP BY students.student_id
  `;
  db.query(sql, (err, result) => {
    if (err) res.status(500).send(err);
    else res.json(result);
  });
};

// Add a student
exports.addStudent = (req, res) => {
  const { name, roll_number, elective_ids } = req.body;
  db.query('INSERT INTO students (name, roll_number) VALUES (?, ?)', [name, roll_number], (err, result) => {
    if (err) return res.status(500).send(err);
    const studentId = result.insertId;

    const values = elective_ids.map(eid => [studentId, eid]);
    db.query('INSERT INTO student_electives (student_id, elective_id) VALUES ?', [values], (err2) => {
      if (err2) return res.status(500).send(err2);
      res.json({ message: 'Student added successfully' });
    });
  });
};

// Update a student
exports.updateStudent = (req, res) => {
  const { name, roll_number, elective_ids } = req.body;
  const studentId = req.params.id;

  db.query('UPDATE students SET name = ?, roll_number = ? WHERE id = ?', [name, roll_number, studentId], (err) => {
    if (err) return res.status(500).send(err);

    db.query('DELETE FROM student_electives WHERE student_id = ?', [studentId], (err2) => {
      if (err2) return res.status(500).send(err2);

      const values = elective_ids.map(eid => [studentId, eid]);
      db.query('INSERT INTO student_electives (student_id, subject_id) VALUES ?', [values], (err3) => {
        if (err3) return res.status(500).send(err3);
        res.json({ message: 'Student updated successfully' });
      });
    });
  });
};

// Delete a student
exports.deleteStudent = (req, res) => {
  db.query('DELETE FROM students WHERE id = ?', [req.params.id], (err) => {
    if (err) res.status(500).send(err);
    else res.json({ message: 'Student deleted successfully' });
  });
};
