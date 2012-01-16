



var BoolFormField, FormField, FormRecord, TextFormField, wireadd,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

FormField = (function() {

  function FormField(type, record) {
    this.record = record;
    this.name = type.name;
    this.id = "#" + this.name + "_";
    console.log("id is " + this.id);
    this.type = type.type;
    if (type.required != null) {
      this.required = type.required;
    } else {
      this.required = false;
    }
  }

  FormField.prototype.pullvalue = function() {
    this.val = $(this.id).val();
    console.log("el is " + ($(this.id)));
    return console.log("val is " + this.val);
  };

  FormField.prototype.validate = function() {
    this.pullvalue();
    if (this.required) {
      return (this.val != null) && this.val !== '';
    } else {
      return true;
    }
  };

  return FormField;

})();

TextFormField = (function(_super) {

  __extends(TextFormField, _super);

  function TextFormField() {
    TextFormField.__super__.constructor.apply(this, arguments);
  }

  return TextFormField;

})(FormField);

BoolFormField = (function(_super) {

  __extends(BoolFormField, _super);

  function BoolFormField() {
    BoolFormField.__super__.constructor.apply(this, arguments);
  }

  BoolFormField.prototype.pullvalue = function() {
    return this.val = $(this.id).is(':checked');
  };

  return BoolFormField;

})(FormField);

FormRecord = (function() {

  function FormRecord(type, mode, data) {
    this.type = type;
    this.mode = mode;
    this.data = data != null ? data : {};
    this.name = this.type.name_;
    this.makeFields();
  }

  FormRecord.prototype.selField = function(field) {
    switch (field.type) {
      case 'text':
        return new TextFormField(field, this);
      case 'boolean':
        return new BoolFormField(field, this);
      case void 0:
        return field;
      default:
        return field;
    }
  };

  FormRecord.prototype.makeFields = function() {
    var field, fieldname, _ref, _results;
    this.fields = {};
    _ref = this.type;
    _results = [];
    for (fieldname in _ref) {
      field = _ref[fieldname];
      if (fieldname.lastIndexOf('_') !== fieldname.length - 1) {
        _results.push(this.fields[fieldname] = this.selField(field));
      }
    }
    return _results;
  };

  FormRecord.prototype.validate = function() {
    var field, name, _ref;
    _ref = this.fields;
    for (name in _ref) {
      field = _ref[name];
      if (!field.validate()) return false;
    }
    return true;
  };

  FormRecord.prototype.save = function() {
    var field, name, _ref;
    if (this.validate()) {
      _ref = this.fields;
      for (name in _ref) {
        field = _ref[name];
        this.data[name] = field.val;
      }
      if (this.mode === 'new') {
        console.log("data is");
        console.log(this.data);
        return now.dbinsert(this.name, this.data);
      }
    } else {
      return false;
    }
  };

  return FormRecord;

})();

wireadd = function(type) {
  var rec, recname;
  recname = 'rec_' + type.name_;
  rec = window[recname] = new FormRecord(type, 'new');
  return $("#btnadd" + type.name_).click(function() {
    if (rec.save()) return alert('Saved.');
  });
};






