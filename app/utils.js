const cryptoRandomString = require('crypto-random-string');
let crypto = require('crypto');

module.exports.genToken = () => {
	return cryptoRandomString(16);
};

module.exports.hashPass = (pass) => {
	return crypto.createHash('sha256').update(pass).digest('hex');
};

module.exports.token = (cb) => {
	return (req, res) => {
		let token = req.get('token');

		if (token === undefined)
			res.json(module.exports.genRes({
				title: 'Token',
				content: 'field token need to exist'
			}, 400, false));
		else
			cb(token);
	};
};
