const express = require('express');
const router = express.Router();
const multiparty = require('multiparty');
const fs = require('fs');
const path = require('path');
const Files = require('../app/files');
const glob = require("glob")

const {check, validationResult} = require('express-validator/check');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.json')[env];
const image_convert = require('../app/image_convert');

router.get('/login', (req, res) => {
	res.render('login');
});

router.get('/logout', (req, res) => {
	req.session.connected = undefined;
	res.redirect('login');
});

done_uploading = true;

router.post('/images/upload', (req, res) => {
	if (done_uploading === true) {
		done_uploading = false
		let form = new multiparty.Form();

		form.parse(req, function(err, fields, files) {
			if (err || fields === undefined) {
				done_uploading = true;
				sendError(res, 'Received Invalid Form.', 400)
			} else if (!files.hasOwnProperty('image')
				|| !Array.isArray(files.image)
				|| files.image.length != 1
				|| files.image[0].fieldName != 'image'
			) {
				done_uploading = true;
				sendError(res, 'Invalid field in Form.', 400)
			} else {
				let image = files.image[0];

				image_convert(image.path, (png_file, count) => {
					let path;
					if (count < 2) {
						path = './public/images_photos/' + Date.now() + '_Viabird.png';
					} else {
						path = './public/images_photos_empty/' + Date.now() + '_Viabird.png';
					}
					Files.move(png_file, path, () => {
						done_uploading = true;
						res.json({
							status: 200,
							success: true
						});
					});
				});
			}
		});
	} else {
		sendError(res, 'Still processing image.', 400)
	}
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
	glob('./public/images_photos/*.png', (err, images) => {
		if (err) throw err;
		for (let i = 0; i != images.length; i++) {
			images[i] = images[i].substring('./public/'.length);
		}
		console.log(images);
		res.render('index', { images: images.reverse() });
	});
});

function sendError(res, error, status) {
	res.status(status);
	res.json({
		data: {
			error: error,
		},
		status: status,
		success: false
	});
}

module.exports = router;
