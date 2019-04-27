var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
const nunjucks = require('nunjucks');
var session = require('express-session');

var app = express();

app.set('trust proxy', 1); // trust first proxy


app.use(session({
	secret: 'VerySecureSecret7-56§:?@43%',
	key: 'session_cookie_name',
	resave: false,
	saveUninitialized: false
}));

nunjucks.configure('views', {
	express: app,
	autoescape: true
});

app.set('view engine', 'html');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({extended: false}));
app.use(cookieParser());

app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);

module.exports = app;
