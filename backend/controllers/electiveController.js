const db = require('../models/db');

// Get all electives (subjects)
exports.getAllElectives = (req, res) => {
  db.query('SELECT subject_id, subject_name, subject_code FROM electives', (err, result) => {
    if (err) res.status(500).send(err);
    else res.json(result);
  });
};

// Add new elective
exports.addElective = (req, res) => {
  const { subject_name, subject_code } = req.body;
  db.query('INSERT INTO electives (subject_name, subject_code) VALUES (?, ?)', [subject_name, subject_code], (err) => {
    if (err) res.status(500).send(err);
    else res.json({ message: 'Elective added' });
  });
};

// Update elective
exports.updateElective = (req, res) => {
  const { subject_name, subject_code } = req.body;
  db.query('UPDATE electives SET subject_name = ?, subject_code = ? WHERE subject_id = ?', [subject_name, subject_code, req.params.id], (err) => {
    if (err) res.status(500).send(err);
    else res.json({ message: 'Elective updated' });
  });
};

// Delete elective
exports.deleteElective = (req, res) => {
  db.query('DELETE FROM electives WHERE subject_id = ?', [req.params.id], (err) => {
    if (err) res.status(500).send(err);
    else res.json({ message: 'Elective deleted' });
  });
};
