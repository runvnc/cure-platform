/**
 * Module dependencies.
 */

//Load "base" plugin
//The idea is that you could theoretically swap out the entire base
//To change/fix some fundamental things or the initial loading
//of plugins
var util = require('util');

process.on('uncaughtException', function(err) {
  console.log(err.message);
  console.log(err.stack);
});

var base = require('curebase');

//base.start();

var servers = {};

var ejs = require('ejs')
  , express = require('express')
  , deploy = require('./plugins/deploy')
  , util = require('util')
  , _und = require('underscore')
  , billing = require('./plugins/billing')
  , fs = require('fs');

var app = module.exports = express.createServer();

var soptions = {
  key: fs.readFileSync('keys/willsave.pem'),
  cert: fs.readFileSync('keys/willsave.pem'),
  ca: fs.readFileSync('keys/ca.pem')
}
var apps = express.createServer(soptions);

// Configuration

var theme = 'default';

app.configure(function(){
  app.set('views', __dirname);
  app.set('view engine', 'ejs');
//  app.enable('view cache');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/themes/' + theme + '/views/desktop'));
});


app.configure(function(){
  apps.set('views', __dirname);
  apps.set('view engine', 'ejs');
//  app.enable('view cache');
  apps.use(express.bodyParser());
  apps.use(express.methodOverride());
  apps.use(app.router);
  apps.use(express.static(__dirname + '/themes/' + theme + '/views/desktop'));
});


apps.configure('development', function(){
  apps.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

apps.configure('production', function(){
  apps.use(express.errorHandler()); 
});

// Routes

function setHeader(res) {
  res.header('Server', 'Cure 0.1');
}

app.get('/getdetails', function(req, res, next) {
  servers[req.query.server].getDetails(function(dummy, details) {
    res.send(details);
  }); 
});

app.get('/', function(req, res, next) {
  if (('host' in req.headers) && !(req.headers.host.indexOf('node.') == 0)) {
    res.redirect('http://node.willsave.me/');
  }
  next();
});

app.get('/*', function(req, res, next){
    var ua = req.header('user-agent');
    setHeader(res);
    if(/mobile/i.test(ua)) {
        res.render('./themes/' + theme + '/views/mobile/index', {title: 'Cure Mobile', username:'', password:'', existing:'', machine:'', ccnum:""});
    } else {
        if (_und.include(['/','/signup'], req.url)) {
          var page = req.url.substr(1);
          if (page=='') {
            page = 'index';
          }
          res.render('./themes/' + theme + '/views/desktop/'+page, {page: page, title: 'Cure Desktop', email:'', password:'', existing:'', machine:'', ccnum:"", ccexp:""});
       } else {
         next();
       }
    }
});

var billing;

apps.post('/createserver', function(req, res){
  setHeader(res); 
  var data = req.body;
   //deploy.getImages();
  var customerID;
  if (data && 'email' in data && data.email != '') {
    //need to create customer
    var customer = billing.saveCustomer(data.email, data.ccnum, data.ccexp, function(result) {
      if (result.success) {
        console.log('success saving customer! calling makeServer');
        console.log(util.inspect(result));
        makeServer(result.customer, data.machine, res); 
      } else {
        console.log('sending error message to client');
        
        res.send({error: result.message});
      }
    });
  } else {
     console.log('no email');
    //makeServer(req.customerID, data.machine, res);
  }
});


function makeServer(customer, machine, res) {
  console.log('inside of makeserver');
  deploy.createServer(machine, 'willsave.me', function (s) {
    console.log('createServer returned');
    servers[s.id] = s;
    //res.send(s);
    console.log('in makeserver customer is ');
    console.log(util.inspect(customer));
    billing.charge(customer.id, '16.95', 'node.js hosting', function(cres) {
      console.log('result of charge');
      console.log(cres);
      //send email
      
      res.send(s);
    });
  });  
  
}

//deploy.listLinodeDNS();

app.listen(80);
apps.listen(443);
console.log("Express server listening on port %d and 443 in %s mode", app.address().port, app.settings.env);



