var fs = require('fs');

module.exports.move = function move(oldPath, newPath, callback) {

	fs.rename(oldPath, newPath, function (err) {
		if (err) {
			if (err.code === 'EXDEV')
				copy();
			else
				throw err;
			return;
		}
		callback();
	});

	function copy() {
		var readStream = fs.createReadStream(oldPath);
		var writeStream = fs.createWriteStream(newPath);

		readStream.on('error', (err) => {
			throw err;
		});
		writeStream.on('error', (err) => {
			throw err;
		});

		readStream.on('close', function () {
			fs.unlink(oldPath, callback);
		});

		readStream.pipe(writeStream);
	}
}
