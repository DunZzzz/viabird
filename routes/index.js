var express = require('express');
var router = express.Router();
var fs = require('fs');


const {check, validationResult} = require('express-validator/check');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.json')[env];

router.get('/login', (req, res) => {
	res.render('login');
});

router.get('/logout', (req, res) => {
	req.session.connected = undefined;
	res.redirect('login');
});

router.post('/login', [
	check('username')
	.exists()
	.isString()
	.not().isEmpty()
	.trim(),
	check('password')
	.exists()
	.isString()
	.not().isEmpty()
	.trim(),
], (req, res) => {
	const errors = validationResult(req);
	if (!errors.isEmpty())
		return res.status(422).render('login', {errors: JSON.stringify(errors.array())});
	if (req.body.username != config.username || req.body.password !== config.password)
		return res.render('login');
	req.session.connected = true;
	res.redirect('/');
});

router.use('/', (req, res, next) => {
	if (req.session.connected !== true)
		return void res.redirect('/login');
	next();
});

router.get('/', (req, res) => {
	fs.readdir('./public/images_photos', (err, images) => {
		res.render('index', { images: images.reverse() });
	});
});

module.exports = router;
