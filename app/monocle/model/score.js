// Generated by CoffeeScript 1.6.3
var _ref,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

__Model.Score = (function(_super) {
  __extends(Score, _super);

  function Score() {
    _ref = Score.__super__.constructor.apply(this, arguments);
    return _ref;
  }

  Score.fields("score");

  Score.prototype.validate = function() {
    if (!this.score) {
      return "La calificacion es requerida";
    }
  };

  return Score;

})(Monocle.Model);
