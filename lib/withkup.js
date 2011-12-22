(function() {
  var FileGenerator, ck, cli, clientfuncs, fs, generators, mergeover, mustinclude, serv, serverfuncs, todospage, util;
  var __indexOf = Array.prototype.indexOf || function(item) {
    for (var i = 0, l = this.length; i < l; i++) {
      if (this[i] === item) return i;
    }
    return -1;
  };
  ck = require('coffeekup');
  util = require('util');
  fs = require('fs');
  mergeover = function(object, properties) {
    var key, val;
    for (key in properties) {
      val = properties[key];
      object[key] = val;
    }
    return object;
  };
  serv = {};
  cli = {};
  FileGenerator = (function() {
    function FileGenerator(name, path) {
      this.name = name;
      this.path = path;
      this.funcs = {};
    }
    FileGenerator.prototype.add = function(funcs) {
      return this.funcs = mergeover(this.funcs, funcs);
    };
    FileGenerator.prototype.run = function(template, name) {
      var output;
      this.template = template;
      output = ck.render(template, {
        test: 'dummy',
        hardcode: this.funcs
      });
      return fs.writeFile(this.path + '/' + name, output, function(err) {
        if (err) {
          return console.log(err);
        }
      });
    };
    return FileGenerator;
  })();
  generators = {
    client: new FileGenerator('client', 'views'),
    server: new FileGenerator('server', '')
  };
  generators.client.add({
    require: require
  });
  mustinclude = function(items, item) {
    console.log('inside of mustinclude ');
    console.log('items is ' + items);
    console.log('item is ' + item);
    if (!(__indexOf.call(items, item) >= 0)) {
      console.log('adding item');
      return items.push(item);
    } else {
      return console.og('not adding item');
    }
  };
  clientfuncs = {
    headitems: [],
    mustinclude: mustinclude,
    htmlhead: function(title_) {
      return head(function() {
        var item;
        title(title_);
        console.log('headitems is ' + headitems);
        if (typeof headitems !== "undefined" && headitems !== null) {
          return ((function() {
            var _i, _len, _results;
            _results = [];
            for (_i = 0, _len = headitems.length; _i < _len; _i++) {
              item = headitems[_i];
              _results.push(item);
            }
            return _results;
          })()).join();
        }
      });
    },
    htmlpage: function(title_, contentsfunc) {
      doctype(5);
      html(function() {
        return htmlhead(title_);
      });
      return body(function() {
        return contentsfunc();
      });
    },
    jquery: function() {
      return script({
        src: 'js/jquery.js'
      });
    },
    entry: function(field) {
      mustinclude(headitems, jquery);
      return input(field);
    }
  };
  serverfuncs = {
    htmlpage: function(title_, contentsfunc) {
      text("apage = ->\n" + "  htmlpage '" + title_ + "', '" + contentsfunc()(+"'\n"));
      return text(("app.get '/" + title_ + "', (req, res) ->\n") + ("  res.render '" + title_ + "'\n"));
    },
    mustinclude: mustinclude
  };
  generators.client.add(clientfuncs);
  generators.server.add(serverfuncs);
  todospage = function() {
    return htmlpage('To-do', function() {
      return entry('todo');
    });
  };
  generators.client.run(todospage, 'todo');
}).call(this);
