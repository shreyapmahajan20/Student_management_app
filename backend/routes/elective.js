const express = require('express');
const router = express.Router();
const controller = require('../controllers/electiveController');

router.get('/', controller.getAllElectives);
router.post('/', controller.addElective);
router.put('/:id', controller.updateElective);
router.delete('/:id', controller.deleteElective);

module.exports = router;
