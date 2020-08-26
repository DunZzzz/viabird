const magick = require('imagemagick');
const fs = require('fs');
const PNG = require('pngjs').PNG;
const pixelmatch = require('pixelmatch');
const glob = require("glob")


module.exports = function(file, cb) {

	if (!file.match(/[jJ][pP][gG]$/))
		throw 'Incorrect image given';

	var pngFilename = file.replace(/^(.*\.)[jJ][pP][gG]$/, '$1') + 'png';

	magick.convert(['-verbose', file, pngFilename], (err, stdout) => {
		if (err) throw err;
		console.log(stdout);
		fs.chmodSync(pngFilename, '0644');
		return cb(pngFilename, 1);
		// UNREACHABLE
		compareImages(pngFilename, (res) => {
			let count = res.filter(n => n == 0).length;

			cb(pngFilename, count);
		});
	});
};


function compareImages(input, callback) {

	let results = []

	let img1 = fs.createReadStream(input).pipe(new PNG()).on('parsed', () => {

		glob('./public/images_photos*/*.png', (err, files) => {

			if (err) throw err;
			let max = files.length + 1;
			const results_cb = () => {
				max--;
				if (max <= 0)
					callback(results);
			}

			results_cb();

			files.forEach((file) => {
				let img2 = fs.createReadStream(file).pipe(new PNG()).on('parsed', () => {
					let diff_occur = 0;
					var diff = new PNG({width: img1.width, height: img1.height});

					pixelmatch(img1.data, img2.data, diff.data, img1.width, img1.height, {
						threshold: 0.3
					});

					for (let i = 0; i != diff.data.length; i += 3) {
						if (diff.data[i + 1] === 0
							&& diff.data[i] === 255
							&& diff.data[i + 2] === 0) {
							diff_occur++;
						}
					}

					console.log(file + ' -> ' + diff_occur);
					results.push(diff_occur);
					results_cb();
				});
			});

		});
	});
}
